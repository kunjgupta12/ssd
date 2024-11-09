import 'package:socket_chat/user.dart';

class G {
  static List<User>? dummyUser;
  static User? logginUser;
  static User? toChatUser;

  static void initDummyUser() {
    User userA = User(id: 1000, name: 'A', email: 'kunj@gmail.com');
    User userB = User(id: 1000, name: 'B', email: 'kunjg@gmail.com');
    dummyUser = <User>[];
    dummyUser!.add(userB);
    dummyUser!.add(userA);
  }

  static List<User>? getUsersFor(User user) {
    List<User>? filteredUsers = dummyUser
        ?.where(
            (u) => (!u.name!.toLowerCase().contains(user.name!.toLowerCase())))
        .toList();
    return filteredUsers;
  }
}
