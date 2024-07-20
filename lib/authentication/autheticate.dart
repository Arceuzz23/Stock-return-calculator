
import 'package:flutter/material.dart';
import 'package:stock_return_calculator/authentication/register.dart';
import 'package:stock_return_calculator/authentication/signin.dart';
class authenticate extends StatefulWidget {
  const authenticate({super.key});

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  bool showSignIn = true;
  void toggleview() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if (!showSignIn) {
      return signin(toggleview: toggleview);
    } else {
      return register(toggleview: toggleview);
    }
  }
}
