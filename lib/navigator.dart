import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stock_return_calculator/screens/PLCalci.dart';
import 'package:stock_return_calculator/screens/home.dart';


class navigator extends StatefulWidget {
  const navigator({super.key});

  @override
  State<navigator> createState() => _navigatorState();
}

class _navigatorState extends State<navigator> {

  int _currentIndex = 0;
  List<Widget> screens = [
    const home(),
   const pl_calci(),
  ];
  void ontapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          currentIndex: _currentIndex,
          onTap: ontapped,
          unselectedLabelStyle: const TextStyle(color: Colors.red),
          selectedLabelStyle: const TextStyle(color: Colors.red),
          fixedColor: Colors.white,
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Colors.white),
              icon: Icon(Icons.home_outlined, color: Colors.grey,),
              label: 'Home',

              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.calculate_rounded, color: Colors.white) ,
              icon: Icon(Icons.calculate_outlined,color: Colors.grey,),
              label: 'P&L',
              backgroundColor: Colors.black,
            ),
          ],
        )
    );
  }
}
