import 'package:budget/login/login.dart';
import 'package:budget/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final navigatorKey=GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      navigatorKey:navigatorKey,
      home:Screen()
  ));
}


class Screen extends StatelessWidget{
  @override

  Widget build(BuildContext context) =>Scaffold(


    // TODO: implement build

      body:
      StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Homepage();
            }else {
              return login();
            }
          }
      ),
    );
  }

