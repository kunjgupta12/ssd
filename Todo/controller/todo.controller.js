const Todoservices=require('../services/todo.services');
exports.createTodo=async (req,res,next)=>{
    try {
        const {userId,title,desc}=req.body;
        let todo=await Todoservices.createTodo(userId,title,desc);
        res.json({status:true,success:todo
         } );
    } catch (error) {
        next(error);
    }
}

exports.getToDoList=async (req,res,next)=>{
    try {
        const {userId}=req.body;
        let todoData=await Todoservices.getUserToDoList(userId);
        res.json({status:true,success:todoData
         });
    } catch (error) {
        console.log(error);
        next(error);
    }
}
exports.deleteToDo =  async (req,res,next)=>{
    try {
        const { id } = req.body;
        let deletedData = await Todoservices.deleteToDo(id);
        res.json({status: true,success:deletedData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }


}