import 'package:crypto_currency_tracker/page/home_page.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        // second provider
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Currency Tracker',
        home: Homepage(),
      ),
    );
  }
}
