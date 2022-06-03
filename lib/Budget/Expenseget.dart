
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/Json/budget_json.dart';
import 'package:budget/Json/day_month.dart';

import '../Json/day_month.dart';

class BudgetExpensedata extends StatefulWidget {
  const BudgetExpensedata({Key? key}) : super(key: key);

  @override
  _BudgetExpensedataState createState() => _BudgetExpensedataState();
}

class _BudgetExpensedataState extends State<BudgetExpensedata> {
  int activeDay = DateTime.now().month - 1;
  final _fireStore = FirebaseFirestore.instance;
  final user= FirebaseAuth.instance.currentUser!;

  double sum = 0.0;

  List<dynamic> dataList = [];
  List<dynamic> data = [];


  String? dropdownvalue;

  List student = [];
  Map dataadd = Map<String, dynamic>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.10),
      body: FutureBuilder(
        future: FireStoreDataBase().getIncomeData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;

            data.sort((a, b) => a["Incomedate"].compareTo(b["Incomedate"]));

            for (var i = 0; i < data.length; i++) {
              DateTime date = (data[i]["Incomedate"] as Timestamp).toDate();
              data[i]["Income"] = date;
            }
            sum = 0.0;
            dataList = [];
            for (var i = 0; i < data.length; i++) {
              if (data[i]["Income"].month == activeDay + 1) {
                dataList.add(data[i]);
                sum += data[i]["incomeamt"];
              }
            }


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
        children: [


          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                children: List.generate(budget_json.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 25, right: 25, bottom: 25, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              budget_json[index]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d).withOpacity(0.6)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      budget_json[index]['price'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        budget_json[index]['label_percentage'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color:
                                            Color(0xff67727d).withOpacity(0.6)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "OMR.5000.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xff67727d).withOpacity(0.6)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: (size.width - 40),
                                  height: 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xff67727d).withOpacity(0.1)),
                                ),
                                Container(
                                  width: (size.width - 40) *
                                      budget_json[index]['percentage'],
                                  height: 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: budget_json[index]['color']),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }


}
