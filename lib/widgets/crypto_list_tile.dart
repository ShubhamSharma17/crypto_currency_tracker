import 'package:crypto_currency_tracker/constands/colors.dart';
import 'package:crypto_currency_tracker/models/cryptocurrency.dart';
import 'package:crypto_currency_tracker/page/detail_page.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTilePage extends StatelessWidget {
  final CryptoCurrency cryptoCurrency;

  const CryptoListTilePage({super.key, required this.cryptoCurrency});

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(
          builder: (context) {
            return DetailsPage(id: cryptoCurrency.id);
          },
        ));
      },
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Flexible(
            child: Text(
              cryptoCurrency.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(width: 15),
          cryptoCurrency.isFavourite == false
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavourite(cryptoCurrency);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavourite(cryptoCurrency);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                    color: red,
                  ),
                ),
        ],
      ),
      subtitle: Text(
        cryptoCurrency.symbol.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: white,
        backgroundImage: NetworkImage(cryptoCurrency.image),
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
            double priceChange = cryptoCurrency.priceChange24H;
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
  }
}
