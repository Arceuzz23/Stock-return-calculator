
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stock_return_calculator/authentication/user.dart';
import 'package:stock_return_calculator/services/auth.dart';
import 'package:stock_return_calculator/wrapper.dart';
class splash extends StatefulWidget {
  const splash({super.key});
  @override
  State<splash> createState() => _splashState();
}
class _splashState extends State<splash> {
  bool showSignIn = true;
  void toggleview() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<Users?>.value(
      initialData: null,
      value:AuthService().user,
      child: MaterialApp(
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/logo1.jpg'),
          nextScreen: const wrapper(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.rightToLeftWithFade,
          backgroundColor: Colors.black,
          duration: 3000,
          splashIconSize: 200.0,
          centered: true,
        ),
      ),
    );
  }
}

