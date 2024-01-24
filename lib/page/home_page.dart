import 'package:crypto_currency_tracker/constands/colors.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                "Crypto Today",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    if (marketProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (marketProvider.markets.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: marketProvider.markets.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency cryptoCurrency =
                                marketProvider.markets[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                cryptoCurrency.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: Text(
                                cryptoCurrency.symbol.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: white,
                                backgroundImage:
                                    NetworkImage(cryptoCurrency.image),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹ ${cryptoCurrency.currentPrice.toStringAsFixed(3)}",
                                    style: const TextStyle(
                                      color: blue0395eb,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Builder(builder: (context) {
                                    double priceChange =
                                        cryptoCurrency.priceChange24H;
                                    double priceChangePercentage =
                                        cryptoCurrency.priceChangePercentage24H;

                                    if (priceChange < 0) {
                                      return Text(
                                        "$priceChangePercentage% (${priceChange.toStringAsFixed(3)})",
                                        style: const TextStyle(color: red),
                                      );
                                    } else {
                                      return Text(
                                        "$priceChangePercentage% (+${priceChange.toStringAsFixed(3)})",
                                        style: const TextStyle(color: green),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text("Data Not Found");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
