// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:crypto_currency_tracker/models/api.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/models/local_storage.dart';
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
    List<String> favourite = await LocalStorage.fetchFavourite();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency cryptoCurrency = CryptoCurrency.fromJson(market);

      if (favourite.contains(cryptoCurrency.id)) {
        cryptoCurrency.isFavourite = true;
      }

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

  void addFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = true;
    await LocalStorage.addFavourite(crypto.id);
    notifyListeners();
  }

  void removeFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = false;
    await LocalStorage.removeFavourite(crypto.id);
    notifyListeners();
  }
}
