const express=require('express');
const Document=require('../models/document');
const documentRouter=express.Router();
const auth=require('../middleware/auth');

documentRouter.post('/doc/create' ,auth,async(req,res)=>{
try {
    

    const {createdAt}=req.body;
    let document=new Document({


        uid:req.user,
        title:'Untitled Document',
        createdAt
    });
document=await document.save();
res.json(document);

} catch (error) {
    res.status(500).json({error:error.message});
}
});
documentRouter.get('/doc/me',auth,async(req,res)=>{
    try{
        let documents=await Document.find({uid:req.user});
res.json(documents);
    } catch(e){
res.status(500).json({error:e.message})
    }
});
module.exports=documentRouter;
