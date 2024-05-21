import "dart:async";
import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:Rafeed/apiServices/ShP.dart";
import "package:Rafeed/apiServices/SocketService.dart";
import "package:Rafeed/models/AdModel.dart";
import "package:Rafeed/models/categoryModel.dart";
import "package:Rafeed/models/chatModel.dart";
import "package:Rafeed/models/favorateModel.dart";
import "package:Rafeed/models/messageModel.dart";
import "package:Rafeed/models/notificationModel.dart";
import "package:Rafeed/models/orderModel.dart";
import "package:Rafeed/models/providerModel.dart";
import "package:Rafeed/models/serviceModel.dart";
import "package:Rafeed/models/settingsModel.dart";
import "package:Rafeed/models/userModel.dart";
import "package:Rafeed/var/var.dart";
import "package:flutter/cupertino.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";

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
  static logout() => _googleSignIn.signIn();
}

class LoginSignup extends ChangeNotifier {
  // ProviderModel? user;
  List<ProviderModel>? providerList = [];
  List<Category> onCategories = categories;
  List<Order> filteredOrders = [];
  List<Ad> adds = [];
  List<ServiceModel> services = [];
  bool isClicked = false;
  // SocketService socketService = SocketService();
  ServiceModel? slectedService;
  Map<String, dynamic> bookingInfo = {};
  SettingsModel? settings;
  late Function(List<Ad>) ref;
  LoginSignup() {
    SocketService.socketService.onNewChat = (Map<String, dynamic> data) {};
    SocketService.socketService.onNewChat = (Map<String, dynamic> data) {
      user!.chats!.add(ChatModel.fromMap(data, user!.id!));
      notifyListeners();
    };
    SocketService.socketService.onNewProvider = (data) {
      log(data.toString());
      providerList!.add(ProviderModel.fromMap(data));
      notifyListeners();
    };

    SocketService.socketService.onNewAd = (data) {
      // log('----------------------------------------------------------------');
      // log("New Category : ${data.toString()}");
      log(adds.length.toString());
      adds = allAds.toList();
      ref(allAds);
      adds.add(Ad.fromMap(data));
      log(adds.length.toString());
      notifyListeners();
    };
    SocketService.socketService.onNewService = (data) async {
      /// Expected Map : {
      ///   "phone":{"country":"972"number:"0599123456"},
      ///   "password":"123456"
      /// }
      await signIn({
        "phone": {"country": "972", 'number': user!.phone!.number},
        "password": secretPassword,
        "email": user!.email,
        "role": 'CUSTOMER',
      });
    };
    SocketService.socketService.onNewMessage = (Map<String, dynamic> data) {
      log('---------------------------------------------------------------');
      log(jsonEncode(data["chat"]).toString());
      log('*****************************************************************');
      log(jsonEncode(data["message"]).toString());
      for (int i = 0; i < user!.chats!.length; i++) {
        if (user!.chats![i].id == data["chat"]) {
          log("message -------------------------");
          log(user!.chats![i].messages.toString());
          user!.chats![i].messages
              .add(Message.fromMap(data["message"], user!.id!));
          notifyListeners();
          break;
        }
      }
    };

    SocketService.socketService.onNewCategory = (data) {
      onCategories.add(Category.fromMap(data));
      notifyListeners();
    };

    SocketService.socketService.onOrderAccepted = (data) {
      for (int i = 0; i < user!.orders!.length; i++) {
        if (user!.orders![i].id == data["_id"]) {
          user!.orders![i].status = "ACCEPTED";
          filteredOrders = user!.orders!;
          notifyListeners();
          break;
        }
      }
      notifyListeners();
    };

    SocketService.socketService.onOrderCompleted = (data) {
    log('order completed');
      for (int i = 0; i < user!.orders!.length; i++) {
        if (user!.orders![i].id == data["_id"]) {
          user!.orders![i].status = "COMPLETED";
          filteredOrders = user!.orders!;
          notifyListeners();
          break;
        }
      }
      notifyListeners();
    };

    SocketService.socketService.onOrderRejected = (data) {
      for (int i = 0; i < user!.orders!.length; i++) {
        if (user!.orders![i].id == data["_id"]) {
          user!.orders![i].status = "REJECTED";
          filteredOrders = user!.orders!;
          notifyListeners();
          break;
        }
      }
      notifyListeners();
    };

    SocketService.socketService.onNewNotification = (data) {
      user!.notifications!.add(NotificationsModel.fromMap(data));
      user!.notifications!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    };

    // SocketService.socketService.onNewNotification = (data) {
    //   user!.notifications!.add(NotificationsModel.fromMap(data));
    //   notifyListeners();
    // };
  }
  openNot() {
    SocketService.socketService.openNots(user!.id!);
    for (var i in user!.notifications!) {
      i.isOpen = true;
    }
    notifyListeners();
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

  bookService(String serviceId, Map<String, dynamic> order) async {
    ///Expected Map : {
    ///"order_date": "2024-03-31T21:19:37.520Z",
    ///"city": "data",
    ///"neighborhood": "data",
    ///"hall": "data"
    ///}
    final response = await http.put(
        Uri.parse("$server/rest/order/create/$serviceId"),
        headers: {'content-type': 'application/json', "authorization": auth},
        body: jsonEncode(order));
    if (response.statusCode == 200) {
      user!.orders?.add(Order.fromMap(jsonDecode(response.body)));
      notifyListeners();
    }

    ///200 -> data:Order Object
    ///401 -> Auth Failed (token expired)
    ///400 -> user not found or service not found (almost impossible to occur)
    return response;
  }

  Future<GoogleSignInAccount?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      log(googleUser!.email.toString());
      return googleUser;
      // return user;
    } catch (error) {
      log("error");
      log("karrrrrrrrrreeeeeeeeeeeemmmm" + error.toString());
    }
  }

  googleLogout() async {
    try {
      await GoogleSignInApi.logout();
      // return user;
    } catch (error) {
      print(error);
    }
  }

  UserModel? user;
  userSignUp(Map<String, dynamic> map) async {
    /// Expected Map : {"phone":{"country":"972"number:"0599123456"}}
    log(map.toString());
    final res = await http.post(Uri.parse("$server/rest/user/signup"),
        headers: {'content-type': 'application/json'}, body: jsonEncode(map));

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
    log(map.toString());
    final res = await http.put(Uri.parse("$server/rest/user/create"),
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

    final res = await http.put(Uri.parse("$server/rest/user/create-by-email"),
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
      user = UserModel.fromMap(responseMap['user']);
    } else {}
    return res;
  }

  signIn(Map<String, dynamic> map) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456"
    /// }
    secretPassword = map['password'];
    final res = await http.post(Uri.parse("$server/rest/user/signin"),
        headers: {'content-type': 'application/json'}, body: jsonEncode(map));

    ///status codes:
    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong info)
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      isLogin = true;
      final responseMap = jsonDecode(res.body);
      user = UserModel.fromMap(responseMap['user']);
      providerList = responseMap['providers'] != null
          ? List<ProviderModel>.from(
              responseMap['providers']?.map((x) => ProviderModel.fromMap(x)))
          : null;

      SocketService.socketService.connectToServer(user!.id!, user!.role);
      auth = responseMap['token'];
      adds = (responseMap["ads"] != null ? (responseMap["ads"] as List) : [])
          .map((toElement) => Ad.fromMap(toElement))
          .toList();
      adds.sort((a, b) => b.startDate!.compareTo(a.startDate!));
      allAds = adds.toList();
      log(providerList.toString());
      settings = SettingsModel.fromMap(responseMap['settings']);
      await ShP.shp.setValue("token", auth);
      final List<dynamic> serviceList = responseMap['services'] ?? [];
      // services = responseMap['services'] ?? [];

