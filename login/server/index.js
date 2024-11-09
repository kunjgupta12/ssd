const express=require("express");
const mongoose=require("mongoose");
const authRouter = require("./routes/auth.js");
const PORT =process.env.PORT||3000;
const app=express();
app.use(authRouter);
app.use(express.json());
const DB='mongodb+srv://kunjgupta54:kunjgupta54@cluster0.qqdqgcr.mongodb.net/?retryWrites=true&w=majority';
mongoose.connect(DB).then(()=>{
    console.log('Connection success');
})
.catch((e)=>{
    console.log(e);
});
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);

});
