import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
          // child: SpinKitChasingDots(
          //   color: Colors.brown,
          //   size: 50.0,
          // )),
        child:LottieBuilder.asset('assets/animations/loading.json'),
      ),
    );
  }
}
