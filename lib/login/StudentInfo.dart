import 'package:budget/Budgetinfo/Income.dart';
import 'package:budget/Json/colleges.dart';
import 'package:budget/login/AddIncomelogin.dart';
import 'package:budget/login/login.dart';
import 'package:budget/Home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({Key? key}) : super(key: key);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}
String dropdownvalue = "National University of Science and Technology";


class _StudentInfoState extends State<StudentInfo> {
  TextEditingController fullname = TextEditingController();
  TextEditingController Age = TextEditingController();
  late String Country="Sultanate of Oman";
  late String Universty;


  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width:700.0,
                  height: 700.0,
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
                  height: 400.0,
                ),
              ),
            ),
            Center(
              child:Container(
                width: 600,
                height: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                  children:<Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: Image.asset('assets/images/signupimages.jpg',width:320, height: 250.0)),
                    Container(
                      child: Text(
                        'Student Information',
                        style:TextStyle(
                          fontSize: 25.0,
                          backgroundColor: Colors.deepPurple[200],
                          decoration: TextDecoration.none,
                          color: Colors.white ,

                        ),),),
                    Container(

                      width: 250.0,
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                            Container(
                              width:200.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(
                                  controller: fullname,

                                  decoration: InputDecoration(
                                    border: InputBorder.none,// Removes the underline below the text
                                    hintText: "Full Name",
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
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                            Container(
                              width:200.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: Age,

                                  decoration: InputDecoration(
                                    border: InputBorder.none,// Removes the underline below the text
                                    hintText: "Age",
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
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.location_city),
                            ),
                            Container(
                              width:200.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(

                                  decoration: InputDecoration(
                                    enabled: false,
                                    border: InputBorder.none,// Removes the underline below the text
                                    hintText: "Sultanate of Oman",
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
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width:250.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                 value:dropdownvalue,
                                 icon: Icon(Icons.keyboard_arrow_down),
                                 items:colleges.map((String colleges) {
                                   return DropdownMenuItem(
                                       value: colleges,
                                       child: Text(colleges, style: TextStyle(
                                         fontSize: 12.0,
                                       ), overflow: TextOverflow.ellipsis
                                       ),
                                   );
                                 }
                                 ).toList(),


                                  onChanged: (newValue){
                                    setState(() {
                                      dropdownvalue =  dropdownvalue;
                                    });
                                  },


                               ),

                                ),
                              ),
                            ]),
                      ),),],
                        ),
                      ),
                    ),

                    Align(
                      alignment:Alignment.bottomCenter,
                      child:Container(
                        margin: const EdgeInsets.all(5),

                          child: FloatingActionButton.extended(
                                onPressed:() {

                                  String name=fullname.text;
                                  int age=int.parse(Age.text);

                                  addUser(name, age, Country, dropdownvalue);
                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>AddIncomelogin()));

                                },

                            backgroundColor: Colors.deepPurple,
                            icon:Icon(Icons.arrow_right_alt_rounded),

                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            label: Text("Next",
                              style:TextStyle(
                                fontSize: 20.0,

                              ),
                            ),

                          ),

                      )

                    )

    ],
                ),


              );


  }
  CollectionReference users = FirebaseFirestore.instance.collection('Student');

  Future<void> addUser(String fullname, int Age, String Country, String dropdownvalue) async {
    // Call the user's CollectionReference to add a new user
    final user= FirebaseAuth.instance.currentUser!;
    user.uid;
    return await users.doc(user.uid).set({
      'fullname': fullname,
      'Age': Age,
      "Country": Country,
      "University": dropdownvalue,

    })
    .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

    }






