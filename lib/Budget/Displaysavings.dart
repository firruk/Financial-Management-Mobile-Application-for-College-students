import 'package:budget/Json/budget_json.dart';
import 'package:budget/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/updatedata.dart';

class DisplaySavingsprogress extends StatefulWidget {
  const DisplaySavingsprogress({Key? key}) : super(key: key);

  @override
  _DisplaySavingsprogressState createState() => _DisplaySavingsprogressState();
}

class _DisplaySavingsprogressState extends State<DisplaySavingsprogress> {

  int activeDay = DateTime.now().month - 1;
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
      backgroundColor: Colors.grey.withOpacity(0.10),
      body: FutureBuilder(
        future: FireStoreDataBase().getBudgetData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          getDataIncome().then((value) => incomelist = value);
          getDataExpense().then((value) => expenselist = value);

          getDataSavings().then((value) => savingslist = value);



          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;

            incomepercent = double.parse(
                ((incomelist[0]["monthlyincome"] / data[0]['Incomebudget']) *
                    100)
                    .toStringAsFixed(2));
            expensepercent = double.parse(
                ((expenselist[0]["monthlyExpense"] / data[0]['Expensebudget']) *
                    100)
                    .toStringAsFixed(2));
            spent = double.parse(((expenselist[0]["monthlyExpense"] /
                incomelist[0]['monthlyincome']) *
                100)
                .toStringAsFixed(2));
            saved = double.parse((incomelist[0]['monthlyincome'] -
                expenselist[0]["monthlyExpense"])
                .toStringAsFixed(3));
            if(savingslist==[]){
              const Center(child: CircularProgressIndicator());
            }
            else {
              savingsgoal = double.parse(
                  (saved / savingslist[0]['Savingsmonthly'] * 100)
                      .toStringAsFixed(2));
            }

            if (incomepercent > 100) {
              incomepercent = 100;
            }
            if (expensepercent > 100) {
              expensepercent = 100;
            }
            if (spent > 100) {
              spent = 100;
            }
            if (savingsgoal > 100) {
              savingsgoal = 100;
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

          SizedBox(
            height: 30,
          ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade400,
                  spreadRadius: 5,
                  blurRadius: 1,
                  // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.only(
                left: 25, right: 25, bottom: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Monthly Savings goal ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff67727d)),
                    ),

                  ],
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
                          saved.toString(),
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
                            savingsgoal.toString() + "%",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)
                                    .withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        savingslist[0]['Savingsmonthly'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color:
                            Color(0xff67727d).withOpacity(0.6)),
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
                      width: (size.width - 70),
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff67727d)),
                    ),
                    Container(
                      width: (size.width - 50) * savingsgoal / 100,
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "You have reached " +
                                savingsgoal.toString() +
                                "% of your Monthly Savings goal",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xff67727d)
                                    .withOpacity(1.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),





        ],
      ),
    );
  }


}


