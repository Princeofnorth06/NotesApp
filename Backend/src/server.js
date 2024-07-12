const uri="mongodb+srv://princeofnorth80066:Prince123@cluster0.wemiyi8.mongodb.net/notesdb";
const express=require('express');

const mongoose=require('mongoose');

const app=express();
app.use(express.json());

 mongoose.connect(uri);

app.get('/',async(req,resp)=>{
    const responses={ message:"Welcome to Notes World"}
    resp.json(responses);
    resp.send(responses);
})
const noterouter=require('./routes');
app.use('/notes',noterouter);

const PORT= process.env.PORT || 5000;
app.listen(5000,function(){
    console.log('Server started at Port'+PORT)
})