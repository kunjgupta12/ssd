import 'package:socket_chat/chatScreen.dart';
import 'package:socket_chat/loginscareen.dart';

import 'chatUserScreen.dart';

class Routes {
  static routes() {
    return {
      LoginScreen.ROUTE_ID: (context) => LoginScreen(),
      ChatUserScreen.ROUTE_ID: (context) => ChatUserScreen(),
      Chat.ROUTE_ID: (context) => Chat(),
    };
  }

  static initScreen() {
    return LoginScreen.ROUTE_ID;
  }
}
