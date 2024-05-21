import "dart:convert";
import "dart:io";

import "package:Rafeed/models/providerModel.dart";
import "package:Rafeed/var/var.dart";
import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;

class ProviderService extends ChangeNotifier {
  getProviderInfo(String id) async {
    final res = await http.get(
      Uri.parse("$server/rest/user/provider/$id"),
      headers: {'content-type': 'application/json', "authorization": auth},
    );

    ///200 -> data:Provider Object
    ///401 -> Auth Failed (token expired)
    ///400 -> Provider not found (almost impossible to occur)
    return res;
  }


  Future<void> addAddress({
    required Map<String, dynamic> map
  }) async {
    final url = Uri.parse('$server/rest/s-provider/add-address');
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
