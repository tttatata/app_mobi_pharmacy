const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "Vui lòng nhập tên sản phẩm!"],
  },
  description: {
    type: String,
    required: [true, "Vui lòng nhập mô tả sản phẩm"],
  },
  category: {
    type: String,
    required: [true, "Vui lòng chọn danh mục sản phẩm"],
  },
  origin: {
    type: String,
    required: [true, "Vui lòng chọn xuất xứ"],
  },
  entryDate: {
    type: Date,
  },
  expiryDate: {
    type: Date,
  },
  tags: {
    type: String,
  },
  quantity: {
    type: String,
  },
  brand: {
    type: String,
  },
  specifications: {
    type: String,
    required: function() {
      return this.category !== "Thiết bị y tế";
    },
  },
  unit: {
    type: String,
    required: function() {
      return this.category !== "Thiết bị y tế";
    },
  },
  ingredient: {
    type: String,
  },
  weight: {
    type: String,
  },
  material: {
    type: String,
  },
  guarantee: {
    type: String,
  },
  originalPrice: {
    type: Number,
    required: [true, "Vui lòng nhập giá nhập vào!"],
  },
  vat: {
    type: Number,
  },
  sellPrice: {
    type: Number,
  },
  stock: {
    type: Number,
    required: [true, "Please enter your product stock!"],
  },
  images: {
    type: [String],
  },
  reviews: [
    {
      user: {
        type: Object,
      },
      rating: {
        type: Number,
      },
      comment: {
        type: String,
      },
      productId: {
        type: String,
      },
      createdAt: {
        type: Date,
        default: Date.now(),
      },
    },
  ],
  ratings: {
    type: Number,
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

module.exports = mongoose.model("Product", productSchema);
