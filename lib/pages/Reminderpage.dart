import 'package:budget/Budgetinfo/Reminderadd.dart';
import 'package:budget/Json/day_month.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class Reminderpage extends StatefulWidget {
  const Reminderpage({Key? key}) : super(key: key);

  @override
  _ReminderpageState createState() => _ReminderpageState();
}

class _ReminderpageState extends State<Reminderpage> {
  @override
  int activeDay = DateTime.now().month - 1;
  bool isSwitched = false;
  DateTime selectedDate = DateTime.now();

  List<dynamic> dataList = [];
  List<dynamic> data = [];
  List<dynamic> users = [];
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
                dataList.add(data[i]);

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
    DateTime userdate = DateTime.parse("2022-01-10");
    DateTime now = DateTime.now();
    var month = userdate.month;
    var nowmonth = now.month;
    var year = userdate.year;
    var nowyear = now.year;


    for (var i = month; i <= nowmonth; i++) {

        dates.add({"year": year, "month": i});

    }


    final CollectionReference collectionref =
        FirebaseFirestore.instance.collection("Student");

    return SingleChildScrollView(
      child: Container(
        color: Colors.white ,
        child: Column(
          children: [
            Container(

              decoration: BoxDecoration(color: Colors.white,

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 10, blurRadius: 3),
              ]),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly Reminders",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reminderadd()),
                                );
                              },
                            ),
                            IconButton(
                              icon:Icon(Icons.home),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Homepage()),);
                              },),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: List.generate(dates.length, (index) {


                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                              dataList = [];
                              for (var i = 0; i < data.length; i++) {
                                if (data[i]["Reminder"].month == index ) {
                                  dataList.add(data[i]);

                                }
                              }

                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width-20 ) / 5,
                            child: Column(
                              children: [
                                Text(
                                  dates[index]["year"].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: activeDay == index
                                        ? Colors.pink
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: activeDay == index
                                          ? Colors.pink
                                          : Colors.black12,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      monthsname[dates[index]["month"]],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: activeDay == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ), ],
                  ),
                )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Wrap(

                spacing: 20,
                children: List.generate(dataList.length, (index) {
                  if(dataList.length==0){
                    Center(
                      child: Text(
                        "There are no REMINDERS",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    );
                  }


                  var input =
                      (dataList[index]["Reminderdate"] as Timestamp).toDate();
                  var Reminderdate = DateFormat('dd/MM/yyyy').format(input);
                  dropdownvalue=dataList[index]["Remindertype"];

                  return Container(

                    width: (size.width - 70),
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink,
                            spreadRadius: 3,
                            blurRadius: 1,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 30, bottom: 30),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        final TextEditingController
                                            Remindernameedit =
                                            TextEditingController(
                                                text: dataList[index]
                                                        ["Remindername"]
                                                    .toString());
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text("Edit data"),
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
                                                    color: Colors.deepPurple,
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[

                                                        Container(
                                                          width:245.0,
                                                          height: 80.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                                          ),

                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: TextFormField(
                                                          controller:
                                                          Remindernameedit,
                                                          decoration:
                                                          InputDecoration(
                                                            border:
                                                            InputBorder.none,
                                                            // Removes the underline below the text
                                                            hintText: dataList[
                                                            index][
                                                            "Remindername"]
                                                                .toString(),
                                                            label: Text("Reminder Name"),
                                                            fillColor:
                                                            Colors.white,
                                                            filled: true,
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),


                                          SizedBox(
                                            height: 10.0,

                                          ),
                                          Container(

                                            width: 250.0,
                                            height: 60.0,
                                            child: Material(
                                              elevation: 5.0,
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0)),//rounding the textfield borders
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.arrow_circle_down),
                                                  ),
                                                    Container(
                                                      width: 200.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.0))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: DropdownButton<
                                                            String>(
                                                          focusColor:
                                                              Colors.white,
                                                          value: dropdownvalue,
                                                          //elevation: 5,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          items: <String>[
                                                            'Recurring',
                                                            'Non Recurring',
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                            dropdownvalue.toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              dropdownvalue =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),

                                                    Center(
                                                      child: Container(
                                                        width: 200.0,
                                                        height: 70.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                    10.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                    10.0))),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              ElevatedButton(

                                                                onPressed: () {
                                                                  _selectDate(context);

                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  minimumSize: const Size(200, 40),
                                                                  maximumSize: const Size(200, 40),
                                                                  primary: Colors.deepPurpleAccent,
                                                                ),

                                                                child: Text("Choose Reminder Date",),
                                                              ),
                                                              Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                                            ],
                                                          ),



                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.pink,
                                                          // background
                                                          onPrimary:
                                                              Colors.deepPurple,
                                                          // foreground
                                                          fixedSize: Size(90, 30),
                                                        ),
                                                        onPressed: () {
                                                          dataList[index].remove("Reminder");
                                                          updatedata(
                                                              dataList[index],
                                                              Remindernameedit
                                                                  .text,
                                                              selectedDate,
                                                              dropdownvalue!);
                                                          setState(() {

                                                          });
                                                        },
                                                        child: Text(
                                                          "Confirm changes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                          Container(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: const Text("Delete data"),
                                              actions: <Widget>[
                                                Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Are you sure you want to delete this reminder ?",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff67727d)),
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              primary:
                                                                  Colors.pink,
                                                              // background
                                                              onPrimary: Colors
                                                                  .deepPurple,
                                                              // foreground
                                                              fixedSize:
                                                                  Size(90, 30),
                                                            ),
                                                            onPressed: () {
                                                              dataList[index].remove("Reminder");
                                                              deleteData(dataList[
                                                                  index]);

                                                              setState(() {

                                                              });
                                                            },
                                                            child: Text(
                                                              "Yes",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              primary:
                                                                  Colors.pink,
                                                              // background
                                                              onPrimary: Colors
                                                                  .deepPurple,
                                                              // foreground
                                                              fixedSize:
                                                                  Size(90, 30),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "No",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          ],
        ),

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
          msg: 'Data deleted successfully ',
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


  _selectDate(BuildContext context) async {
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