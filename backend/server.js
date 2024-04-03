const app = require("./app");
const connectDatabase = require("./db/Database");

//handling uncaught exception
process.on("uncaughtException", (err) => {
  console.log(`Error: ${err.message}`);
  console.log(`Server bị tắt vì lỗi`);
});

//config
if (process.env.NODE_ENV !== "PRODUCTION") {
  require("dotenv").config({
    path: "backend/config/.env",
  });
}

//connect db
connectDatabase();

//create server
const server = app.listen(process.env.PORT, () => {
  console.log(`Server is running on http://localhost:${process.env.PORT}`);
});

//unhanle process rejection
process.on("unhandledRejection", (err) => {
  console.log(`Shutting server error ${err.message}`);
  console.log(`shuttin down the server unhale process rejection`);

  server.close(() => {
    process.exit(1);
  });
});
