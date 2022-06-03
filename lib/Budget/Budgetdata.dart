import 'package:budget/Json/budget_json.dart';
import 'package:budget/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/updatedata.dart';

class BudgetData extends StatefulWidget {
  const BudgetData({Key? key}) : super(key: key);

  @override
  _BudgetDataState createState() => _BudgetDataState();
}

class _BudgetDataState extends State<BudgetData> {

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
            savingsgoal = double.parse(
                (saved / savingslist[0]['Savingsmonthly'] * 100)
                    .toStringAsFixed(2));

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
                      color: Colors.deepPurple.shade200,
                      spreadRadius: 5,
                      blurRadius: 1,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding:
                EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.pink),
                      child: Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          )),
                    ),
                    Text(
                      "Total Spent Summary",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff67727d)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Money Spent",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                      Color(0xff67727d).withOpacity(1.0)),
                                ),
                                Text(
                                  expenselist[0]['monthlyExpense'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.red.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 50.0),
                              child: Text(
                                spent.toString() + "%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color(0xff67727d).withOpacity(1.0)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Income in hand",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d).withOpacity(1.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                incomelist[0]['monthlyincome'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.green.withOpacity(0.6)),
                              ),
                            ),
                          ],
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
                              color: Colors.green.withOpacity(0.6)),
                        ),
                        Container(
                          width: (size.width - 50) * spent / 100,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.withOpacity(0.9)),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "You have spent " +
                                    spent.toString() +
                                    "% of the available income",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d).withOpacity(1.0)),
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

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade600,
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
                                "Income Budget",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d)),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                onPressed: () {
                                  final TextEditingController Incomebudget =
                                  TextEditingController(
                                      text: data[0]['Incomebudget']
                                          .toString());

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("Edit Income Budget "),
                                          actions: <Widget>[
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250.0,
                                                    height: 70.0,
                                                    child: Material(
                                                      elevation: 5.0,
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                      //rounding the textfield borders
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 250.0,
                                                            height: 70.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                        10.0),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        10.0))),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                              child: TextFormField(
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                controller:
                                                                Incomebudget,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  // Removes the underline below the text
                                                                  hintText:
                                                                  "Income Budget",
                                                                  label: Text("Income Budget"),

                                                                  fillColor:
                                                                  Colors.white,
                                                                  filled: true,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                  color:
                                                                  Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                      style:
                                                      ElevatedButton.styleFrom(
                                                        primary: Colors.pink,
                                                        // background
                                                        onPrimary:
                                                        Colors.deepPurple,
                                                        // foreground
                                                        fixedSize: Size(90, 30),
                                                      ),
                                                      onPressed: () {
                                                        updateBudgetIncomedata(
                                                          double.parse(
                                                              Incomebudget.text),
                                                        );
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Text(
                                                        "Confirm changes",
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
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
                                    incomelist[0]["monthlyincome"].toString(),
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
                                      incomepercent.toString() + "%",
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
                                  data[0]['Incomebudget'].toString(),
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
                                width: (size.width - 50) * incomepercent / 100,
                                height: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "You have reached " +
                                          incomepercent.toString() +
                                          "% of your income goal",
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade600,
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
                                "Expense Budget ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d)),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                onPressed: () {
                                  final TextEditingController Expensebudget =
                                  TextEditingController(
                                      text: data[0]['Expensebudget']
                                          .toString());

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("Edit Expense Budget "),
                                          actions: <Widget>[
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250.0,
                                                    height: 70.0,
                                                    child: Material(
                                                      elevation: 5.0,
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                      //rounding the textfield borders
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 250.0,
                                                            height: 70.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                        10.0),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        10.0))),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                              child: TextFormField(
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                controller:
                                                                Expensebudget,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  // Removes the underline below the text
                                                                  hintText:
                                                                  "Expense Budget",
                                                                  label: Text("Expense Budget"),


                                                                  fillColor:
                                                                  Colors.white,
                                                                  filled: true,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                  color:
                                                                  Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                      style:
                                                      ElevatedButton.styleFrom(
                                                        primary: Colors.pink,
                                                        // background
                                                        onPrimary:
                                                        Colors.deepPurple,
                                                        // foreground
                                                        fixedSize: Size(90, 30),
                                                      ),
                                                      onPressed: () {
                                                        updateBudgetExpensedata(
                                                          double.parse(
                                                              Expensebudget.text),
                                                        );
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Text(
                                                        "Confirm changes",
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
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
                                    expenselist[0]['monthlyExpense'].toString(),
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
                                      expensepercent.toString() + "%",
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
                                  data[0]['Expensebudget'].toString(),
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
                                width: (size.width - 50) * expensepercent / 100,
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
                                          expensepercent.toString() +
                                          "% of your expensebudget",
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.shade600,
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
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                onPressed: () {
                                  final TextEditingController monthlySavings =
                                  TextEditingController(
                                      text: savingslist[0]['Savingsmonthly']
                                          .toString());

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("Edit Expense Budget "),
                                          actions: <Widget>[
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250.0,
                                                    height: 70.0,
                                                    child: Material(
                                                      elevation: 5.0,
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                      //rounding the textfield borders
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 250.0,
                                                            height: 70.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                        10.0),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                        10.0))),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                              child: TextFormField(
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                controller:
                                                                monthlySavings,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  // Removes the underline below the text
                                                                  hintText:
                                                                  "Monthly Savings",
                                                                  label: Text("Monthly Savings"),


                                                                  fillColor:
                                                                  Colors.white,
                                                                  filled: true,
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                  color:
                                                                  Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                      style:
                                                      ElevatedButton.styleFrom(
                                                        primary: Colors.pink,
                                                        // background
                                                        onPrimary:
                                                        Colors.deepPurple,
                                                        // foreground
                                                        fixedSize: Size(90, 30),
                                                      ),
                                                      onPressed: () {
                                                        updateSavingsdata(
                                                          double.parse(
                                                              monthlySavings.text),
                                                        );
                                                        setState(() {

                                                        });
                                                      },
                                                      child: Text(
                                                        "Confirm changes",
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
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
          ),
        ],
      ),
    );
  }


}


