import 'user.dart';

class Conversation {
  String id;

  // nombre de conversación, por ejemplo, chatear con el nombre del restaurante
  String name;

  // Chats messages
  String lastMessage;

  int lastMessageTime;

  // Identificadores de los usuarios que leen el mensaje de chat
  List<String> readByUsers;

  // Identificadores de usuarios en esta conversación
  List<String> visibleToUsers;

  // usuarios en la conversación
  List<User> users;

  Conversation(this.users, {this.id = null, this.name = ''}) {
    visibleToUsers = this.users.map((user) => user.id).toList();
    readByUsers = [];
  }

  Conversation.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';
      readByUsers = jsonMap['read_by_users'] != null ? List.from(jsonMap['read_by_users']) : [];
      visibleToUsers = jsonMap['visible_to_users'] != null ? List.from(jsonMap['visible_to_users']) : [];
      lastMessage = jsonMap['message'] != null ? jsonMap['message'].toString() : '';
      lastMessageTime = jsonMap['time'] != null ? jsonMap['time'] : 0;
      users = jsonMap['users'] != null
          ? List.from(jsonMap['users']).map((element) {
              element['media'] = [
                {'thumb': element['thumb']}
              ];
              return User.fromJSON(element);
            }).toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      readByUsers = [];
      users = [];
      lastMessage = '';
      lastMessageTime = 0;
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["users"] = users.map((element) => element.toRestrictMap()).toSet().toList();
    map["visible_to_users"] = users.map((element) => element.id).toSet().toList();
    map["read_by_users"] = readByUsers;
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    return map;
  }

  Map toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    map["read_by_users"] = readByUsers;
    return map;
  }
}
