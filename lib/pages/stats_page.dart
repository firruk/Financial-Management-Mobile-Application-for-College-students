import 'package:budget/Stats/Expensestats.dart';
import 'package:budget/Stats/Incomestats.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/pages/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int pageIndex = 0;
  List<Widget> pages = [
    Incomestats(),
    Expensestat(),


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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0)), boxShadow: [
                BoxShadow(

                  color: Colors.pink,
                  spreadRadius: 8,
                  blurRadius: 3,
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
                          "Stats",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[IconButton(
                            icon:Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RootApp()),);
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


