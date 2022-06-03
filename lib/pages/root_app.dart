import 'package:budget/pages/Details_page.dart';
import 'package:budget/pages/Reminderpage.dart';
import 'package:budget/pages/daily_page.dart';
import 'package:budget/Home/home.dart';
import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget/pages/stats_page.dart';
import 'package:budget/pages/budget_page.dart';
import 'package:budget/pages/profile_page.dart';
import 'package:ionicons/ionicons.dart';



class RootApp extends StatefulWidget {



  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    Detailspage(),
    StatsPage(),
    BudgetPage(),
    Reminderpage()


  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );

            },
            child: Icon( Icons.home,size: 25,),
            backgroundColor: Colors.pink
          //params
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
    );



  }
  Widget getBody(){
    return IndexedStack(
      index:pageIndex,
      children: pages,
    );
  }
  Widget getFooter(){
    List<IconData> iconItems = [
      Ionicons.calendar,
      Ionicons.stats_chart,
      Ionicons.wallet,
      Ionicons.time,

    ];
    return AnimatedBottomNavigationBar(
        icons: iconItems,
        activeColor: Colors.pink,
        splashColor:Colors.white ,
        inactiveColor: Colors.black26,
        activeIndex: pageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        onTap: (index){
            selectedTab(index);
              });
  }
  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
