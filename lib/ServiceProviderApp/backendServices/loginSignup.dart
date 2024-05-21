import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:flutter/cupertino.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:rafeed_provider/ServiceProviderApp/backendServices/SocketService.dart";
import "package:rafeed_provider/ServiceProviderApp/models/categoryModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/chatModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/galleryModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/messageModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/notificationModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/orderModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/providerModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/userModel.dart";
import "package:rafeed_provider/ServiceProviderApp/var/var.dart";
import "package:rafeed_provider/SharedPref/ShP.dart";

class GoogleSignInApi {
  List<String> scopes = const <String>[
    'email',
    'profile', // Add 'profile' scope for accessing user's profile information
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  static final _googleSignIn = GoogleSignIn(scopes: const <String>[
    'email',
    'profile', // Add 'profile' scope for accessing user's profile information
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class LoginSignup extends ChangeNotifier {
  ProviderModel? user;
  List<Category> onCategories = categories;
  List<Service> filteredServices = [];
  List<Service> filteredOrders = [];
  searchServices(String text) {
    if (text.isEmpty) {
      filteredServices = user!.services!.toList();
      notifyListeners();
      return;
    }
    filteredServices = user!.services!
        .where((service) =>
            service.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  searchOrders(String text) {
    filteredOrders = user!.services!
        .map((service) {
          var matchingOrders = service.orders.where((order) {
            return order.customer.username
                .toLowerCase()
                .contains(text.toLowerCase());
          }).toList();
          Service temp = Service.fromMap(service.toMap());
          temp.orders = matchingOrders;
          return temp;
        })
        .where((service) => service.orders
            .isNotEmpty) // Only include services with at least one matching order
        .toList();
    notifyListeners();
  }

  openNot() {
    SocketService.socketService.openNots(user!.id!);
    for (var i in user!.notifications!) {
      i.isOpen = true;
    }
    notifyListeners();
  }

  String formatTime(DateTime notificationTime) {
    final now = DateTime.now();
    final difference = now.difference(notificationTime);

    if (difference.inSeconds < 60) {
      return 'الآن';
    } else if (difference.inMinutes < 10) {
      return '${difference.inMinutes} دقائق';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 9) {
      return '${difference.inHours} ساعات';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ساعة';
    } else {
      final days = difference.inDays;
      if (days == 1) {
        return 'أمس';
      } else {
        return DateFormat.yMMMMd('ar').format(notificationTime);
      }
    }
  }

  rejectOrder(String id) {
    for (int i = 0; i < user!.services!.length; i++) {
      bool x = false;
      for (int j = 0; j < user!.services![i].orders.length; j++) {
        if (user!.services![i].orders[j].id == id) {
          x = true;
          user!.services![i].orders[j].status = "REJECTED";
          break;
        }
      }
      if (x) {
        break;
      }
    }
    notifyListeners();
  }

  completeOrder(String id) {
    for (int i = 0; i < user!.services!.length; i++) {
      bool x = false;
      for (int j = 0; j < user!.services![i].orders.length; j++) {
        if (user!.services![i].orders[j].id == id) {
          x = true;
          user!.services![i].orders[j].status = "COMPLETED";
          break;
        }
      }
      if (x) {
        break;
      }
    }
    notifyListeners();
  }

  LoginSignup() {
    SocketService.socketService.onNewNotification = (data) {
      user!.notifications!.add(NotificationsModel.fromMap(data));
      user!.notifications!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    };
    SocketService.socketService.onOrderCancled = (data) {
      for (int i = 0; i < user!.services!.length; i++) {
        bool x = false;
        for (int j = 0; j < user!.services![i].orders.length; j++) {
          if (user!.services![i].orders[j].id == data['id']) {
            x = true;
            user!.services![i].orders[j].status = "COMPLETED";
            break;
          }
        }
        if (x) {
          break;
        }
      }
      notifyListeners();
    };
    SocketService.socketService.onNewChat = (Map<String, dynamic> data) {
      user!.chats!.add(ChatModel.fromMap(data, user!.id!));
      notifyListeners();
    };
    SocketService.socketService.onNewCategory = (data) {
      onCategories.add(Category.fromMap(data));
      notifyListeners();
    };
    SocketService.socketService.onNewMessage = (Map<String, dynamic> data) {
      for (int i = 0; i < user!.chats!.length; i++) {
        if (user!.chats![i].id == data["chat"]) {
          log(user!.chats![i].id);
          user!.chats![i].messages
              .add(Message.fromMap(data["message"], user!.id!));
          notifyListeners();
          break;
        }
      }
    };
    SocketService.socketService.onNewOrder = (Map<String, dynamic> data) {
      user!.orders?.add(Order.fromMap(data));
      user!.services!.forEach(
        (element) {
          if (element.id == data["service_id"]["_id"]) {
            user!.services![user!.services!.indexOf(element)].orders
                .add(Order.fromMap(data));
            log(data.toString());
          }
        },
      );
      notifyListeners();
    };
  }
  changePageIndex(int x) {
    if (x == 1 || x == 2) {
      filteredOrders = user!.services ?? [];
      filteredServices = user!.services ?? [];
      notifyListeners();
    }
  }

  updateMessages(ChatModel chat) {
    for (var i = 0; i < user!.chats!.length; i++) {
      if (user!.chats![i].id == chat.id) {
        user!.chats![i].messages.add(chat.messages.last);
        notifyListeners();
        return;
      }
    }
    user!.chats!.add(chat);
    notifyListeners();
    return;
  }

  addService(Map<String, dynamic> data) {
    user!.services!.add(Service.fromMap(data));
    notifyListeners();
  }

  deleteWork(String id) async {
    final res = await http.delete(
        Uri.parse("${server}rest/s-provider/delete-work/${id}"),
        headers: {'content-type': 'application/json', "authorization": auth});
    if (res.statusCode == 200) {
      int i = 0;
      for (var g in user!.gallery!) {
        if (user!.gallery![i].id == id) {
          user!.gallery!.removeAt(i);
          notifyListeners();
          break;
        }
        i++;
      }
    }
  }

  updateOrderStatus(bool x) async {
    String state = "deactivate";
    if (x) {
      state = "activate";
    }

    final res = await http.post(
        Uri.parse("${server}rest/s-provider/update-state/${state}"),
        headers: {'content-type': 'application/json', "authorization": auth});
    if (res.statusCode == 200) {
      user!.order_status = x ? "ACTIVE" : "INACTIVE";
      notifyListeners();
    }
  }

  acceptOrder(String orderId) {
    for (var i in user!.services!) {
      for (var s in i.orders) {
        if (s.id == orderId) {
          s.status = "ACCEPTED";
          notifyListeners();
          return;
        }
      }
    }
  }

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      return await GoogleSignInApi.login();
      // return user;
    } catch (error) {
      print(error);
    }
  }

  userSignUp(Map<String, dynamic> map) async {
    /// Expected Map : {"phone":{"country":"972"number:"0599123456"}}
    final res = await http.post(Uri.parse(server + "rest/user/signup"),
        body: jsonEncode(map));

    /// status codes :
    /// 200 -> data:jwt Token
    /// 409 ->  data:"USER_ALREADY_EXIST"
    if (res.statusCode == 200) {
      auth = (res.body);
    }
    log(res.toString());
    return res;
  }

  createUser(Map<String, dynamic> map) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456",
    ///   "gender":"MALE",
    ///   "username":"John Smith",
    ///   "key":"123456" the 6-digit auth key
    /// }
    final res = await http.post(Uri.parse(server + "rest/user/signup"),
        headers: {'content-type': 'application/json', "authorization": auth},
        body: jsonEncode(map));

    ///status codes:
    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong key)
    ///400 -> Bad request : Missing data
    if (res.statusCode == 200) {
      log('signup succesfuly');
      auth = (res.body); //!IMPORTANT
    } else {}
    return res;
  }

  createUserByEmail(Map<String, dynamic> map) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456",
    ///   "gender":"MALE",
    ///   "username":"John Smith",
    ///   "key":"123456" the 6-digit auth key
    /// }

    final res = await http.put(
        Uri.parse(server + "rest/s-provider/create-by-email"),
        headers: {'content-type': 'application/json', "authorization": auth},
        body: jsonEncode(map));

    ///status codes:
    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong key)
    ///400 -> Bad request : Missing data

    if (res.statusCode == 200) {
      final responseMap = jsonDecode(res.body);
      log('signup succesfuly');
      auth = (responseMap['token']); //!IMPORTANT
      user = ProviderModel.fromMap(responseMap['user']);
    } else {
      log(res.body);
    }
    return res;
  }

