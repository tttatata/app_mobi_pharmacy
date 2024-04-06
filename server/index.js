/*client ->middleware-> server -> client*/

// import from pakages
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
const DB = "mongodb+srv://Thanh2506:25062001@cluster0.rnjqedv.mongodb.net";
// import from other files
const authRouter = require('./routes/auth');
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
//init
const PORT = 3000;
const app = express();
// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Connections
mongoose.connect(DB).then(() => {
    console.log("kết nối thành công csdl");

}).catch((e) => {
    console.log(e);
});
app.listen(PORT, "0.0.0.0", () => {
    console.log(`kết nối bằng port ${PORT}`);
});
//localhost
