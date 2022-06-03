import 'package:budget/MustRead/FinancialReads.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/pages/profile_page.dart';
import 'package:budget/pages/root_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MustReads extends StatefulWidget {
  const MustReads({Key? key}) : super(key: key);

  @override
  _MustReadsState createState() => _MustReadsState();

}

class _MustReadsState extends State<MustReads> {
  @override
  List<dynamic> dataList = [];
  List<dynamic> data = [];


  Widget build(BuildContext context) {
    return Scaffold(
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

                  color: Colors.lightBlue.shade400, boxShadow: [
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

                        Text(
                          "Reads",
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
                            "Suggested Financial Reads",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),


                          width: 500.0,

                        ),

                        SizedBox(
                          height: 30.0,
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),
          ],),),

      body: FinancialReads(),
    );
  }



}
