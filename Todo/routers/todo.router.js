const router=require('express').Router();
const TodoController=require('../controller/todo.controller');
router.post('/storeTodo',TodoController.createTodo);
router.get('/getUserTodoList',TodoController.getToDoList);

router.post("/deleteTodo",TodoController.deleteToDo);
module.exports=router;