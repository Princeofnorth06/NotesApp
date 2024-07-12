const express=require('express');
const router=express.Router();
const Note=require('./model/Note');

router.post('/list',async(req,resp)=>{
    var notes=await Note.find({userid :req.body.userid});
    
    resp.json(notes)
})


router.post('/add',async(req,resp)=>{
    await Note.deleteOne({id:req.body.id})
    const newnote=new Note(req.body)
    
    const result=await newnote.save();
    console.log(result)
    if(result.acknowledged){
        console.log('Added')
    }
    
    resp.json(result)
})


router.post('/delete',async(req,resp)=>{
    await Note.deleteOne({id:req.body.id})
    resp.json('Deleted')
})
module.exports=router;