import 'package:budget/login/login.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  @override
  List data=[];

  final user= FirebaseAuth.instance.currentUser!;
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();



  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body:  FutureBuilder(
        future: FireStoreDataBase().UserData(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      IconButton(
                        icon:Icon(Icons.home),
                        onPressed: ()  {
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>Homepage()));
                        },),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.grey.withOpacity(0.3),
                                    radius: 110.0,
                                    lineWidth: 6.0,
                                    percent: 0.53,
                                    progressColor: Colors.pink),
                              ),
                              Positioned(
                                top: 16,
                                left: 13,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             user.email!,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user.email!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),

                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: IconButton(
                                icon:Icon(Icons.edit),
                                onPressed: () async {
                                  final TextEditingController emailController=TextEditingController(text: user.email);
                                  final TextEditingController passwordController=TextEditingController();

                                showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                title: const Text("Edit user details"),
                                actions: <Widget>[
                                Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Color(0xff67727d)),
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
                                        child: TextFormField(
                                          controller: emailController,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator:(email)=>
                                          email!= null && !EmailValidator.validate(email)
                                              ?"Enter a valid email"
                                              :null,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,// Removes the underline below the text
                                            hintText: "Enter email address",
                                            fillColor: Colors.white,
                                            filled: true,

                                          ),
                                          style:TextStyle(
                                            fontSize: 15.0,
                                            color:Colors.black,
                                          ) ,

                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Color(0xff67727d)),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TextFormField(
                                        controller: passwordController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator:(value)=>
                                        value!= null && value.length<6
                                            ?"Enter min. 6 characters"
                                            :null,
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        decoration: InputDecoration(
                                          border: InputBorder.none,// Removes the underline below the text
                                          hintText: "Enter password",
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        style:TextStyle(
                                          fontSize: 15.0,
                                          color:Colors.black,
                                        ) ,

                                      ),
                                    ),
                                    Text(
                                      "Confirm Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Color(0xff67727d)),
                                    ),
                                     Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator:(value)=>
                                        value!= null && value!=passwordController.text
                                            ?"The confirm password is not the same as the password entered"
                                            :null,
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        decoration: InputDecoration(
                                          border: InputBorder.none,// Removes the underline below the text
                                          hintText: "Confirm password",                                                                        fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        style:TextStyle(
                                          fontSize: 15.0,
                                          color:Colors.black,
                                        ) ,

                                      ),
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.pink, // background
                                          onPrimary: Colors.deepPurple, // foreground
                                          fixedSize: Size(90,30),
                                        ),

                                        onPressed: () {


                                          Navigator.of(context).pop();

                                        },

                                        child:
                                        Text(
                                          "Confirm changes",
                                          style: TextStyle(
                                              color: Colors.white
                                          ),

                                        ),

                                      ),
                                    ),


                                  ],
                                  ),
                                ),
                                ),

                                ],
                                ),
                                );
                                }


                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "fullname",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        Text(
                          data[0]['fullname'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Country",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        Text(
                          data[0]['Country'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "University",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        Text(
                          data[0]['University'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Container(
              width:150.0,
              child: RaisedButton(
                onPressed:(){
                 FirebaseAuth.instance.signOut();
                 Navigator.push(context,MaterialPageRoute(builder:(context)=>login()));
                },
                color:Colors.pink,
                textColor:Colors.white ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Text(
                  "Sign Out",
                  style:TextStyle(
                    fontSize: 20.0,

                  ),
                ),

              ),
            ),
          ),
        ],

      ),
    );
  }


}
