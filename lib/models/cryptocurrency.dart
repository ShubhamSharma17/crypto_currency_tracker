import 'dart:convert';

List<CryptoCurrency> cryptoCurrencyFromJson(String str) =>
    List<CryptoCurrency>.from(
        json.decode(str).map((x) => CryptoCurrency.fromJson(x)));

String cryptoCurrencyToJson(List<CryptoCurrency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoCurrency {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int marketCap;
  final int marketCapRank;
  final int fullyDilutedValuation;
  final int totalVolume;
  final double high24H;
  final double low24H;
  final double priceChange24H;
  final double priceChangePercentage24H;
  final double marketCapChange24H;
  final double marketCapChangePercentage24H;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;
  final double ath;
  final double athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final DateTime lastUpdated;
  bool isFavourite;

  CryptoCurrency({
    required this.isFavourite,
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) => CryptoCurrency(
        isFavourite: json["isFavourite"] ?? false,
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: json["current_price"]?.toDouble(),
        marketCap: json["market_cap"],
        marketCapRank: json["market_cap_rank"],
        fullyDilutedValuation: json["fully_diluted_valuation"],
        totalVolume: json["total_volume"],
        high24H: json["high_24h"]?.toDouble(),
        low24H: json["low_24h"]?.toDouble(),
        priceChange24H: json["price_change_24h"]?.toDouble(),
        priceChangePercentage24H:
            json["price_change_percentage_24h"]?.toDouble(),
        marketCapChange24H: json["market_cap_change_24h"]?.toDouble(),
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"]?.toDouble(),
        circulatingSupply: json["circulating_supply"]?.toDouble() ?? 0.0,
        totalSupply: json["total_supply"]?.toDouble() ?? 0.0,
        maxSupply: json["max_supply"]?.toDouble() ?? 0.0,
        ath: json["ath"]?.toDouble(),
        athChangePercentage: json["ath_change_percentage"]?.toDouble(),
        athDate: DateTime.parse(json["ath_date"]),
        atl: json["atl"]?.toDouble(),
        atlChangePercentage: json["atl_change_percentage"]?.toDouble(),
        atlDate: DateTime.parse(json["atl_date"]),
        lastUpdated: DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "fully_diluted_valuation": fullyDilutedValuation,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
        "ath_date": athDate.toIso8601String(),
        "atl": atl,
        "atl_change_percentage": atlChangePercentage,
        "atl_date": atlDate.toIso8601String(),
        "last_updated": lastUpdated.toIso8601String(),
      };
}

class Roi {
  final double times;
  final String currency;
  final double percentage;

  Roi({
    required this.times,
    required this.currency,
    required this.percentage,
  });

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: json["times"]?.toDouble(),
        currency: json["currency"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "times": times,
        "currency": currency,
        "percentage": percentage,
      };
}
