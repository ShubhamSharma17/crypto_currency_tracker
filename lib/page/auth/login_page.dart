import 'dart:developer';

import 'package:crypto_currency_tracker/constands/colors.dart';
import 'package:crypto_currency_tracker/methods/validation.dart';
import 'package:crypto_currency_tracker/page/auth/signup_page.dart';
import 'package:crypto_currency_tracker/page/home_page.dart';
import 'package:crypto_currency_tracker/provider/auth_provider.dart';
import 'package:crypto_currency_tracker/provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;
  late bool checkValidation;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    AuthenticationProviders authProvider =
        Provider.of<AuthenticationProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login ",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: themeProvider.themeMode == ThemeMode.light
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              const Text(
                "Crypto Tracker",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),
              // email address
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Your Email Address...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // password text feild
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter Your Password.....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: blue,
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () async {
                  checkValidation = Validation.checkValidation(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  if (checkValidation) {
                    userCredential = await authProvider.login(
                        emailController.text.trim(),
                        passwordController.text.trim());
                    log("checking... ${userCredential!.user!.uid}");
                    // below line for handle (don't use builde context in async method )
                    if (!context.mounted) return;
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, CupertinoPageRoute(
                      builder: (context) {
                        return const Homepage();
                      },
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have a account?",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const SignUpPage();
                }));
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
