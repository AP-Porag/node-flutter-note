const mongoose = require('mongoose');
//define schema
const schema = mongoose.Schema(
    {
        userid:{
            type:String,
            required:true
        },
        title:{
            type:String,
            required:true
        },
        content:{
            type:String,
        },
    },
    {
        timestamps: {
            createdAt: 'created_at',
            updatedAt: 'updated_at'
        }
    }
);
//create model & export
module.exports = mongoose.model('Note',schema);