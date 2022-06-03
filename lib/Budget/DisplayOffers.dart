import 'package:budget/Studentdiscounts/Studentdiscountspage.dart';
import 'package:budget/pages/Reminderpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayOffers extends StatefulWidget {
  const DisplayOffers({Key? key}) : super(key: key);

  @override
  _DisplayOffersState createState() => _DisplayOffersState();
}

class _DisplayOffersState extends State<DisplayOffers> {
  @override






  List<dynamic> dataList = [];
  List<dynamic> data = [];
  List<dynamic> users = [];
  List<dynamic> studentList = [];
  String? dropdownvalue;
  List student = [];
  final TextEditingController Reminderdate = TextEditingController();





  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.15),
      body: FutureBuilder(
        future: getOfferData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;
            data.sort((a, b) => a["dateuploaded"].compareTo(b["dateuploaded"]));



            return getBody();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Column(
        children: [

          InkWell(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    spacing: 20,
                    children: List.generate(data.length, (index) {
                      if(data.length==0){
                        Center(
                          child: Text(
                            "There are no new Offers",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                        );
                      }



                      return Container(
                        width: (size.width -70)/2,


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
                              left: 25, right: 25, top: 0, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width:120,
                                            height: 150,
                                            child: Image.network(data[index]["ImageLink"],
                                            )),
                                        Text(
                                          data[index]["Companyname"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)),
                                        ),

                                        Text(
                                          data[index]["Location"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data[index]["Offer"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:15,
                                          ),
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ),
            onDoubleTap:  () {
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Studentsavingspage()));

            },),
        ],
      ),
    );
  }
  Future getOfferData() async{
    List OfferList=[];


    final CollectionReference collectionref=FirebaseFirestore.instance.collection("Admin");
    try{
      await collectionref.doc("Offers").collection("Offers").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          OfferList.add(result.data());



        }
      });

      return OfferList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }


}

