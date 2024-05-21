import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/notificationModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/notification/notification_service.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;
  late Function onOrderAccepted;
  late Function onOrderRejected;
  late Function onNewChat;
  late Function onNewMessage;
  late Function onSearchResults;
  late Function onNewNotification;
  late Function onNewOrder;
  late Function onNewCategory;
  late Function onOrderCancled;
  SocketService._();
  static SocketService socketService = SocketService._();
  connectToServer(String id, String role) async {
    _socket = IO.io(server + "socket", <String, dynamic>{
      'transports': ['websocket'],
      'path': '/socket.io/socket',
    });
    _socket!.on('connect', (_) {
      _socket!.emit('setId', {'id': id, 'role': role});
    });
    _socket!.on("New Category", (data) {
      log("New Category : ${data.toString()}");
      onNewCategory(data);
    });
    _socket!.on("Order Canceled", (data) {
      log("New Category : ${data.toString()}");
      onOrderCancled(data);
    });
    _socket!.on("New Notification", (data) {
      //data is a Notification Model
      log("New Notification received");
      onNewNotification(data);
      // onNewNotification(data);
      NotificationsModel notification = NotificationsModel(
          userId: id,
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
    _socket!.on("New Chat", (data) {
      //data is a Chat Model
      log("new chat: " + data.toString());
      onNewChat(data);
      // notifyListeners();
    });
    _socket!.on("New Message", (data) {
      //data is like this :{message:MessageModel,chat:string(chat id)}
      onNewMessage(data);
      // notifyListeners();
    });
    if (role == "CUSTOMER") {
      _socket!.on("Order Accepted", (data) {
        //data is an Order Model
        onOrderAccepted(data);
        // notifyListeners();
      });
      _socket!.on("Order Rejected", (data) {
        //data is an Order Model
        onOrderRejected(data);
        // notifyListeners();
      });

      _socket!.on("search results", (data) {
        //data is an array of services
        log("message");
        log(data);
        onSearchResults(data);
        // notifyListeners();
      });
    } else {
      _socket!.on("New Order", (data) {
        //data is a Order Model
        onNewOrder(data);
        // notifyListeners();
      });
      _socket!.on("search results", (data) {
        log("message");
        log(jsonEncode(data));
      });
    }

    _socket!.on('disconnect', (_) {
      print('disconnected from server');
    });
  }

  disconnect() {
    _socket!.disconnect();
  }

  search(String text) {
    //just send the text here and the results will be back immediatly on the "search results" event, (check line 52)
    log(text);
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
}
