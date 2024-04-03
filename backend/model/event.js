const mongoose = require("mongoose");

const eventSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Vui lòng nhập tên sản phẩm!"],
  },
  description: {
    type: String,
    required: [true, "Vui lòng nhập mô tả!"],
  },
  category: {
    type: String,
    required: [true, "Chọn danh mục chạy sự kiện!"],
  },
  start_Date: {
    type: Date,
    required: true,
  },
  end_Date: {
    type: Date,
    required: true,
  },
  status: {
    type: String,
    default: "Đang hoạt động",
  },
  tags: {
    type: String,
  },
  originalPrice: {
    type: Number,
  },
  discountPercent: {
    type: Number,
    required: [true, "Giá giảm!"],
  },
  sellPrice: {
    type: Number,
  },
  stock: {
    type: Number,
    required: [true, "Số lượng tồn!"],
  },
  images: {
    type: [String],
  },
  employeeId: {
    type: String,
    required: true,
  },
  employee: {
    type: Object,
    required: true,
  },
  sold_out: {
    type: Number,
    default: 0,
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
});

module.exports = mongoose.model("Event", eventSchema);
