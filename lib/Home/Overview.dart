import 'package:budget/Budget/DisplayOffers.dart';
import 'package:budget/Budget/Displaysavings.dart';
import 'package:budget/Budget/Reminderdisplay.dart';

import 'package:budget/Budgetinfo/Income.dart';
import 'package:budget/Studentdiscounts/Offerspage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Budgetinfo/Expenses.dart';


class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }
  Widget getBody(){
    var size = MediaQuery.of(context).size;
    List expenses = [
      {
        "icon": Icons.message_outlined,
        "color": Colors.blueAccent,
        "label": "Rent Payment today",
        "cost": "OMR 200.00"
      },
      {
        "icon": Icons.message_outlined,
        "color": Colors.redAccent,
        "label": "Loan Payment next week",
        "cost": "OMR 150.000"
      },
      {
        "icon": Icons.message_outlined,
        "color": Colors.blueAccent,
        "label": "Rent Payment today",
        "cost": "OMR 200.00"
      },
      {
        "icon": Icons.message_outlined,
        "color": Colors.redAccent,
        "label": "Loan Payment next week",
        "cost": "OMR 150.000"
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),

          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: double.infinity,
              height: 210,
                color: Colors.white,



                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      child: DisplaySavingsprogress(),
                    ),
                  ],
                ),

            ),
          ),
          Text(
            "REMINDERS",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.deepPurple),
          ),
          SizedBox(
            height: 10.0   ,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: double.infinity,
              height:(size.width -10)/2 ,

              color: Colors.white,



              child: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: Remindersdisplay(),
                  ),
                ],
              ),

            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Offers for You",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.deepPurple),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20.0),
            child: Container(
              width: double.infinity,
              height:(size.width -10)/1.5 ,

              color: Colors.white,



              child: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(

                    ),
                    child: DisplayOffers(),
                  ),
                ],
              ),

            ),
          ),


          SizedBox(
            height: 8,
          ),
    InkWell(

    child: Padding(padding: EdgeInsets.all(15.0),
    child: Wrap(
    spacing: 20,

    children: [
    Container(
    width: (size.width - 60) ,
    height: 70,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.grey,
    spreadRadius: 10,
    blurRadius: 3,
    // changes position of shadow
    ),
    ]),
    child: Padding(
    padding: const EdgeInsets.only(
    left: 25, right: 25, top: 10.0, bottom:0.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Icon(
    Icons.calculate_sharp,
    color: Colors.green,
    size: 50,
    ),
    Text(
    "Add new monthly Expense",
    style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: Color(0xff67727d)),
    ),
    SizedBox(
    height: 8,
    ),


    ],
    ),
    ],
    ),
    ),
    ),],),),

    onDoubleTap:  () {
    Navigator.push(context,MaterialPageRoute(builder:(context)=>Expensesadd()));

    },),

          SizedBox(
            height: 8,
          ),
          InkWell(
          child: Padding(padding: EdgeInsets.all(15.0),
            child: Wrap(
              spacing: 20,

              children: [
                Container(
                  width: (size.width - 60) ,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10.0, bottom:0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.green,
                              size: 50,
                            ),
                            Text(
                              "Add new monthly Income",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(
                              height: 8,
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),],),),
    onDoubleTap:  () {
    Navigator.push(context,MaterialPageRoute(builder:(context)=>AddIncome()));

    },),
        ]
      ),
    );
  }
}
