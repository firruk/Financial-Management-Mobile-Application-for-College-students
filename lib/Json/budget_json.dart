

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

int activeDay = DateTime.now().month - 1;




final user= FirebaseAuth.instance.currentUser!;
final CollectionReference collectionref=FirebaseFirestore.instance.collection("Student");
 getDataIncome() async{
  List budget_income=[];
  List data=[];
  try{
    await collectionref.doc(user.uid).collection("Income").get().then((querySnapshot){
      for (var result in querySnapshot.docs){
        data.add(result.data());      }
      data.sort((a, b) => a["Incomedate"].compareTo(b["Incomedate"]));

      for (var i = 0; i < data.length; i++) {
        DateTime date = (data[i]["Incomedate"] as Timestamp).toDate();
        data[i]["Income"] = date;
      }
      double sum = 0.0;
      double ttlsum = 0.0;
      List<dynamic> dataList = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]["Income"].month == activeDay + 1) {
          dataList.add(data[i]);
          sum += data[i]["incomeamt"];
        }
        ttlsum += data[i]["incomeamt"];
      }
      budget_income.add({"ttlIncome":ttlsum,"monthlyincome":sum});


    }


    );


    return budget_income as List;
  }
  catch(e){
    debugPrint('Error - $e');
    return null;
  }
}
Future getDataExpense() async{
  List budget_expense=[];
  List data=[];
  try{
    await collectionref.doc(user.uid).collection("Expenses").get().then((querySnapshot){
      for (var result in querySnapshot.docs){
        data.add(result.data());      }
      data.sort((a, b) => a["Expensedate"].compareTo(b["Expensedate"]));

      for (var i = 0; i < data.length; i++) {
        DateTime date = (data[i]["Expensedate"] as Timestamp).toDate();
        data[i]["Expense"] = date;
      }
      double sum = 0.0;
      double ttlsum = 0.0;
      List<dynamic> dataList = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]["Expense"].month == activeDay + 1) {
          dataList.add(data[i]);
          sum += data[i]["Expenseamt"];
        }
        ttlsum += data[i]["Expenseamt"];
      }
      budget_expense.add({"ttlExpense":ttlsum,"monthlyExpense":sum});


    }
    );



    return budget_expense;
  }
  catch(e){
    debugPrint('Error - $e');
    return null;
  }
}
Future getData2() async{
  List budget_expense=[];
  List data=[];
  try{
    await collectionref.doc(user.uid).collection("Expenses").get().then((querySnapshot){
      for (var result in querySnapshot.docs){
        data.add(result.data());      }
      data.sort((a, b) => a["Expensedate"].compareTo(b["Expensedate"]));

      for (var i = 0; i < data.length; i++) {
        DateTime date = (data[i]["Expensedate"] as Timestamp).toDate();
        data[i]["Expense"] = date;
      }
      double sum = 0.0;
      double ttlsum = 0.0;
      List<dynamic> dataList = [];
      for (var i = 0; i < data.length; i++) {
        if (data[i]["Expense"].month == activeDay + 1) {
          dataList.add(data[i]);
          sum += data[i]["Expenseamt"];
        }
        ttlsum += data[i]["Expenseamt"];
      }
      budget_expense.add({"ttlExpense":ttlsum,"monthlyExpense":sum});


    }
    );



    return budget_expense;
  }
  catch(e){
    debugPrint('Error - $e');
    return null;
  }
}
Future getDataSavings() async{
  List budget_expense=[];
  List data=[];
  try{
    await collectionref.doc(user.uid).collection("Savings").get().then((querySnapshot){
      for (var result in querySnapshot.docs){
        data.add(result.data());      }



    }

    );



    return data;
  }
  catch(e){
    debugPrint('Error - $e');
    return null;
  }
}
Future getBudget() async{

  List data=[];
  try{
    await collectionref.doc(user.uid).collection("Budget").get().then((querySnapshot){
      for (var result in querySnapshot.docs){
        data.add(result.data());


      }
    }


    );
    return data;
  }
  catch(e){
    debugPrint('Error - $e');
    return null;
  }
}

const List budget_json = [
  {
    "name": "Income",
    "price": "OMR.2250.00",
    "label_percentage": "45%",
    "percentage": 0.45,
    "color": Colors.green,
  },
  {
    "name": "Expenses",
    "price": "OMR.3000.00",
    "label_percentage": "70%",
    "percentage": 0.7,
    "color": Colors.redAccent,
  },
  {
    "name": "Liability",
    "price": "OMR.4000.00",
    "label_percentage": "90%",
    "percentage": 0.9,
    "color": Colors.blueAccent,
  }
];






