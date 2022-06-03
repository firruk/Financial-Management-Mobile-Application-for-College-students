import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Studentdiscount extends StatefulWidget {
  const Studentdiscount({Key? key}) : super(key: key);

  @override
  _StudentdiscountState createState() => _StudentdiscountState();
}

class _StudentdiscountState extends State<Studentdiscount> {
  @override
  List<dynamic> dataList = [];
  List<dynamic> data = [];






  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.15),
      body: FutureBuilder(
        future: getStudentdiscountData(),
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
    var size = MediaQuery.of(context).size;




    return SingleChildScrollView(
      child: Container(
        color: Colors.white ,
        child: Column(
          children: [
            Container(

              decoration: BoxDecoration(color: Colors.white,

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, spreadRadius: 10, blurRadius: 3),
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
                          "Student discounts in Muscat",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                      ],
                    ),
                    SizedBox(height: 25),

                    SizedBox(
                      height: 30,
                    ),
                    Wrap(

                        spacing: 20,
                        children: List.generate(data.length, (index) {
                          if(data.length==0){
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
                                  left: 25, right: 25, top: 20, bottom: 20),
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
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              data[index]["Location"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
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
                  ],
                ),

              ),
            ),],),),);
  }
  Future getStudentdiscountData() async{
    List OfferList=[];


    final CollectionReference collectionref=FirebaseFirestore.instance.collection("Admin");
    try{
      await collectionref.doc("Studentdiscounts").collection("Studentdiscounts").get().then((querySnapshot){
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
