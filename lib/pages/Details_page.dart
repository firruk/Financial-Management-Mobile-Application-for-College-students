
import 'package:budget/Budgetinfo/Expenses.dart';
import 'package:budget/Budgetinfo/Income.dart';
import 'package:budget/Budgetinfo/Liabilities.dart';
import 'package:budget/Details/Expensesdetails.dart';
import 'package:budget/Details/Incomedetails.dart';
import 'package:budget/Details/Liabilitiesdetails.dart';
import 'package:budget/Home/home.dart';
import 'package:flutter/material.dart';

class Detailspage extends StatefulWidget {
  const Detailspage({Key? key}) : super(key: key);

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  int pageIndex = 0;
  List<Widget> pages = [
    Incomedetails(),
    Expensedetails(),
    Liabilitydetails(),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 163, // Set this height
        flexibleSpace:
        Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white,
         borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0)),
                  boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  spreadRadius: 7,
                  blurRadius: 2,
                  // changes position of shadow
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, right: 20, left: 20, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Transcations",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[IconButton(
                            icon:Icon(Icons.add),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Add'),
                                  actions: <Widget>[
                                    Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.pink, // background
                                                  onPrimary: Colors.deepPurple, // foreground
                                                  fixedSize: Size(240,40),
                                                ),

                                                onPressed: () {
                                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>AddIncome()));
                                                },

                                                child:
                                                Text(
                                                  "Add Income",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),

                                                ),

                                              ),

                                              ElevatedButton(

                                                onPressed: () {
                                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>Expensesadd()));
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.pink, // background
                                                  onPrimary: Colors.deepPurple, // foreground
                                                  fixedSize: Size(240,40),

                                                ),
                                                child:
                                                Text(
                                                  "Add Expenses",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),),

                                              ),
                                              ElevatedButton(

                                                onPressed: () {
                                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>liabilitiesadd()));
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.pink, // background
                                                  onPrimary: Colors.deepPurple, // foreground
                                                  fixedSize: Size(240,40),

                                                ),
                                                child:
                                                Text(
                                                  " Add Liability",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),),

                                              ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },),

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
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Divider(
                          color: Colors.grey,
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
                                "Income",
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
                                "Expenses",
                                style: TextStyle(
                                    color: Colors.white
                                ),),

                            ),
                            ElevatedButton(

                              onPressed: () {
                                selectedTab(2);
                              },

                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink, // background
                                onPrimary: Colors.deepPurple, // foreground
                                fixedSize: Size(120,40),

                              ),
                              child:
                              Text(
                                "Liability",
                                style: TextStyle(
                                    color: Colors.white
                                ),),

                            ),

                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],),),


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




