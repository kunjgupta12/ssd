console.log("hello");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

const Room = require("./models/room");
var io = require("socket.io")(server);
app.use(express.json());
const DB =
  "mongodb+srv://kunj122:kunj122@cluster0.rnakhui.mongodb.net/?retryWrites=true&w=majority";
io.on("connection", (socket) => {
  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    try {
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();
      console.log(room);
      const roomId = room._id;

      socket.join(roomId);
      // io -> send data to everyone
      // socket -> sending data to yourself
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });

  console.log("connected");
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter Valid room Id");
        return;
      }
      let room = await Room.findById(roomId);
      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id,
          playerType: "0",
        };
        console.log()
        socket.join(roomId);
        room.players.push(player);
        room = await room.save();
        room.isJoin=false;
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, try again later."
        );
      }
    } catch (error) {
      console.log(e);
    }
  });
});
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection success");
  })
  .catch((e) => {
    console.log(e);
  });
server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on ${port}`);
});
