import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';


import '../services/database.dart';

class ML_Income extends StatefulWidget {
  const ML_Income({Key? key}) : super(key: key);

  @override
  State<ML_Income> createState() => _ML_IncomeState();
}

class _ML_IncomeState extends State<ML_Income> {
  final user= FirebaseAuth.instance.currentUser!;
  int activeDay = DateTime.now().month ;

  List<dynamic> dataList = [];
  List<dynamic> data = [];
  double sum = 0.0;
  String predictedvalue="";


  @override
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

            List<List<Object>>incomedata=[];

            var ttl;
            for (var i = 1; i <= activeDay; i++){
              ttl=getsum(i);
              incomedata.add([i,ttl]);

            }
            print(incomedata);
            predictedvalue=ML(incomedata);

            return getBody();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getBody() {
    return Scaffold(
      body:Container(
        width: 150 ,
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
          padding: const EdgeInsets.only(
              left: 15, right: 15, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: Center(
                    child: Icon(
                      Icons.adb_outlined,
                      color: Colors.white,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Predicted Income for next month",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xff67727d)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "OMR."+predictedvalue.substring(2,9),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  getsum(int Income){
    double sumvalue=0.0;
    dataList = [];
    for (var i = 0; i < data.length; i++) {

      if (data[i]["Income"].month == Income ) {
        dataList.add(data[i]);
        sumvalue += data[i]["incomeamt"];
      }
    }

    return sumvalue;
  }

  ML(List<List<Object>>incomedata) {

    int row=incomedata.length+1;

    var _data = incomedata..map((it) => [it, it]) ;

    final data = [['x', 'y'], ..._data];



    final samples = DataFrame(data, headerExists: true);
    final regressor = LinearRegressor(samples, 'y');


    var prediction = regressor.predict(DataFrame([['x', 'y'], [row]],));
    var predictedvalue=prediction.rows.toString();

    return predictedvalue;




  }


}



