import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";
import "package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart";
import "package:rafeed_provider/ServiceProviderApp/models/galleryModel.dart";
import "package:rafeed_provider/ServiceProviderApp/models/providerModel.dart";
import "package:rafeed_provider/ServiceProviderApp/var/var.dart";

class ProviderService extends ChangeNotifier {
  //199.192.25.92

  getProviderInfo(String id) async {
    final res = await http.get(
      Uri.parse(server + "rest/user/provider/$id"),
      headers: {'content-type': 'application/json', "authorization": auth},
    );

    ///200 -> data:Provider Object
    ///401 -> Auth Failed (token expired)
    ///400 -> Provider not found (almost impossible to occur)
    return res;
  }
  Map<String,dynamic>cache={};
  providerSignUp(Map<String, dynamic> map) async {
    /// Expected Map : {"phone":{"country":"972"number:"0599123456"}}
    cache=map;
    log(jsonEncode(map));
    final res = await http.post(Uri.parse(server + "rest/s-provider/signup"),
        headers: {'content-type': 'application/json'}, body: jsonEncode(map));

    /// status codes :
    /// 200 -> data:jwt Token
    /// 409 ->  data:"USER_ALREADY_EXIST"
    if (res.statusCode == 200) {
      auth = (res.body);
      log(auth);
    }
    return res;
  }

  createProvider(Map<String, dynamic> map, File file) async {
    /// Expected Map : {
    ///   "phone":{"country":"972"number:"0599123456"},
    ///   "password":"123456",
    ///   "gender":"MALE",
    ///   "username":"John Smith",
    ///   "key":"123456" the 6-digit auth key
    ///   "longitude":31.8303,
    ///   "latitude":30.7678,
    ///   "email":"john.smith@example.com"
    ///   "field":"Filming"
    /// }
    map.remove("_id");
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(server + "rest/s-provider/create"),
    );

    map.forEach((key, value) {
      if (key == "phone") {
        request.fields[key] = jsonEncode(value);
      } else {
        request.fields[key] = value.toString();
      }
    });
    final bytes = await file.readAsBytes();
    request.files.add(
        await http.MultipartFile.fromBytes('file', bytes, filename: file.path));
    log(auth);
    request.headers
        .addAll({'content-type': 'multipart/form-data', "authorization": auth});
    request.files.add(await http.MultipartFile.fromPath(
      "file",
      file.path,
    ));
    final response = await request.send();
    log(response.toString());
    if(response.statusCode==200){
      
    }
    /// status codes :
    /// 200 -> {user:UserObject,token:Token as string}
    /// 401 -> Key is Wrong
    /// 400 -> File Missing
    /// 409 ->  data:"USER_ALREADY_EXIST"
    return response;
  }

  Future<void> activateProvider() async {
    final url = Uri.parse(server + 'rest/s-provider/activate');
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Provider activated successfully');
      } else {
        throw Exception('Failed to activate provider: ${response.statusCode}');
      }
    } catch (e) {
      print('Error activating provider: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> deactivateProvider() async {
    final url = Uri.parse(server + 'rest/s-provider/deactivate');
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Provider deactivated successfully');
      } else {
        throw Exception(
            'Failed to deactivate provider: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deactivating provider: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  addWork(File? imageFile, Map<String, dynamic> map) async {
    final url = Uri.parse(server + 'rest/s-provider/add-work');
    try {
      if (imageFile != null) {
        // If there's an image file, send a multipart request
        var request = http.MultipartRequest('PUT', url)
          ..fields['provider_id'] = map['provider_id']
          ..fields['location'] = map['location']
          ..fields['category'] = map['category']
          ..files.add(http.MultipartFile(
            'file',
            imageFile.readAsBytes().asStream(),
            imageFile.lengthSync(),
            filename: 'work_image.jpg', // Adjust filename as needed
          ));
        request.headers.addAll(
            {'Content-Type': 'multipart/form-data', "authorization": auth});

        var response = await http.Response.fromStream(await request.send());
        return response;
        
      } else {
        // If it's not an image, send JSON body
        final requestBody = {
          'provider_id': map['provider_id'],
          'location': map['location'],
          'category': map['category'],
          'url': map['url'],
        };

        final response = await http.put(
          url,
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json', "authorization": auth},
        );

          print('Work added successfully');
          return response;
          // _loginSignup.addToUser(map);
        
      }
    } catch (e) {
      print('Error adding work: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> updateProvider({
    required ProviderModel providerModel,
    File? logoFile,
  }) async {
    final url = Uri.parse(server + 'rest/s-provider/update');
    try {
      if (logoFile != null) {
        // If there's a logo image file, send a multipart request
        var request = http.MultipartRequest('POST', url);
        final Map<String, dynamic> providerData =
            jsonDecode(providerModel.toJson());
        final Map<String, String> providerMap =
            providerData.map((key, value) => MapEntry(key, value.toString()));
        request.fields.addAll(providerMap);
        request.headers.addAll(
            {'content-type': 'multipart/form-data', "authorization": auth});
        request.files.add(http.MultipartFile(
          'logo',
          logoFile.readAsBytes().asStream(),
          logoFile.lengthSync(),
        ));

        var response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          print('Provider updated successfully');
        } else {
          throw Exception('Failed to update provider: ${response.statusCode}');
        }
      } else {
        // If it's not an image, send JSON body

        final response = await http.post(
          url,
          body: (providerModel.toJson()),
          headers: {'Content-Type': 'application/json', "authorization": auth},
        );
        log('message');
        if (response.statusCode == 200) {
          print('Provider updated successfully');
        } else {
          throw Exception('Failed to update provider: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error updating provider: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> addAddress({required Map<String, dynamic> map}) async {
    final url = Uri.parse(server + 'rest/s-provider/add-address');
    try {
      final response = await http.put(
        url,
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Address added successfully');
      } else {
        throw Exception('Failed to add address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding address: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }
}
