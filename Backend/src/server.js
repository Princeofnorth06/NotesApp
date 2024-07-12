const uri = "mongodb+srv://princeofnorth80066:Prince123@cluster0.wemiyi8.mongodb.net/notesdb";
const express = require('express');
const mongoose = require('mongoose');
//https://notesapp-suda.onrender.com/
const app = express();
app.use(express.json());

mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });

app.get('/', async (req, res) => {
    const responses = { message: "Welcome to Notes World" };
    res.json(responses);
});

const noterouter = require('./routes');
app.use('/notes', noterouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
    console.log('Server started at Port ' + PORT);
});
