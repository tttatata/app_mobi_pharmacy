const express = require("express");
const ErrorHandler = require("./middleware/error");
const app = express();
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const cors = require("cors");

//
app.use(express.json());
app.use(cookieParser());
app.use(
  cors({
    origin: "http://localhost:3000",
    credentials: true,
  })
);
app.use("/", express.static("uploads"));
app.use(bodyParser.urlencoded({ extended: true }));

//config
if (process.env.NODE_ENV !== "PRODUCTION") {
  require("dotenv").config({
    path: "backend/config/.env",
  });
}

//import routes
const user = require("./controller/user");
const employee = require("./controller/employee");
const product = require("./controller/product");
const event = require("./controller/event");

//tổ chức ứng dụng của mình thành các phần
//(như user, employee, product, etc.) và quản lý chúng một cách dễ dàng thông qua các router riêng biệt.
app.use("/api/v2/user", user);
app.use("/api/v2/employee", employee);
app.use("/api/v2/product", product);
app.use("/api/v2/event", event);

//Error Handling
app.use(ErrorHandler);
module.exports = app;
