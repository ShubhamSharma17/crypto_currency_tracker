import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      List<dynamic> markets = [];
      Uri uri = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false&locale=en");
      var response = await http.get(uri);
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        markets = decodedResponse as List<dynamic>;
      }
      return markets;
    } catch (ex) {
      return [];
    }
  }
}
