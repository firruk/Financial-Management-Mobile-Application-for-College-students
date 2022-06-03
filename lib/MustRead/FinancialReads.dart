import 'package:budget/Home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FinancialReads extends StatefulWidget {
  const FinancialReads({Key? key}) : super(key: key);

  @override
  _FinancialReadsState createState() => _FinancialReadsState();
}

class _FinancialReadsState extends State<FinancialReads> {
  @override
  List<dynamic> dataList = [];
  List<dynamic> data = [];



  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: getMustreadData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;


            return getBody();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );

  }


  Widget getBody() {
    var size = MediaQuery
        .of(context)
        .size;


    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(

              decoration: BoxDecoration(color: Colors.white,

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 10, blurRadius: 3),
                  ]),
              child: Padding(
                padding:
                EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Financial Articles for your financial journey",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                      ],
                    ),
                    SizedBox(height: 25),


                    Wrap(

                        spacing: 20,
                        children: List.generate(data.length, (index) {
                          if (data.length == 0) {
                            Center(
                              child: Text(
                                "There are no Offers",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            );
                          }

                          return Container(
                            width: (size.width - 40),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 3,
                                    blurRadius: 1,
                                    // changes position of shadow
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [

                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [


                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                                width: (size.width - 90),
                                                height: 150,
                                                child: Image.network(data[index]["ImageLink"],
                                                )),

                                            Text(
                                              "Category: "+data[index]["ArticleType"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .w500,
                                                  fontSize: 13,
                                                  color: Color(0xff67727d)),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              data[index]["Articlename"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Author: "+ data[index]["Authorname"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),


                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: ElevatedButton(

                                      onPressed: () {
                                        _launchURLApp();
                                      },

                                      style: ElevatedButton.styleFrom(
                                        elevation: 5.0,
                                        primary: Colors.lightBlue,
                                        // background
                                        onPrimary: Colors.pink,
                                        // foreground
                                        fixedSize: Size(120, 30),

                                      ),
                                      child:
                                      Text(
                                        "Learn More",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.grey.shade300
                                        ),),

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        })),
                  ],
                ),

              ),
            ),
          ],),),);
  }

  Future getMustreadData() async {
    List OfferList = [];


    final CollectionReference collectionref = FirebaseFirestore.instance
        .collection("Admin");
    try {
      await collectionref.doc("MustReads")
          .collection("MustReads")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          OfferList.add(result.data());
        }
      });

      return OfferList;
    }
    catch (e) {
      debugPrint('Error - $e');
      return null;
    }
  }


}

_launchURLBrowser() async {
  const url = 'https://www.geeksforgeeks.org/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLApp() async {
  const url = 'https://www.geeksforgeeks.org/';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

