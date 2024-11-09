
const { deleteToDo } = require("../controller/todo.controller");

const TodoModel=require('../models/todo.model');
class Todoservices{
    static async createTodo(userId,title,desc){
const createTodo=new TodoModel({
    userId,title,desc
});
return await createTodo.save();
    }
    static async getUserToDoList(userId){

        const todoList=await TodoModel.find({userId})
        return todoList;
            }
            static async deleteToDo(id){
                const deleted = await TodoModel.findByIdAndDelete({_id:id})
                return deleted;
           }
}
module.exports=Todoservices;