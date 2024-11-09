const mysql = require("mysql");
const mysqlconnection = mysql.createConnection({
  host: "localhost",
  user: "root",
  //password: "1234",
  database: "company",
});
mysqlconnection.connect(function (error) {
  if (error) {
    console.log(error);
    return;
  } else {
    console.log("database is connnected");
  }
});
module.exports = mysqlconnection;
