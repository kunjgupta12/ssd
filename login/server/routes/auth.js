const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const authRouter = express.Router();
//const jwt = require("jsonwebtoken");
//const auth = require("../middleware/auth");

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
  try {const {name,email,password}=
    req.body;
    
    console.log(name)
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = User({
      name,
      email,
      password: hashedPassword
    //  name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log(User.name)
    //console.log(name);
    res.status(500).json({ error: e.message });
  }
});

// Sign In

module.exports = authRouter;