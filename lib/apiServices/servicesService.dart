import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:Rafeed/apiServices/loginSignup.dart";
import "package:Rafeed/models/favorateModel.dart";
import "package:Rafeed/models/ratingModel.dart";
import "package:Rafeed/models/serviceModel.dart";
import "package:Rafeed/var/var.dart";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;

class ServicesService extends ChangeNotifier {
  double rating = 3;
  List<String> imageUrls = [];

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

    ///200 -> data:Order Object
    ///401 -> Auth Failed (token expired)
    ///400 -> user not found or service not found (almost impossible to occur)
    return response;
  }

  addRating(double rate) {
    rating = rate;
    notifyListeners();
  }

  feedBackService(Map<String, dynamic> map, String orderId) async {
//body :{
    // customer_id:string,
    // service_id:string
    // review:string
    // value:number
// }
    final url = Uri.parse('$server/rest/user/rate/$orderId');
    final response = await http.put(
      url,
      body: jsonEncode(map),
      headers: {'Content-Type': 'application/json', "authorization": auth},
    );
  }

  fetchBlogImage(String? wordPressAuth, String imageId) async {
    if (wordPressAuth != null) {
      log('https://rafeed.sa/wp-json/wp/v2/media/$imageId');
      final url = Uri.parse('https://rafeed.sa/wp-json/wp/v2/media/$imageId');
      try {
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': wordPressAuth,
          },
        );
        if (response.statusCode == 200) {
          final responseMap = jsonDecode(response.body);
          log(responseMap["media_details"]['sizes']["thumbnail"]["source_url"]
              .toString());
          imageUrls.add(responseMap["media_details"]['sizes']["thumbnail"]
                  ["source_url"]
              .toString());
          notifyListeners();
        } else if (response.statusCode == 404) {
          imageUrls.add("");
        } else {
          throw Exception('Failed to add favorite: ${response.statusCode}');
        }
      } catch (e) {
        print('Error adding favorite: $e');
        rethrow;
      }
    }
  }

  cancelOrder(String orderId) async {
    final url = Uri.parse('$server/rest/order/$orderId/cancel');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json', 'authorization': auth});

      if (response.statusCode == 200) {
        print('');
      } else {
        throw Exception('Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error cancelling order: $e');
      rethrow;
    }
  }

  sendTip(Map<String, dynamic> map, String id) async {
    final url = Uri.parse('$server/rest/order/$id/tip');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': auth,
        },
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        print('Tip sent successfully');
        return true;
      } else {
        print('Error sending tip: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception('Error sending tip: $e');
    }
  }
}
