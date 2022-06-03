import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  List studentList=[];
  List reminderdata=[];
  List student=[];
  Map data = Map<String, dynamic>();
  final user= FirebaseAuth.instance.currentUser!;

  final CollectionReference collectionref=FirebaseFirestore.instance.collection("Student");
  Future getReminderData() async{
    try{
      await collectionref.doc(user.uid).collection("Reminder").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

          reminderdata.add({"id":result.id,result.id:result.data()});

        }
      });

      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }
  Future UserData() async{
    List studentList=[];
    DocumentSnapshot snapshot;
    final CollectionReference collectionref=FirebaseFirestore.instance.collection("Student");
    try{
      await collectionref.where(
          FieldPath.documentId,
          isEqualTo: user.uid
      ).get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

        }
      });


      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }
  Future getIncomeData() async{
    try{
      await collectionref.doc(user.uid).collection("Income").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

          reminderdata.add({"id":result.id,result.id:result.data()});

        }
      });

      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }
  Future getExpenseData() async{
    try{
      await collectionref.doc(user.uid).collection("Expenses").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

          reminderdata.add({"id":result.id,result.id:result.data()});

        }
      });

      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }
  Future getLiabilityData() async{
    try{
      await collectionref.doc(user.uid).collection("Liability").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

          reminderdata.add({"id":result.id,result.id:result.data()});

        }
      });

      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }
  Future getBudgetData() async{
    try{
      await collectionref.doc(user.uid).collection("Budget").get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          studentList.add(result.data());

          reminderdata.add({"id":result.id,result.id:result.data()});

        }
      });

      return studentList;
    }
    catch(e){
      debugPrint('Error - $e');
      return null;
    }
  }


}