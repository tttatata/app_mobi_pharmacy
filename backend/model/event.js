const mongoose = require("mongoose");

const eventSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Vui lòng nhập tên sự kiện!"],
  },
  description: {
    type: String,
    required: [true, "Vui lòng nhập mô tả"],
  },
  category: {
    type: String,
    required: [true, "Vui lòng chọn danh mục sản phẩm!"],
  },
  start_Date: {
    type: Date,
    required: true,
  },
  Finish_Date: {
    type: Date,
    required: true,
  },
  status: {
    type: String,
    default: "Running",
  },
  tags: {
    type: String,
  },
  originalPrice: {
    type: Number,
  },
  discountPrice: {
    type: Number,
    required: [true, "Nhập giá tiền sau khi giảm!"],
  },
  stock: {
    type: Number,
    required: [true, "Nhập số lượng tồn sản phẩm!"],
  },
  images: [
    {
      public_id: {
        type: String,
        required: true,
      },
      url: {
        type: String,
        required: true,
      },
    },
  ],
  shopId: {
    type: String,
    required: true,
  },
  shop: {
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
