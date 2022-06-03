
import 'package:budget/Charts/ExpenseBudgetbar.dart';
import 'package:budget/Charts/Incomebudgetbar.dart';
import 'package:budget/ML/Expense_prediction.dart';
import 'package:flutter/material.dart';
import '../ML/Income_prediction.dart';




class Homestats extends StatefulWidget {
  const Homestats({Key? key}) : super(key: key);

  @override
  _HomestatsState createState() => _HomestatsState();
}

class _HomestatsState extends State<Homestats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;


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
              height: 50,
            ),
            Column(
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        width: (size.width)/2 ,
                        height: 210,
                        color: Colors.white,



                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                              left: 40.0,right: 10.0
                              ),
                              child: ML_Income(),
                            ),
                          ],
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        width: (size.width)/2 ,
                        height: 210,
                        color: Colors.white,



                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 0,left: 10.0
                              ),
                              child: ML_expense(),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: (size.width-90   ) ,
                  height: 200,
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
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budgeted Expense",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d)),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                              width: (size.width - 177),
                              height: 150,
                              child:ExpenseBudgetbar()),
                        )
                      ],
                    ),
                  ),

                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: (size.width-90 ) ,
                  height: 200,
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
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budgeted Income",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d)),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                              width: (size.width - 177),
                              height: 150,
                              child:IncomeBudgetbar()),
                        )
                      ],
                    ),
                  ),

                ),
              ],
            ),











          ]
      ),
    );
  }

}
