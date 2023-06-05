const express = require('express');
const router = express.Router();
//import models
const Note = require("./../models/Note");


//note route

router.get('/',async function (req, res) {
    const items = await Note.find();
    const response = {message:'fetched data successfully',status:200,data:items};
    res.json(response);
});

router.post('/store',async function (req, res) {
    //res.json(req.body)
    const newNote = new Note(
        {
            userid:req.body.userid,
            title:req.body.title,
            content:req.body.content,
        }
    );
    const item = await newNote.save();
    const response = {message:'note save successfully',status:200,data:item};
    res.json(response);
});

router.get('/:userid',async function (req, res) {
    const item = await Note.find({userid:req.params.userid});
    const response = {message:'fetched data successfully',status:200,data:item};
    res.json(response);
});

router.put('/:id',async function (req, res) {
    //res.json(req.params.id);
    const item = await Note.findByIdAndUpdate(req.params.id,{
        $set:req.body,
    },{
        new:true
    });
    const response = {message:'data updated successfully',status:200,data:item};
    res.json(response);
});

router.delete('/:id',async function (req, res) {
    const note = await Note.findById(req.params.id);
    await note.deleteOne();
    const response = {message:'data deleted successfully',status:200};
    res.json(response);
});

module.exports = router;