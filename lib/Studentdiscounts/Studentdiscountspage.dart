import 'package:budget/Studentdiscounts/Offerspage.dart';
import 'package:budget/Studentdiscounts/Studentdiscount.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/pages/root_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/Home/stats.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget/pages/profile_page.dart';
import '../services/database.dart';


class Studentsavingspage extends StatefulWidget {
  const Studentsavingspage({Key? key}) : super(key: key);

  @override
  _StudentsavingspageState createState() => _StudentsavingspageState();
}

class _StudentsavingspageState extends State<Studentsavingspage> {


  int pageIndex = 0;
  List<dynamic> data = [];
  final user = FirebaseAuth.instance.currentUser!;
  List<Widget> pages = [
    Offers(),
    Studentdiscount(),


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

    return new FutureBuilder(
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
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 198, // Set this height
                flexibleSpace:


                Column(

                  children: [


                    Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),

                          color: Colors.green.shade400, boxShadow: [
                        BoxShadow(

                          color: Colors.grey.shade300,
                          spreadRadius: 10,

                          // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60, right: 20, left: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Offers",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [IconButton(
                                    icon: Icon(Icons.home),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()),);
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
                                    "Savings around you",
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
                                        "Offers",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.green
                                        ),

                                      ),

                                    ),

                                    Center(
                                      child: ElevatedButton(

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
                                          "Student Discounts",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.green
                                          ),),

                                      ),
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















