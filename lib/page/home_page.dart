import 'package:crypto_currency_tracker/page/favourit.dart';
import 'package:crypto_currency_tracker/page/market.dart';
import 'package:crypto_currency_tracker/provider/auth_provider.dart';
import 'package:crypto_currency_tracker/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    viewController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    AuthenticationProviders authProvider =
        Provider.of<AuthenticationProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            authProvider.signOut();
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return const Homepage();
              },
            ));
          },
        ),
      ]),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Crypto Today",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: themeProvider.themeMode == ThemeMode.light
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                  )
                ],
              ),
              const SizedBox(height: 0),
              TabBar(
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text(
                      "Market",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favourit",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: viewController,
                  children: const [
                    MarketsPage(),
                    FavouritPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