// Convert each item in the service list to a Category object
      final List<Category> categories =
          serviceList.map((service) => Category.fromMap(service)).toList();
      user!.categories = categories;
      log(user!.categories.toString());
      for (Category cat in user!.categories ?? []) {
        services.addAll(cat.services ?? []);
      }
      filteredOrders = user!.orders ?? [];
      notifyListeners();
      log('login succesfuly');
    } else {
      log('Login failed');
    }
    return res.statusCode;
  }

  signInBackground(String token) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456"
    /// }
    ///

    final res = await http.get(
      Uri.parse(server + '/' + "rest/user/profile"),
      headers: {'content-type': 'application/json', 'authorization': token},
    );

    ///status codes:
    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (wrong info)
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      isLogin = true;
      final responseMap = jsonDecode(res.body);
      user = UserModel.fromMap(responseMap['user']);
      providerList = responseMap['providers'] != null
          ? List<ProviderModel>.from(
              responseMap['providers']?.map((x) => ProviderModel.fromMap(x)))
          : null;

      SocketService.socketService.connectToServer(user!.id!, user!.role);
      auth = responseMap['token'];
      log(providerList.toString());
      await ShP.shp.setValue("token", auth);
      final List<dynamic> serviceList = responseMap['services'] ?? [];
      // services = responseMap['services'] ?? [];

