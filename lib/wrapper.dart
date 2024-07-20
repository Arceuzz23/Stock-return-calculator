import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_return_calculator/navigator.dart';
import 'package:provider/provider.dart';

import 'package:stock_return_calculator/authentication/autheticate.dart';
import 'package:stock_return_calculator/authentication/user.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    if (user == null) {
      return const authenticate();
    } else {
      return const navigator();
    }
  }
}
