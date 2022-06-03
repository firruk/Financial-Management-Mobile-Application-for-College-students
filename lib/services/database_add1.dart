import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Student');
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
String udate = dateFormat.format(DateTime.now());
final user= FirebaseAuth.instance.currentUser!;
var now = DateTime.now();


Future<void> addIncome( String Incometype,String Incomename, double incomeamt, String Remarks, DateTime Incomedate) async {
  // Call the user's CollectionReference to add a new user
  if(Incometype=="Fixed Income"){

  }
  return await users.doc(user.uid).collection("Income").add({
      'Incometype': Incometype,
    "Incomename":Incomename,
      'incomeamt': incomeamt,
      'Remarks': Remarks,
      "Incomedate":Incomedate
  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Income added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}


Future<void> addReminder( String Remindername, DateTime Reminderdate, String Remindertype) async {
  // Call the user's CollectionReference to add a new user
  return await users.doc(user.uid).collection("Reminder").add({

      'Remindername':Remindername,
      'Remindertype':Remindertype,
      "Reminderdate":Reminderdate,

  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Reminder added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}


Future<void> addLiability( String Liabilityname, double amt, String Remarks, DateTime selecteddate) async {
  // Call the user's CollectionReference to add a new user
  return await users.doc(user.uid).collection("Liability").add({


      "Liabilityname":Liabilityname,
      'Liabilityttlamt':amt,
    'Liabilityamt':amt,
      'Remarks':Remarks,
      "Liabilitydate":selecteddate

  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Liability added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}


Future<void> addExpense( String Expensetype,String Expensename, double amt, String Remarks, DateTime Expensedate) async {
  // Call the user's CollectionReference to add a new user
  return await users.doc(user.uid).collection("Expenses").add({

      'Expensetype':Expensetype,
      "Expensename":Expensename,
      'Expenseamt':amt,
      'Remarks':Remarks,
      "Expensedate":Expensedate,

  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Expenses added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}


Future<void> addBudget(double incomebudget, double Expensebudget) async {
  // Call the user's CollectionReference to add a new user
  final user= FirebaseAuth.instance.currentUser!;
  user.uid;
  return await users.doc(user.uid).collection("Budget").add({

      'Incomebudget':incomebudget,
      "Expensebudget":Expensebudget,

       "Budgetdate":now

  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Budget added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}
Future<void> addSavings(double savingsmonthly, double savingsannual) async {
  // Call the user's CollectionReference to add a new user
  final user= FirebaseAuth.instance.currentUser!;
  user.uid;
  return await users.doc(user.uid).collection("Savings").add({

    'Savingsmonthly':savingsmonthly,
    "Savingsannual":savingsannual,
    "Savingsdate":now

  })
      .then((value) { Fluttertoast.showToast(
      msg: 'Savings added successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  })
      .catchError((error) { Fluttertoast.showToast(
      msg: 'Failed to add details: $error.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
  });
}