// Convert each item in the service list to a Category object
      final List<Category> categories =
          serviceList.map((service) => Category.fromMap(service)).toList();
      user!.categories = categories;
      log(user!.categories.toString());
      for (Category cat in user!.categories ?? []) {
        services.addAll(cat.services ?? []);
      }
      filteredOrders = user!.orders ?? [];
      adds = (responseMap["ads"] != null ? (responseMap["ads"] as List) : [])
          .map((toElement) => Ad.fromMap(toElement))
          .toList();
      adds.sort((a, b) => b.startDate!.compareTo(a.startDate!));
      settings = SettingsModel.fromMap(responseMap['settings']);
      allAds = adds.toList();
      notifyListeners();
      log('login succesfuly');
    } else {
      log('Login failed');
    }
    return res.statusCode;
  }

  searchOrder(String text) {
    if (text.isEmpty) {
      filteredOrders = user!.orders!.toList();
      notifyListeners();
      return;
    }
    filteredOrders = user!.orders!
        .where((order) =>
            order.service.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  addFavorite(String serviceId, ServiceModel serviceModel) async {
    if (isClicked) {
      isClicked = false;
      final url = Uri.parse('$server/rest/user/favorite/$serviceId');
      try {
        final response = await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': auth,
          },
        );

        if (response.statusCode == 200) {
          print('Favorite added successfully');
          log(response.body);
          user!.favorites!.remove(FavoriteModel(service: serviceModel));
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('Error adding favorite: $e');
        rethrow;
      }
    } else {
      isClicked = true;
      final url = Uri.parse('$server/rest/user/favorite/$serviceId');
      try {
        final response = await http.put(
          url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': auth,
          },
        );
        if (response.statusCode == 200) {
          log(response.body);
          print('Favorite added successfully');
          user?.favorites?.add(FavoriteModel(service: serviceModel));
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('Error adding favorite: $e');
        rethrow;
      }
    }
    notifyListeners();
    if (isClicked) {}
  }

  forgetPassword(Map<String, dynamic> map) async {
    /// Expected Map : {"country":"+972",number:"0599123456"}
    final res = await http.post(Uri.parse("$server/rest/user/forget"),
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
      Uri.parse("$server/rest/user/verify/$key"),
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
      Uri.parse("$server/rest/user/update-pass/$pass"),
      headers: {'content-type': 'application/json', "authorization": auth},
    );

    ///200 -> data:{user:User Object,token:auth token as string}
    ///401 -> Auth Failed (token expired)
    if (res.statusCode == 200) {
      auth = jsonDecode(res.body)["token"]; //!IMPORTANT
    }
  }

  Future<int> updateUser({
    required String id,
    required UserModel userData,
    File? logoFile,
  }) async {
    log(id);
    final url = Uri.parse(server + '/rest/user/$id/update');
    try {
      if (logoFile != null) {
        // If there's a logo image file, send a multipart request
        //     map.forEach((key, value) {
        //   if (key == "phone") {
        //     request.fields[key] = jsonEncode(value);
        //   } else {
        //     request.fields[key] = value.toString();
        //   }
        // });
        log(logoFile.path);
        Map<String, String> map = {
          "username": userData.username,
          "gender": userData.gender,
          "phone": jsonEncode(userData.phone),
          "email": userData.email
        };

        var request = http.MultipartRequest('POST', url);
        request.fields.addAll(map);
        request.headers.addAll(
            {'content-type': 'multipart/form-data', "authorization": auth});
        request.files.add(await http.MultipartFile.fromPath(
          "file",
          logoFile.path,
        ));
        String userDataJson = jsonEncode(userData.toJson());
        var response = await http.Response.fromStream(await request.send());
// Add JSON string as a field to the request
        // request.fields['userData'] = userDataJson;

        if (response.statusCode == 200) {
          print('User updated successfully');
          notifyListeners();
          return response.statusCode;
        } else {
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        // If it's not an image, send JSON body
        final response = await http.post(
          url,
          body: (userData.toJson()),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': auth,
          },
        );

        if (response.statusCode == 200) {
          log(userData.toString());
          log('===================================================');
          user = userData;
          log(user.toString());
          notifyListeners();
          return response.statusCode;
          print('User updated successfully');
        } else {
          throw Exception('Failed to update user: ${response.body}');
        }
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> marriageCostCalc({required Map<String, int> map}) async {
    final url = Uri.parse(server + '/' + 'rest/user/marriage-calc');
    try {
      // If it's not an image, send JSON body
      final response = await http.post(
        url,
        body: jsonEncode(map),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': auth,
        },
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        throw Exception('Failed to update user: ${response.body}');
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> marriageDateCalc({required DateTime dateTime}) async {
    final url = Uri.parse(server + '/' + 'rest/user/marriage-date');
    try {
      // If it's not an image, send JSON body
      final response = await http.put(
        url,
        body: jsonEncode({"date": dateTime.toString()}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': auth,
        },
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        user!.marriageDate = dateTime;
        notifyListeners();
      } else {
        throw Exception('Failed to update user: ${response.body}');
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }
}
