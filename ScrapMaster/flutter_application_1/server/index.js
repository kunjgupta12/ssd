const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);


//connectiuons
mongoose
  .connect('mongodb+srv://kunj12:Kunjgupta12@cluster0.rnakhui.mongodb.net/?retryWrites=true&w=majority')
  .then(() => {
    console.log("Connection successful");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT,"0.0.0.0", () => {
  console.log(`connected at port ${PORT} `);
});
