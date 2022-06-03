import 'package:budget/MustRead/MustRead.dart';
import 'package:budget/Studentdiscounts/Studentdiscountspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/Home/stats.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget/pages/profile_page.dart';
import '../services/database.dart';

import 'Overview.dart';
import '../pages/root_app.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  int pageIndex = 0;
  List<dynamic> data = [];
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> pages = [
    OverviewPage(),
    Homestats(),

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


    return FutureBuilder(
        future:FireStoreDataBase(). UserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = [];
            data = snapshot.data as List;
            var index = data.length;

            return Scaffold(


              body: getBody(),
              key: _scaffoldKey,

              appBar: AppBar(
                backgroundColor: Colors.white,

                automaticallyImplyLeading: false,
                toolbarHeight: 200, // Set this height
                flexibleSpace:


                Column(

                  children: [


                    Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),

                          color: Colors.deepPurple.shade400, boxShadow: [
                        BoxShadow(

                          color: Colors.grey.shade300,
                          spreadRadius: 10,

                          // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60, right: 20, left: 10, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.menu),
                                  iconSize: 35,
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [IconButton(
                                    icon: Icon(Icons.account_balance_wallet_rounded),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RootApp()),);
                                    },),
                                    IconButton(
                                      icon: Icon(Icons.person),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePage()),);
                                      },),
                                  ],),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(

                                  child: Text(
                                    "Welcome " + data[0]["fullname"],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),


                                  width: 500.0,

                                ),

                                SizedBox(
                                  height: 15.0,
                                ),

                                Row(

                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,

                                  children: [

                                    ElevatedButton(

                                      style: ElevatedButton.styleFrom(
                                        elevation: 10.0,
                                        primary: Colors.grey.shade300,
                                        // background
                                        onPrimary: Colors.pink,
                                        // foreground
                                        fixedSize: Size(130, 40),
                                      ),

                                      onPressed: () {
                                        selectedTab(0);
                                      },

                                      child:
                                      Text(
                                        "Overview",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.deepPurple
                                        ),

                                      ),

                                    ),

                                    ElevatedButton(

                                      onPressed: () {
                                        selectedTab(1);
                                      },

                                      style: ElevatedButton.styleFrom(
                                        elevation: 10.0,
                                        primary: Colors.grey.shade300,
                                        // background
                                        onPrimary: Colors.pink,
                                        // foreground
                                        fixedSize: Size(130, 40),

                                      ),
                                      child:
                                      Text(
                                        "Stats",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.deepPurple
                                        ),),

                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],),),
              drawer: Drawer(
                child: ListView(
                  // Remove padding
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(data[0]["fullname"]),
                      accountEmail: Text(user.email.toString()),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            'https://www.kindpng.com/picc/m/173-1731325_person-icon-png-transparent-png.png',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 90,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,

                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text('Budget'),
                      onTap: () =>  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RootApp()),),
                    ),
                    ListTile(
                      leading: Icon(Icons.discount),
                      title: Text('Offers'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Studentsavingspage()),),
                    ),
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Financial Reads'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MustReads()),),
                    ),

                    Divider(),
                    ListTile(
                      title: Text('Profile'),
                      leading: Icon(Icons.person),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage()),),
                    ),
                  ],
                ),
              ),


            );
          }
          return const Center(child: CircularProgressIndicator());
        }

    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }


  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

}
















