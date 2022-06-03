import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

updateBudgetIncomedata(double Incomebudget) async {



  final CollectionReference collectionref =
  FirebaseFirestore.instance.collection("Student");

  final user = FirebaseAuth.instance.currentUser!;
  try {



    await collectionref.doc(user.uid).collection("Budget").doc("WyjmMt8BpHCAE4A0fful").update({

      'Incomebudget':Incomebudget,

    });
    Fluttertoast.showToast(
        msg: 'Data updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);

    return Key;
  } catch (e) {
    debugPrint('Error - $e');
    Fluttertoast.showToast(
        msg: 'Failed to update details: $e.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    return null;
  }
}

updateBudgetExpensedata(double Expensebudget) async {



  final CollectionReference collectionref =
  FirebaseFirestore.instance.collection("Student");

  final user = FirebaseAuth.instance.currentUser!;
  try {



    await collectionref.doc(user.uid).collection("Budget").doc("WyjmMt8BpHCAE4A0fful").update({

      'Expensebudget':Expensebudget,

    });
    Fluttertoast.showToast(
        msg: 'Data updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);

    return Key;
  } catch (e) {
    debugPrint('Error - $e');
    Fluttertoast.showToast(
        msg: 'Failed to update details: $e.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    return null;
  }
}
updateSavingsdata(double monthlysavings) async {



  final CollectionReference collectionref =
  FirebaseFirestore.instance.collection("Student");

  final user = FirebaseAuth.instance.currentUser!;
  try {



    await collectionref.doc(user.uid).collection("Savings").doc("IqDaEULg1hLYwGQXxPxD").update({

      'Savingsmonthly':monthlysavings,
      'Savingsannual':monthlysavings*12,


    });
    Fluttertoast.showToast(
        msg: 'Data updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);

    return Key;
  } catch (e) {
    debugPrint('Error - $e');
    Fluttertoast.showToast(
        msg: 'Failed to update details: $e.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    return null;
  }
}