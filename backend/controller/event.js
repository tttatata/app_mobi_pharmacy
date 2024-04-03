const express = require("express");
const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const ErrorHandler = require("../utils/ErrorHandler");
const Employee = require("../model/employee");
const Event = require("../model/event");
const { upload } = require("../multer");
const router = express.Router();

//Tạo sản phẩm mới
router.post(
  "/create-event",
  upload.array("images"),
  catchAsyncErrors(async (req, res, next) => {
    try {
      const employeeId = req.body.employeeId;
      const employee = await Employee.findById(employeeId);
      if (!employee) {
        return next(new ErrorHandler("Mã nhân viên không tồn tại", 400));
      } else {
        const files = req.files;
        const imageUrls = files.map((file) => `${file.filename}`);

        const eventData = req.body;
        eventData.images = imageUrls;
        eventData.employee = employee;

        const product = await Event.create(eventData);
        res.status(201).json({
          success: true,
          product,
        });
      }
    } catch (error) {
      return next(new ErrorHandler(error, 400));
    }
  })
);

module.exports = router;
