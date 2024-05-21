import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart";
import "package:rafeed_provider/ServiceProviderApp/var/var.dart";

class ServicesService extends ChangeNotifier {
  bookService(String serviceId, Map<String, dynamic> order) async {
    ///Expected Map : {
    ///"order_date": "2024-03-31T21:19:37.520Z",
    ///"city": "data",
    ///"neighborhood": "data",
    ///"hall": "data"
    ///}
    final response = await http.put(
        Uri.parse(server + "rest/order/create/$serviceId"),
        headers: {'content-type': 'application/json', "authorization": auth},
        body: jsonEncode(order));

    ///200 -> data:Order Object
    ///401 -> Auth Failed (token expired)
    ///400 -> user not found or service not found (almost impossible to occur)
    return response;
  }

  createService(Map<String, dynamic> map, File file, String id) async {
    /// Expected Map : {
    ///   "title":"service",
    ///   "price":123.2,
    ///   "description":"description",
    ///   "category":"FILMING",
    ///   "objectives":["CHEAP","CAMERA"]
    ///   "cities":["City","City"],
    /// }
    log(id);

    var request = http.MultipartRequest(
        'PUT', Uri.parse(server + "rest/s-provider/$id/service/add"));

    map.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.headers
        .addAll({'content-type': 'multipart/form-data', "authorization": auth});
    request.files.add(await http.MultipartFile.fromPath(
      "file",
      file.path,
    ));
    final response = await request.send();

    /// status codes :
    /// 200 -> Service Object
    /// 401 -> Token expired
    /// 400 -> File Missing
    return response;
  }

  acceptOrder(String id) async {
    log(id);
    try {
      final response = await http.post(
          Uri.parse(server + "rest/order/$id/accept"),
          headers: {'content-type': 'application/json', "authorization": auth});
      if (response.statusCode == 200)
        log("login succesfuly");
      else {
        log(response.body);
      }
      return response.statusCode == 200;
    } catch (e) {
      print('Error accepting order: $e');
      return false;
    }

    // notifyListeners();
  }

  rejectOrder(String id) async {
    log(id);

    try {
      final response = await http.post(
          Uri.parse(server + "rest/order/$id/reject"),
          headers: {'content-type': 'application/json', "authorization": auth});
      if (response.statusCode == 200){
        return true;
      }
      else {
        
        log(response.body);
        return false;
      }
    } catch (e) {
      print('Error accepting order: $e');
      return false;
    }
  }

  Future<void> activateService(String id) async {
    final url =
        Uri.parse(server + 'rest/s-provider/update-service-state/$id/activate');
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Service activated successfully');
      } else {
        throw Exception('Failed to activate service: ${response.statusCode}');
      }
    } catch (e) {
      print('Error activating service: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> deactivateService(String id) async {
    log("id: " + id);
    final url = Uri.parse(
        server + 'rest/s-provider/update-service-state/$id/deactivate');
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Service deactivated successfully');
      } else {
        throw Exception('Failed to deactivate service: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deactivating service: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  completeOrder(String id) async {
    final url = Uri.parse(server + 'rest/order/$id/complete');
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Service deactivated successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error deactivating service: $e');
      return false;
    }
  }

  Future<void> updateService({
    required Service serviceModel,
    File? logoImage,
  }) async {
    log(serviceModel.toString());
    final url =
        Uri.parse(server + 'rest/s-provider/update-service/${serviceModel.id}');

    try {
      if (logoImage != null) {
        // If there's a logo image file, send a multipart request
        var request = http.MultipartRequest('POST', url);
        serviceModel.toMap().forEach((key, value) {
          request.fields[key] = value.toString();
        });
        request.files.add(http.MultipartFile(
          'logo',
          logoImage.readAsBytes().asStream(),
          logoImage.lengthSync(),
        ));

        request.headers.addAll(
            {'content-type': 'multipart/form-data', 'authorization': auth});

        var response = await http.Response.fromStream(await request.send());

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          print('Service updated successfully');
        } else {
          throw Exception('Failed to update service: ${response.statusCode}');
        }
      } else {
        // If it's not an image, send JSON body
        var response = await http.post(
          url,
          body: serviceModel.toJson(),
          headers: {'Content-Type': 'application/json', 'authorization': auth},
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          print('Service updated successfully');
        } else {
          throw Exception('Failed to update service: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error updating service: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }

  Future<void> deleteService(String id) async {
    final url = Uri.parse(server + 'rest/s-provider/delete-service/$id');
    try {
      final response = await http.delete(url,
          headers: {'content-type': 'application/json', "authorization": auth});

      if (response.statusCode == 200) {
        print('Service deleted successfully');
      } else {
        throw Exception('Failed to delete service: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting service: $e');
      rethrow; // Rethrow the error to handle it in UI if needed
    }
  }
}
