const { Router } = require("express");
const router = Router();
const mysqlconnection = require("../database/database");
router.get("/", (req, res) => {
  res.status(200).json("Server on port :8000 and database is connected");
});
router.get("/:users", (req, res) => {
  mysqlconnection.query("select * from user", (error, rows, fields) => {
    if (!error) {
      res.json(rows);
    } else {
      console.log(error);
    }
  });
});
router.get("/:users/:id", (req, res) => {
  const { id } = req.params;
  mysqlconnection.query(
    "select * from user where id= ? ",
    [id],
    (error, rows, fields) => {
      if (!error) {
        res.json(rows);
      } else {
        console.log(error);
      }
    }
  );
});
router.post("/:users", (req, res) => {
  const { id, username, name, lastname, mail, randomstr, hash } = req.body;
  console.log(req.body);
  mysqlconnection.query(
    "insert into user(id,username,name,lastname,mail,randomstr,hash) values(?,?,?,?,?,?,?)",
    [id, username, name, lastname, mail, randomstr, hash],
    (error, rows, fields) => {
      if (!error) {
        res.json({
          Status: "User saved",
        });
      } else {
        console.log(error);
      }
    }
  );
});
router.put("/:users/:id", (req, res) => {
  const { id, username, name, lastname, mail, randomstr, hash } = req.body;
  console.log(req.body);
  mysqlconnection.query(
    "update user set username=? ,name= ?,lastname= ?,mail= ?,randomstr=? ,hash=?",
    [id, username, name, lastname, mail, randomstr, hash],
    (error, rows, fields) => {
      if (!error) {
        res.json({ Status: "user updated" });
      } else {
        console.log(error);
      }
    }
  );
});
router.delete("/:users/:id", (req, res) => {
  const { id } = req.params;
  mysqlconnection.query(
    "delete  from user where id=?;",
    [id],
    (error, rows, fields) => {
      if (!error) {
        res.json({ Status: "User deleted" });
      } else {
        res.json({ Status: error });
      }
    }
  );
});
module.exports = router;
