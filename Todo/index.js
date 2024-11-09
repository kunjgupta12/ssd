const app=require('./app');
const db=require('./config/db');
const userModel=require('./models/user_model');
const TodoModel=require('./models/todo.model');

const port=3000;
app.get('/',(req,res)=>{
    res.send('Hello Worl\d')
});
app.listen(port,()=>{
    console.log((port));
});