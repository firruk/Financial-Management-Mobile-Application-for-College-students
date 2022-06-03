import 'package:budget/Budgetinfo/Reminderadd.dart';
import 'package:budget/Json/day_month.dart';
import 'package:budget/pages/Reminderpage.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Remindersdisplay extends StatefulWidget {
  const Remindersdisplay({Key? key}) : super(key: key);

  @override
  _RemindersdisplayState createState() => _RemindersdisplayState();
}

class _RemindersdisplayState extends State<Remindersdisplay> {
  @override
  int activeDay = DateTime.now().month - 1;
  DateTime active=DateTime.now();

  var  formatted = (DateFormat('yyyy-MM-dd').format(DateTime.now()));



  List<dynamic> dataList = [];
  List<dynamic> data = [];
  List<dynamic> users = [];
  List<dynamic> studentList = [];
  String? dropdownvalue;
  List student = [];
  final TextEditingController Reminderdate = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.15),
      body: FutureBuilder(
        future: FireStoreDataBase().getReminderData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;
            data.sort((a, b) => a["Reminderdate"].compareTo(b["Reminderdate"]));


            for (var i = 0; i < data.length; i++) {
              DateTime date = (data[i]["Reminderdate"] as Timestamp).toDate();
              data[i]["Reminder"] = date;
            }



            dataList = [];
            for (var i = 0; i < data.length; i++) {

              if (data[i]["Reminder"].month == activeDay + 1) {
                if (data[i]["Reminder"].day== active.day) {
                  dataList.add(data[i]);
                }
                if (data[i]["Reminder"].isAfter(active)) {
                  dataList.add(data[i]);
                }
              }

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
    List dates = [];
    //DateTime? userdate=user.metadata.creationTime;
    DateTime userdate = DateTime.parse("2022-01-19");
    DateTime now = DateTime.now();
    var month = userdate.month;
    var nowmonth = now.month;
    var year = userdate.year;
    var nowyear = now.year;

    for (var i = month; i <= nowmonth; i++) {
      dates.add({"year": year, "month": i - 1});
    }
    if(dataList.isEmpty){
      Container(
        child: Center(
          child: Text(
            "There are no new REMINDERS",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0xff67727d)),
          ),
        ),
      );
    }

    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");

    return SingleChildScrollView(
      child: Column(
        children: [

      Center(
        child: InkWell(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    spacing: 20,
                    children: List.generate(dataList.length, (index) {


                      DateTime selectedDate =
                      (dataList[index]["Reminderdate"] as Timestamp).toDate();

                      var input =
                      (dataList[index]["Reminderdate"] as Timestamp).toDate();
                      var Reminderdate = DateFormat('dd/MM/yyyy').format(input);

                      return Container(
                        width: (size.width -70)/2,
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 3,
                                blurRadius: 1,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 30, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.pink),
                                    child: Center(
                                        child: Icon(
                                          Icons.timelapse,
                                          color: Colors.white,
                                        )),
                                  ),

                                ],
                              ),
                              Center(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataList[index]["Remindername"],
                                            style: TextStyle(

                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Color(0xff67727d)),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            Reminderdate.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ),
          onDoubleTap:  () {
            Navigator.push(context,MaterialPageRoute(builder:(context)=>Reminderpage()));

          },),
      ),
        ],
      ),
    );
  }

  Future deleteData(Map<String, dynamic> deletedata) async {
    List reminderdata = [];
    Map dataadd = Map<String, dynamic>();

    String datato = deletedata.toString();

    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");

    final user = FirebaseAuth.instance.currentUser!;
    try {
      await collectionref
          .doc(user.uid)
          .collection("Reminder")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          dataadd[result.id] = result.data().toString();
          reminderdata.add({result.id: result.data()});
        }
      });
      var Key = dataadd.keys
          .firstWhere((k) => dataadd[k] == datato, orElse: () => null);
      await collectionref
          .doc(user.uid)
          .collection("Reminder")
          .doc(Key)
          .delete();
      Fluttertoast.showToast(
          msg: 'Data deleted successfully successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      return Key;
    } catch (e) {
      debugPrint('Error - $e');
      Fluttertoast.showToast(
          msg: 'Failed to delete details: $e.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return null;
    }
  }

  Future updatedata(Map<String, dynamic> deletedata, String Remindername,
      DateTime Reminderdate, String Remindertype) async {
    List reminderdata = [];
    Map dataadd = Map<String, String>();

    String datato = deletedata.toString();

    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");

    final user = FirebaseAuth.instance.currentUser!;
    try {
      await collectionref
          .doc(user.uid)
          .collection("Reminder")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          dataadd[result.id] = result.data().toString();
          reminderdata.add({result.id: result.data().toString()});
        }
      });


      String Key = dataadd.keys.firstWhere((key) => dataadd[key]!.contains(datato));
      print(Key);
      await collectionref.doc(user.uid).collection("Reminder").doc(Key).update({
        'Remindername': Remindername,
        'Reminderdate': Reminderdate,
        "Remindertype": Remindertype
      });
      Fluttertoast.showToast(
          msg: 'Data updated successfully successfully',
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

  _selectDate(BuildContext context, DateTime selecteddate) async {
    DateTime selectedDate= selecteddate;
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        print(selectedDate);
      });
  }
}
