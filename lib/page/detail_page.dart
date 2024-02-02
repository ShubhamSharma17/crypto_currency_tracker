import 'package:crypto_currency_tracker/constands/colors.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetails(
      String title, detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(detail)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency cryptoCurrency =
                  marketProvider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: white,
                        backgroundImage: NetworkImage(
                          cryptoCurrency.image,
                        ),
                      ),
                      title: Text(
                        "${cryptoCurrency.name} (${cryptoCurrency.symbol})",
                        style: const TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "₹ ${cryptoCurrency.currentPrice.toStringAsFixed(3)}",
                        style: const TextStyle(
                          color: blue0395eb,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                            "Market Cap",
                            "₹ ${cryptoCurrency.marketCap.toStringAsFixed(3)}",
                            CrossAxisAlignment.start),
                        titleAndDetails(
                            "Market Cap Rank",
                            "₹ ${cryptoCurrency.marketCapRank.toString()}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                            "Low 24H",
                            "₹ ${cryptoCurrency.low24H.toStringAsFixed(3)}",
                            CrossAxisAlignment.start),
                        titleAndDetails(
                            "High 24H",
                            "₹ ${cryptoCurrency.high24H.toString()}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                            "Price Change 24H",
                            "₹ ${cryptoCurrency.priceChange24H.toStringAsFixed(3)}",
                            CrossAxisAlignment.start),
                        titleAndDetails(
                            "Price Change % 24H",
                            "% ${cryptoCurrency.priceChangePercentage24H.toStringAsFixed(3)}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
