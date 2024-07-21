import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stock_return_calculator/screens/PLCalci.dart';
import 'package:stock_return_calculator/screens/home.dart';



class navigator extends StatefulWidget {
  const navigator({super.key});

  @override
  State<navigator> createState() => _navigatorState();
}

class _navigatorState extends State<navigator> with SingleTickerProviderStateMixin{

  Color newColor= Color(0xffF99E43);
  int _currentIndex = 0;

  void color_changer(){
    Duration duration = Duration(seconds: 1);
    Timer timer =Timer(duration,onEnd);
  }

  void onEnd(){
    newColor=Color(0xFFDA2323);
  }

  List<Widget> screens = [
    const home(),
   const pl_calci(),
  ];
  void ontapped(int index) {
    setState(() {
      _currentIndex = index;
      color_changer();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Container(child: screens[_currentIndex]),

      bottomNavigationBar:
      CurvedNavigationBar(
        index: _currentIndex,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Color(0xffF99E43),),
          Icon(Icons.calculate_rounded, size: 30,color:Color(0xffF99E43),),
        ],
        buttonBackgroundColor: Colors.black,
        backgroundColor:  Color(0xFFDA2323),
        color: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: ontapped,
      )

    );
  }
}
