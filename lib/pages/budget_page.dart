import 'package:budget/Budget/Budgetdata.dart';

import 'package:budget/Json/budget_json.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/pages/root_app.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Budget/Loandata.dart';
import '../services/updatedata.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int pageIndex = 0;
  List<Widget> pages = [
   BudgetData(),
    LoanData()

  ];
  int activeDay = DateTime.now().month - 1;
  final _fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  var now = DateFormat('dd/MM/yyyy').format(DateTime.now());

  double incomepercent = 0.0;
  double expensepercent = 0.0;
  List incomelist = [];
  List expenselist = [];
  List savingslist = [];
  double spent = 0.0;
  double saved = 0.0;
  double savingsgoal = 0.0;

  List<dynamic> dataList = [];
  List<dynamic> data = [];

  String? dropdownvalue;

  List student = [];
  Map dataadd = Map<String, dynamic>();

  Widget build(BuildContext context) {
    incomelist = [];
    expenselist = [];
    savingslist = [];

    return Scaffold(

        body: getBody(),
    appBar: AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    toolbarHeight: 180, // Set this height
    flexibleSpace:

    Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  spreadRadius: 7,
                  blurRadius: 3,

                  // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 70, right: 20, left: 20, bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Monthly Budget Progress",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        IconButton(
                          icon:Icon(Icons.home),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Homepage()),);
                          },),],),
                  ],
                ),
                SizedBox(
                  height: 28,
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children:[

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // background
                        onPrimary: Colors.deepPurple, // foreground
                        fixedSize: Size(120,40),
                      ),

                      onPressed: () {
                        selectedTab(0);
                      },

                      child:
                      Text(
                        "Budget Data",
                        style: TextStyle(
                            color: Colors.white
                        ),

                      ),

                    ),

                    ElevatedButton(

                      onPressed: () {
                        selectedTab(1);
                      },

                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // background
                        onPrimary: Colors.deepPurple, // foreground
                        fixedSize: Size(120,40),

                      ),
                      child:
                      Text(
                        "Loan Data",
                        style: TextStyle(
                            color: Colors.white
                        ),),

                    ),


                  ],
                ),

              ],
            ),
          ),
        ),

      ],
    ),
    ),


    );
  }



  Widget getBody(){
    return IndexedStack(
      index:pageIndex,
      children: pages,
    );
  }
  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }


}


