import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:crypto_currency_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketsPage extends StatefulWidget {
  const MarketsPage({super.key});

  @override
  State<MarketsPage> createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency cryptoCurrency = marketProvider.markets[index];
                  return CryptoListTilePage(cryptoCurrency: cryptoCurrency);
                },
              ),
            );
          } else {
            return const Text("Data Not Found");
          }
        }
      },
    );
  }
}
