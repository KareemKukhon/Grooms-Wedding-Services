import 'dart:convert';
import 'dart:developer';

import 'package:Rafeed/apiServices/chatService.dart';
import 'package:Rafeed/models/chatModel.dart';
import 'package:Rafeed/models/messageModel.dart';
import 'package:Rafeed/models/notificationModel.dart';
import 'package:Rafeed/screen/notification/notification_service.dart';
import 'package:Rafeed/var/var.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;

  late Function onOrderAccepted;
  late Function onOrderRejected;
  late Function onOrderCompleted;
  late Function onNewChat;
  late Function onNewCategory;
  late Function onNewMessage;
  late Function onSearchResults;
  late Function onNewNotification;
  late Function onNewService;
  late Function onNewProvider;
  late Function onNewAd;
  SocketService._();
  static SocketService socketService = SocketService._();
  connectToServer(String id, String role) async {
    disconnect();
    _socket = IO.io("$server/socket", <String, dynamic>{
      'transports': ['websocket'],
      'path': '/socket.io/socket',
    });
    _socket!.on('connect', (_) {
      print('connected to server');

      _socket!.emit('setId', {'id': id, 'role': role});
    });
    _socket!.on("New Notification", (data) {
      //data is a Notification Model
      onNewNotification(data);
      NotificationsModel notification = NotificationsModel(
          // userId: data['user_id'],
          message: data['message'],
          type: data['type'],
          createdAt: DateTime.now(),
          isOpen: false);
      // await addNotification(notification);
      NotificationService.showNotification(
          title: 'new message',
          body: notification.message,
          payload: {
            "navigate": "true",
            // "sender": sender,
            // "recipient": recipient
          },
          actionButtons: [
            NotificationActionButton(
              key: 'check',
              label: 'Check it out',
              actionType: ActionType.SilentAction,
              // color: kPrimaryColor,
            )
          ]);
      // notifyListeners();
    });

    _socket!.on("Ads Updated", (data) {
      // log("New Add : ${data.toString()}");
      onNewAd(data);
    });

    _socket!.on("New Category", (data) {
      log("New Category : ${data.toString()}");
      onNewCategory(data);
    });

    _socket!.on("New Provider", (data) {
      log("New Category : ${data.toString()}");
      onNewProvider(data);
    });

    _socket!.on("New Service", (data) async {
      log("New Category : ${data.toString()}");
      disconnect();
      onNewService(data);
    });
    _socket!.on("New Chat", (data) {
      //data is a Chat Model
      onNewChat(data);

      // notifyListeners();
    });
    _socket!.on("New Message", (data) {
      //data is like this :{message:MessageModel,chat:string(chat id)}
      onNewMessage(data);
      // log(jsonEncode(data).toString());
      // ChatService().addMessage(Message.fromMap(data, id));
      NotificationsModel notification = NotificationsModel(
          userId: id,
          message: data['message']['message'],
          type: "data['type']",
          createdAt: DateTime.now(),
          isOpen: false);
      // await addNotification(notification);
      NotificationService.showNotification(
          title: 'new message',
          body: notification.message,
          payload: {
            "navigate": "true",
            // "sender": sender,
            // "recipient": recipient
          },
          actionButtons: [
            NotificationActionButton(
              key: 'check',
              label: 'Check it out',
              actionType: ActionType.SilentAction,
              // color: kPrimaryColor,
            )
          ]);
      // notifyListeners();
    });
    // if (role == "CUSTOMER") {
      _socket!.on("Order Accepted", (data) {

        onOrderAccepted(data);
        // notifyListeners();
      });
      _socket!.on("Order Rejected", (data) {
        //data is an Order Model
        onOrderRejected(data);
        // notifyListeners();
      });

      _socket!.on("Order Completed", (data) {
        log("message Completed");
        //data is an Order Model
        onOrderCompleted(data);
        // notifyListeners();
      });

      _socket!.on("search results", (data) {
        //data is an array of services
        log("message");
        onSearchResults(data);
        // log(jsonEncode(data));

        // NotificationsModel notification = NotificationsModel(
        //     userId: id,
        //     message: "data['message']",
        //     type: "data['type']",
        //     createdAt: DateTime.now(),
        //     isOpen: false);
        // // await addNotification(notification);
        // NotificationService.showNotification(
        //     title: 'new message',
        //     body: "notification.message",
        //     payload: {
        //       "navigate": "true",
        //       // "sender": sender,
        //       // "recipient": recipient
        //     },
        //     actionButtons: [
        //       NotificationActionButton(
        //         key: 'check',
        //         label: 'Check it out',
        //         actionType: ActionType.SilentAction,
        //         // color: kPrimaryColor,
        //       )
        //     ]);
        // onSearchResults(data);
        // notifyListeners();
      });
    // }

    _socket!.on('disconnect', (_) {
      print('disconnected from server');
    });
  }

  search(String text) {
    //just send the text here and the results will be back immediatly on the "search results" event, (check line 52)
    _socket!.emit("search", text);
  }

  openChat(userId, chatId) {
    //called every time you open a chat, send the logged user id and the chat id to set messages as readed
    _socket!.emit("open chat", {"user": userId, "chat": chatId});
  }

  openNots(userId) {
    //called when opening notifications page, sends the userid to set his notifications to seen
    _socket!.emit("open nots", {"user": userId});
  }

  disconnect() {
    if (_socket != null) if (_socket!.connected) {
      _socket!.disconnect();
    }
  }
}
