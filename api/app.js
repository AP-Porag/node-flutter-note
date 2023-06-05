const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const noteRouter = require('./src/routes/note');


const app = express();
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
mongoose.connect('mongodb+srv://admin:MYppDpXfRdktjrah@cluster0.unvsbsj.mongodb.net/node_flutter_notes')
    .then(function () {
    //starting route
    app.get('/',function (req, res) {
        res.send('node flutter note api');
    });

    app.use('/notes',noteRouter);

    console.log('database connected successfully')
}).catch(function (error) {
    console.log(error)
})


//listening port
const PORT = process.env.PORT || 5000;
app.listen(PORT,function () {
    console.log('App running on port: '+PORT)
})