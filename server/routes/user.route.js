const express=require("express");
const UserModel =require("../model/UserModel")
const bcrypt=require("bcryptjs")
const userRoute=express.Router()  
const jwt=require("jsonwebtoken")



//User login
userRoute.post("/login",async(req,res)=>{
  const {email,password}=req.body;
  if(email&&password){
        try{
            const userData=await UserModel.findOne({email});
            if(userData){
                //user password
                //hashed password
                const isMatch=await bcrypt.compare(password,userData.password);

                if(isMatch){

                    //token 
                    const token=jwt.sign({"userid":userData._id},process.env.JWT)
                    res.status(200).send({msg:"Login Success",token:token,role:userData.memberType})

                }else{
                    res.status(400).send({"msg":"Wrong Password"})
                }


            }else{
                res.status(404).send({"msg":"No Account Found"})
            }

        }catch(err){
            res.status(400).send({"msg":err.message})
        }
  }else{
    res.status(400).send({"msg":"Email & password required"})
  }
})


//Signup

userRoute.post("/signup",async(req,res)=>{
    const {name,email,password}=req.body;

    if(name&&email&&password){
        try{   
            const existingUser=await UserModel.findOne({email})
            if(existingUser){
                return res.status(409).send({msg:"Account already exists"})
            }
            const hashed_password=await bcrypt.hash(password,12)
            const newUser=await UserModel({...req.body,password:hashed_password})

            await newUser.save();

            res.status(201).send({"msg":"Signup Successful"})
        }catch(err){
            res.status(500).send({msg:err.message})
        }
    }else{
        res.status(400).send({msg:"Validation Failed"})
    }
})

module.exports={userRoute}
