import 'package:crypto_currency_tracker/constands/colors.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:crypto_currency_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritPage extends StatefulWidget {
  const FavouritPage({super.key});

  @override
  State<FavouritPage> createState() => _FavouritPageState();
}

class _FavouritPageState extends State<FavouritPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favourite = marketProvider.markets
            .where((element) => element.isFavourite == true)
            .toList();
        if (favourite.isNotEmpty) {
          return ListView.builder(
            itemCount: favourite.length,
            itemBuilder: (context, index) {
              CryptoCurrency cryptoCurrency = favourite[index];
              return CryptoListTilePage(cryptoCurrency: cryptoCurrency);
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Favourite Yet!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: gray939393,
              ),
            ),
          );
        }
      },
    );
  }
}