  addToUser(Map<String, dynamic> provider) {
    user!.gallery?.add(Gallery.fromMap(provider));
    notifyListeners();
  }

  signInBackground(String token) async {
    final res = await http.get(
      Uri.parse(server + "rest/user/profile"),
      headers: {'content-type': 'application/json', 'authorization': token},
    );
    if (res.statusCode == 200) {
      final responseMap = jsonDecode(res.body);
      user = ProviderModel.fromMap(responseMap['user']);
      filteredOrders = user!.services ?? [];
      filteredServices = user!.services ?? [];
      for (var i in user!.chats!) {
        i.messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
      auth = responseMap['token'];
      await ShP.shp.setValue("token", auth);
      log('login succesfuly');
      SocketService.socketService.connectToServer(user!.id!, user!.role);
      notifyListeners();
      return res.statusCode;
    } else {
      log('Login failed');
      return res.statusCode;
    }
  }

  signIn(Map<String, dynamic> map) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456"
    /// }
    final res = await http.post(Uri.parse(server + "rest/user/signin"),
        headers: {'content-type': 'application/json'}, body: jsonEncode(map));

    ///status codes:
    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong info)
    if (res.statusCode == 200) {
      final responseMap = jsonDecode(res.body);
      user = ProviderModel.fromMap(responseMap['user']);
      filteredOrders = user!.services ?? [];
      filteredServices = user!.services ?? [];
      for (var i in user!.chats!) {
        i.messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
      auth = responseMap['token'];
      await ShP.shp.setValue("token", auth);
      log('login succesfuly');
      SocketService.socketService.connectToServer(user!.id!, user!.role);
      notifyListeners();
      return res.statusCode;
    } else {
      log('Login failed');
      return res.statusCode;
    }
  }

