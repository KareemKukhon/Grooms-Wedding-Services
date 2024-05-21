import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:Rafeed/models/chatModel.dart";
import "package:Rafeed/models/messageModel.dart";
import "package:Rafeed/var/var.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class ChatService extends ChangeNotifier {
  List<Message> messages = [];
  addMessage(Message message) {
    messages.add(message);

    log(messages.length.toString());
    notifyListeners();
  }

  sendMessage(Map<String, dynamic> map, String id, {File? image}) async {
    ///map expected : {
    ///   "message":"your message", (if the message was an Image just put any data or leave it empty, the server handles the rest)
    ///   "receiver_id":"id",
    ///   "type":"TEXT OR IMAGE"
    /// }
    if (image != null) {
      var request = http.MultipartRequest(
          'PUT', Uri.parse("$server/rest/chat/$id/message"));

      map.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      request.headers.addAll(
          {'content-type': 'multipart/form-data', "authorization": auth});
      request.files.add(await http.MultipartFile.fromPath(
        "file",
        image.path,
      ));
      final response = await request.send();
      return response;
    }
    final response = await http.put(Uri.parse("$server/rest/chat/$id/message"),
        headers: {'content-type': 'application/json', "authorization": auth},
        body: jsonEncode(map));
    // status codes :
    // 401  -> unauthorized , you should log in
    // 200 -> ok , the message has been sent
    // return the updated chat object
    return response;
  }
}
