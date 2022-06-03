import 'package:budget/Admin/AddMustReads.dart';
import 'package:budget/Admin/AddOffers.dart';
import 'package:budget/Admin/AddStudentdiscount.dart';
import 'package:budget/MustRead/FinancialReads.dart';
import 'package:budget/MustRead/MustRead.dart';
import 'package:budget/Studentdiscounts/Studentdiscountspage.dart';
import 'package:budget/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/Home/stats.dart';

import '../Studentdiscounts/Offerspage.dart';
import '../Studentdiscounts/Studentdiscount.dart';



class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int pageIndex = 0;
  List<dynamic> data = [];

  List<Widget> pages = [
    Offers(),
    Studentdiscount(),
    FinancialReads(),


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

                          color: Colors.blueGrey.shade400, boxShadow: [
                        BoxShadow(

                          color: Colors.grey.shade300,
                          spreadRadius: 10,

                          // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60, right: 10, left: 10, bottom: 20),
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
                                    icon:Icon(Icons.add),
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Add'),
                                          actions: <Widget>[
                                            Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.pink, // background
                                                      onPrimary: Colors.deepPurple, // foreground
                                                      fixedSize: Size(200,40),
                                                    ),

                                                    onPressed: () {
                                                      Navigator.push(context,MaterialPageRoute(builder:(context)=>addOffers()));
                                                    },

                                                    child:
                                                    Text(
                                                      "Add Offers",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),

                                                    ),

                                                  ),

                                                  ElevatedButton(

                                                    onPressed: () {
                                                      Navigator.push(context,MaterialPageRoute(builder:(context)=>addStudentdiscounts()));
                                                    },

                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.pink, // background
                                                      onPrimary: Colors.deepPurple, // foreground
                                                      fixedSize: Size(200,40),

                                                    ),
                                                    child:
                                                    Text(
                                                      "Add Student Discounts",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),),

                                                  ),
                                                  ElevatedButton(

                                                    onPressed: () {
                                                      Navigator.push(context,MaterialPageRoute(builder:(context)=>addMustReads()));
                                                    },

                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.pink, // background
                                                      onPrimary: Colors.deepPurple, // foreground
                                                      fixedSize: Size(200,40),

                                                    ),
                                                    child:
                                                    Text(
                                                      " Add Financial Reads",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),),

                                                  ),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },),
                                    IconButton(
                                      icon: Icon(Icons.person),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  login()),);
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
                                    "Admin Page",
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
                                        fixedSize: Size(100, 40),
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
                                            color: Colors.blueGrey
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
                                          fixedSize: Size(100, 40),

                                        ),
                                        child:
                                        Text(
                                          "Student Discounts",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.blueGrey
                                          ),),

                                      ),
                                    ),
                                    Center(
                                      child: ElevatedButton(

                                        onPressed: () {
                                          selectedTab(2);
                                        },

                                        style: ElevatedButton.styleFrom(
                                          elevation: 10.0,
                                          primary: Colors.grey.shade300,
                                          // background
                                          onPrimary: Colors.pink,
                                          // foreground
                                          fixedSize: Size(100, 40),

                                        ),
                                        child:
                                        Text(
                                          "Financial Reads",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.blueGrey
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























