const ErrorHandler = require("../utils/ErrorHandler");
const catchAsyncErrors = require("./catchAsyncErrors");
const jwt = require("jsonwebtoken");
const User = require("../model/user");
const Employee = require("../model/employee");
// const Shop = require("../model/shop");

//Người dùng
exports.isAuthenticated = catchAsyncErrors(async (req, res, next) => {
  const { token } = req.cookies;

  if (!token) {
    return next(new ErrorHandler("Vui lòng đăng nhập để sử dụng", 401));
  }

  const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);

  req.user = await User.findById(decoded.id);

  next();
});

//bác sĩ
exports.isDoctor = catchAsyncErrors(async (req, res, next) => {
  const { doctor_token } = req.cookies;
  if (!doctor_token) {
    return next(new ErrorHandler("Vui lòng đăng nhập để sử dụng", 401));
  }

  const decoded = jwt.verify(doctor_token, process.env.JWT_SECRET_KEY);

  req.doctor = await Employee.findById(decoded.id);

  next();
});

// exports.isAdmin = (...roles) => {
//   return (req, res, next) => {
//     if (!roles.includes(req.user.role)) {
//       return next(
//         new ErrorHandler(`${req.user.role} Không có quyền truy cập!`)
//       );
//     }
//     next();
//   };
// };
