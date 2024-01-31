// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:crypto_currency_tracker/models/api.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  List<CryptoCurrency> markets = [];
  bool isLoading = true;

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency cryptoCurrency = CryptoCurrency.fromJson(market);
      temp.add(cryptoCurrency);
    }

    markets = temp;
    notifyListeners();
    isLoading = false;
    // Timer(const Duration(seconds: 60), () {
    //   fetchData();
    //   if (kDebugMode) {
    //     print("data updated!");
    //   }
    // });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }
}
