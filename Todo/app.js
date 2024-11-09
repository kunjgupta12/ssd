const express=require('express');
const bodyParser=require('body-parser');
const UserRouter=require('./routers/user.router');
const TodoRouter=require('./routers/todo.router');

const app=express();
app.use(bodyParser.json());
app.use('/',UserRouter);
app.use('/',TodoRouter);

module.exports=app;