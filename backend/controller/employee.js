const express = require("express");
const path = require("path");
const router = express.Router();
const fs = require("fs");
const jwt = require("jsonwebtoken");
const sendMail = require("../utils/sendMail");
// const sendToken = require("../utils/jwtToken");
const { isAuthenticated, isDoctor } = require("../middleware/auth");
const Employee = require("../model/employee");
const ErrorHandler = require("../utils/ErrorHandler");
const { upload } = require("../multer");
const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const sendDoctorToken = require("../utils/doctorToken");

router.post("/doctor-create", upload.single("file"), async (req, res, next) => {
  try {
    const { email } = req.body;
    const doctorEmail = await Employee.findOne({ email });

    if (doctorEmail) {
      const filename = req.file.filename;
      const filePath = `uploads/${filename}`;
      fs.unlink(filePath, (err) => {
        if (err) {
          console.log(err);
          res.status(500).json({ message: "Lỗi xóa file ảnh" });
        }
      });
      return next(new ErrorHandler("Email đã được sử dụng", 400));
    }
    const filename = req.file.filename;
    const fileUrl = path.join(filename);
    const employee = {
      name: req.body.name,
      phoneNumber: req.body.phoneNumber,
      address: req.body.address,
      email: email,
      password: req.body.password,
      avatar: fileUrl,
    };

    const activationToken = createActivationToken(employee);

    //Dẫn tới trang kích hoạt tài khoản
    const activationUrl = `http://localhost:3000/doctor/activation/${activationToken}`;

    try {
      await sendMail({
        email: employee.email,
        subject: "Kích hoạt tài khoản",
        message: `Xin chào ${employee.name}, vui lòng nhấn vào đường link sau để kích hoạt tài khoản dược sĩ: ${activationUrl}`,
      });
      res.status(201).json({
        success: true,
        message: `Vui lòng kiểm tra email: ${employee.email} để kích hoạt tài khoản!`,
      });
    } catch (error) {
      return next(new ErrorHandler(error.message, 500));
    }
  } catch (error) {
    return next(new ErrorHandler(error.message, 400));
  }
});

// Tạo token kích hoạt tối đa 3 phút
const createActivationToken = (employee) => {
  return jwt.sign(employee, process.env.ACTIVATION_SECRET, {
    expiresIn: "3m",
  });
};

//activate user
router.post(
  "/activation",
  catchAsyncErrors(async (req, res, next) => {
    try {
      const { activation_token } = req.body;
      const newDoctor = jwt.verify(
        activation_token,
        process.env.ACTIVATION_SECRET
      );

      if (!newDoctor) {
        return next(new ErrorHandler("Invalid token", 400));
      }
      const { name, phoneNumber, address, email, password, avatar } = newDoctor;

      let doctor = await Employee.findOne({ email });

      if (doctor) {
        // Nếu người dùng đã tồn tại, có thể cập nhật thông tin của họ nếu cần thiết
        doctor.name = name;
        doctor.phoneNumber = phoneNumber;
        doctor.address = address;
        doctor.email = email;
        doctor.password = password;
        doctor.avatar = avatar;
      } else {
        // Nếu người dùng chưa tồn tại, tạo mới người dùng
        doctor = await Employee.create({
          name,
          phoneNumber,
          address,
          email,
          password,
          avatar,
        });
      }

      sendDoctorToken(doctor, 201, res);
    } catch (error) {
      return next(new ErrorHandler(error.message, 500));
    }
  })
);

//login doctor
router.post(
  "/login-doctor",
  catchAsyncErrors(async (req, res, next) => {
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        return next(new ErrorHandler("Vui lòng nhập đầy đủ thông tin!", 400));
      }

      //Kiểm tra email và password
      const user = await Employee.findOne({ email }).select("+password");

      if (!user) {
        return next(new ErrorHandler("Người dùng không tồn tại", 400));
      }

      const isPasswordValid = await user.comparePassword(password);

      if (!isPasswordValid) {
        return next(new ErrorHandler("Sai mật khẩu", 400));
      }

      sendDoctorToken(user, 201, res);
    } catch (error) {
      return next(new ErrorHandler(error.message, 500));
    }
  })
);

//load user
router.get(
  "/getDoctor",
  isDoctor,
  catchAsyncErrors(async (req, res, next) => {
    try {
      const doctor = await Employee.findById(req.doctor._id);

      if (!doctor) {
        return next(new ErrorHandler("Người dùng không tồn tại", 400));
      }

      res.status(200).json({
        success: true,
        doctor,
      });
    } catch (error) {
      return next(new ErrorHandler(error.message, 500));
    }
  })
);

//Đăng xuất
//Xóa cookie sẽ đăng xuất tài khoản
router.get(
  "/logout",
  catchAsyncErrors(async (req, res, next) => {
    try {
      res.cookie("doctor_token", null, {
        expires: new Date(Date.now()),
        httpOnly: true,
      });
      res.status(201).json({
        succes: true,
        message: "Đăng xuất thành công",
      });
    } catch (error) {
      return next(new ErrorHandler(error.message, 500));
    }
  })
);

module.exports = router;