  forgetPassword(Map<String, dynamic> map) async {
    /// Expected Map : {"country":"+972",number:"0599123456"}
    final res = await http.post(Uri.parse(server + "rest/user/forget"),
        body: jsonEncode(map));

    ///status codes:
    ///200 -> data:auth token as string
    ///404 -> User Not Found
    if (res.statusCode == 200) {
      auth = jsonDecode(res.body); //!IMPORTANT
    }
  }

  verifyKey(String key) async {
    final res = await http.post(
      Uri.parse(server + "rest/user/verify/$key"),
      headers: {'content-type': 'application/json', "authorization": auth},
    );

    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong key)
    if (res.statusCode == 200) {
      auth = jsonDecode(res.body)["token"]; //!IMPORTANT
    }
    return res;
  }

  resetPassword(String pass) async {
    final res = await http.post(
      Uri.parse(server + "rest/user/update-pass/$pass"),
      headers: {'content-type': 'application/json', "authorization": auth},
    );

    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (token expired)
    if (res.statusCode == 200) {
      auth = jsonDecode(res.body)["token"]; //!IMPORTANT
    }
  }

  Future<void> updateUser({
    required String id,
    required User userData,
    File? logoFile,
  }) async {
    final url = Uri.parse(server + 'rest/user/$id/update');
    try {
      if (logoFile != null) {
        // If there's a logo image file, send a multipart request
        var request = http.MultipartRequest('POST', url)
          ..fields.addAll(jsonDecode(userData.toJson()))
          ..files.add(http.MultipartFile(
            'logo',
            logoFile.readAsBytes().asStream(),
            logoFile.lengthSync(),
            filename: 'logo_image.jpg', // Adjust filename as needed
          ));

        var response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          print('User updated successfully');
        } else {
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        // If it's not an image, send JSON body
        final response = await http.post(
          url,
          body: jsonEncode(userData.toJson()),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          print('User updated successfully');
        } else {
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }
}
