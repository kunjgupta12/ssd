const mongoose=require('mongoose');
const userModel=require('../models/user_model')
const db=require('../config/db');
const{Schema}=mongoose;
const todoSchema=new Schema({
    userId:{
type:Schema.Types.ObjectId,
ref:userModel.modelName
    },
    title:{
        type:String,
        require:true

    },
    desc:{
        type:String,
     
        require:true,
       
    }
},{timestamps:true});

const TodoModel=db.model('todo',todoSchema);
module.exports=TodoModel;