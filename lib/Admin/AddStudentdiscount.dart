import 'package:budget/Admin/adminhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addStudentdiscounts extends StatefulWidget {
  const addStudentdiscounts({Key? key}) : super(key: key);

  @override
  _addStudentdiscountsState createState() => _addStudentdiscountsState();
}

class _addStudentdiscountsState extends State<addStudentdiscounts> {
  @override
  final TextEditingController Companyname=TextEditingController();
  final TextEditingController WebsiteLink=TextEditingController();
  final TextEditingController Location=TextEditingController();
  final TextEditingController Offer=TextEditingController();
  final TextEditingController Imagelink=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(

      body:SingleChildScrollView(
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                color: Colors.deepPurple[200],
                child:Stack(
                    children:<Widget>[
                      Align(
                        alignment: Alignment.bottomRight,
                        widthFactor: 0.5,
                        heightFactor: 0.5,
                        child:Material(
                          color: Color.fromRGBO(255,255, 255, 0.4),
                          borderRadius: BorderRadius.all(Radius.circular(200.0)),
                          child: Container(
                            width:500.0,
                            height: 800.0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 0.5,
                        heightFactor: 0.5,
                        child:Material(
                          color: Color.fromRGBO(255,255, 255, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(200.0)),
                          child: Container(
                            width:400.0,
                            height: 800.0,
                          ),
                        ),
                      ),
                      Center(
                        child:Container(
                          width: 600,
                          height: 550,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                            children:<Widget>[

                              Container(
                                child: Text(
                                  'Add Student Discounts',
                                  style:TextStyle(
                                    fontSize: 30.0,
                                    backgroundColor: Colors.deepPurple[200],
                                    decoration: TextDecoration.none,
                                    color: Colors.white ,

                                  ),),),






                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Companyname,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Company Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Location,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Location",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Imagelink,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Image Link",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Offer,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Offer details",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:WebsiteLink,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Website Link",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width:150.0,
                                      child: RaisedButton(
                                        onPressed:(){



                                          addOffers( Companyname.text, Location.text,  Offer.text,  Imagelink.text, WebsiteLink.text);




                                          Companyname.clear();
                                          Location.clear();
                                          Offer.clear();
                                          Imagelink.clear();
                                          WebsiteLink.clear();
                                        },



                                        color:Colors.deepPurple,
                                        textColor:Colors.white ,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                        child: Text(
                                          "Add",
                                          style:TextStyle(
                                            fontSize: 20.0,

                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:150.0,
                                    child: RaisedButton(
                                      onPressed:(){
                                        Navigator.push(context,MaterialPageRoute(builder:(context)=>AdminHome()));
                                      },
                                      color:Colors.deepPurple,
                                      textColor:Colors.white ,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      child: Text(
                                        "Home",
                                        style:TextStyle(
                                          fontSize: 20.0,

                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),


                        ),

                      ),
                    ]
                ),


              ),
            ],
          ),

      ),);
  }

  Future<void> addOffers( String Companyname,String Location, String Offer, String Imagelink, String WebsiteLink) async {

    CollectionReference users = FirebaseFirestore.instance.collection('Admin');
    final user= FirebaseAuth.instance.currentUser!;
    var now = DateTime.now();
    // Call the user's CollectionReference to add a new user
    return await users.doc("Studentdiscounts").collection("Studentdiscounts").add({
      "Companyname":Companyname,
      "Location":Location,
      "Offer": Offer,
      "ImageLink":Imagelink,
      "WebsiteLink":WebsiteLink,
      "dateuploaded":now
    })
        .then((value) { Fluttertoast.showToast(
        msg: 'added successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    })
        .catchError((error) { Fluttertoast.showToast(
        msg: 'Failed to add details: $error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    });
  }

}

