const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const employeeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Nhập tên dược sĩ!"],
  },
  phoneNumber: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: [true, "Nhập địa chỉ dược sĩ"],
  },
  password: {
    type: String,
    required: [true, "Xin nhập mật khẩu"],
    minLength: [6, "Mật khẩu phải từ 6 ký tự"],
    select: false,
  },
  // description: {
  //   type: String,
  // },
  role: {
    type: String,
    default: "doctor",
  },
  avatar: String,
  // avatar: {
  //   public_id: {
  //     type: String,
  //   },
  // },
  //     required: true,
  //   },
  //   url: {
  //     type: String,
  //     required: true,
  //   },
  // },
  // zipCode: {
  //   type: Number,
  //   required: true,
  // },
  // withdrawMethod: {
  //   type: Object,
  // },
  // availableBalance: {
  //   type: Number,
  //   default: 0,
  // },
  // transections: [
  //   {
  //     amount: {
  //       type: Number,
  //       required: true,
  //     },
  //     status: {
  //       type: String,
  //       default: "Processing",
  //     },
  //     createdAt: {
  //       type: Date,
  //       default: Date.now(),
  //     },
  //     updatedAt: {
  //       type: Date,
  //     },
  //   },
  // ],
  createdAt: {
    type: Date,
    default: Date.now(),
  },
  resetPasswordToken: String,
  resetPasswordTime: Date,
});

// Hash password
employeeSchema.pre("save", async function (next) {
  if (!this.isModified("password")) {
    next();
  }
  this.password = await bcrypt.hash(this.password, 10);
});

// jwt token
employeeSchema.methods.getJwtToken = function () {
  return jwt.sign({ id: this._id }, process.env.JWT_SECRET_KEY, {
    expiresIn: process.env.JWT_EXPIRES,
  });
};

// comapre password
employeeSchema.methods.comparePassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
};

module.exports = mongoose.model("Employee", employeeSchema);
