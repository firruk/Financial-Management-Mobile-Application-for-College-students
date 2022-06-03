import 'package:budget/Json/daily_json.dart';
import 'package:flutter/material.dart';

import 'package:budget/Json/day_month.dart';



class DailyPage extends StatefulWidget {


  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int activeDay=3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.10),
      body: getBody(),
    );
  }
  Widget getBody(){
    var size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color:Colors.white,
              boxShadow:[
                BoxShadow(
                  color:Colors.white30,
                  spreadRadius: 10,
                  blurRadius: 3),
            ]),
            child: Padding(
              padding: EdgeInsets.only(top:60,bottom:25, right:20, left:20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Transaction insights",
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                  SizedBox(
                      height: 25
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(months.length,(index){
                      return GestureDetector(
                        onTap:(){
                          setState(() {
                            activeDay=index;
                          });
                        },

                      child: Container(
                        width: (MediaQuery.of(context).size.width - 40) / 7,
                          child:Column(
                            children: [
                              Text(
                                months[index]['label'],
                                style: TextStyle(fontSize: 15),),
                              SizedBox(height:10),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:activeDay==index ?Colors.pink :Colors.transparent,
                                  shape: BoxShape.circle,
                                  border:Border.all(color:activeDay==index ?Colors.pink :Colors.black12,),

                                ),
                                child: Center(
                                  child: Text(
                                    months[index]['day'],
                                    style: TextStyle(fontSize: 15, color: activeDay==index?Colors.white: Colors.black,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left:20,right: 20),
            child: Column(
           children: List.generate(daily.length, (index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width-40)*0.7,
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Image.asset(
                                daily[0]['icon'],
                                  width:30,
                                  height:30,
                              ),

                            ),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            width: (size.width-90)*0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start ,
                              children: [
                                Text(
                                  daily[index]['name'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  daily[index]['date'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: (size.width-40)*0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            daily[index]['price'], style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                              color: daily[index]['color']

                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65,top: 8),
                  child: Divider(
                    thickness: 0.8,

                  ),
                )
              ],
            );

          })),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black26,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "\$1780.00",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
              

      ),
    );
  }
}
