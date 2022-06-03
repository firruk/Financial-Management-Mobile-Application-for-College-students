import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:budget/login/SignUp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Admin/adminhome.dart';


class login extends StatefulWidget {


  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool _isemailValid = false;
  bool _ispasswordValid = false;


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  Widget build(BuildContext context) {
    return
    Form(
        child: Container(
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
                  width:400.0,
                  height: 400.0,
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
                width: 400,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                  children:<Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child:Image.asset('assets/images/loginimage6.jpg',width:320, height: 200.0),

                    ),

                    Container(

                      child: Text(
                        'FINANCEO',

                        style:TextStyle(
                          fontSize: 35.0,
                          backgroundColor: Colors.deepPurple[200],
                          color: Colors.white ,
                          decoration: TextDecoration.none,
                        ),),),

                Container(

                  width: 250.0,
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
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,// Removes the underline below the text
                                hintText: "Email Address",
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
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,// Removes the underline below the text
                                    hintText: "Password",
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
                      width:150.0,
                      child: RaisedButton(
                        onPressed:(){
                          if(emailController.text=="admin" && passwordController.text=="admin"){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>AdminHome()));

                          }
                        _isemailValid = EmailValidator.validate(emailController.text);
                        if (_isemailValid) {
                        signIn();
                        } else if (emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                        msg: 'Enter Email',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        fontSize: 15.0);
                        } else {
                        Fluttertoast.showToast(
                        msg: 'Enter a Valid Email',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                        print("'Enter a Valid Email'");
                        }
                          if (passwordController.text.isEmpty) {
                          Fluttertoast.showToast(
                          msg: "Please enter the password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          fontSize: 15.0);
                          signIn();    }
                        },

                        color:Colors.deepPurple,
                        textColor:Colors.white ,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          "login",
                          style:TextStyle(

                            fontSize: 20.0,

                          ),
                        ),

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dont have an account?',
                          style:TextStyle(
                            color:Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 10,

                          ),
                        ),
                        GestureDetector(
                            onTap:(){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>SignUpPage()));
                            },
                            child: const Text(
                              "Sign Up",
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
      ),


    ),);

  }

  Future signIn() async{

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(
          msg: 'No user found for that email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(
          msg: 'The password entered is wrong . Please try again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
          print('Wrong password provided .');
    }}
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}

