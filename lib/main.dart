import 'package:crypto_currency_tracker/constands/theme.dart';
import 'package:crypto_currency_tracker/models/local_storage.dart';
import 'package:crypto_currency_tracker/page/auth/login_page.dart';
import 'package:crypto_currency_tracker/provider/market_provider.dart';
import 'package:crypto_currency_tracker/provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.gatTheme() ?? "light";
  await Firebase.initializeApp();
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(theme),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProveder, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProveder.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              title: 'Crypto Currency Tracker',
              home: const LoginPage(),
              // home: const Homepage(),
            );
          },
        ));
  }
}
