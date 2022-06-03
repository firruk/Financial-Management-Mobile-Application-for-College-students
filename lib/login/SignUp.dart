import 'package:budget/login/StudentInfo.dart';
import 'package:budget/login/login.dart';
import 'package:budget/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {




  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  String confirmpassword="";
  final formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        color: Colors.deepPurple[200],
        child:Form(
          key:formKey,
          child: Stack(
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
                    height: 500.0,
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
                          'Create Account',
                          style:TextStyle(
                            fontSize: 30.0,
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
                                child: Icon(Icons.mail),
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
                                      hintText: "Email Address",
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
                                child: Icon(Icons.lock),
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
                                      hintText: "password",
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
                      ),Container(

                        width: 250.0,
                        height: 60.0,
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
                                height: 70.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                ),

                                child: Padding(
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
                                      fontSize: 18.0,
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
                        width:150.0,
                        child: RaisedButton(
                          onPressed:(){

                          signUp();
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>StudentInfo()));
                          },
                          color:Colors.deepPurple,
                          textColor:Colors.white ,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "Register",
                            style:TextStyle(
                              fontSize: 20.0,

                            ),
                          ),

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?',
                            style:TextStyle(
                              color:Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 10,

                            ),
                          ),
                          GestureDetector(
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder:(context)=>login()));
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(color:Colors.deepPurple,
                                    fontSize: 10,
                                    decoration: TextDecoration.none,

                                    fontWeight: FontWeight.bold),
                              )
                          ),
                        ],
                      )


                    ],
                  ),


                ),

              ),
            ]
        ),),


      ),
    );

  }
  Future signUp() async{
    final isValid=formKey.currentState!.validate();
    if(!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'The Useremail and password already exists .Please try logging in or give another user email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 12.0);
      print('The Useremail and password already exists .Please try logging in or give another user email');
      }

  }


  }





