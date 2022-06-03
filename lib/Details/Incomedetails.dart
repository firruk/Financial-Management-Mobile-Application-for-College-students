import 'package:budget/Json/day_month.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Json/daily_json.dart';

class Incomedetails extends StatefulWidget {
  const Incomedetails({Key? key}) : super(key: key);

  @override
  _IncomedetailsState createState() => _IncomedetailsState();
}

class _IncomedetailsState extends State<Incomedetails> {
  @override
  int activeDay = DateTime.now().month+1 ;



  double sum = 0.0;

  List<dynamic> dataList = [];
  List<dynamic> data = [];


  String? dropdownvalue;

  List student = [];


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
            sum = 0.0;
            dataList = [];
            for (var i = 0; i < data.length; i++) {

              if (data[i]["Income"].month == activeDay+1 ) {
                dataList.add(data[i]);
                sum += data[i]["incomeamt"];
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
      dates.add({"year": year, "month": i });
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                boxShadow: [
              BoxShadow(color: Colors.grey.shade300, spreadRadius: 10, blurRadius: 3),
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly income Transaction",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(dates.length, (index) {
                      scrollDirection:
                      Axis.horizontal;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            sum = 0.0;
                            dataList = [];
                            activeDay = index;


                            for (var i = 0; i < data.length; i++) {
                              if (data[i]["Income"].month == index) {
                                dataList.add(data[i]);
                                sum += data[i]["incomeamt"];
                              }
                            }
                          });
                        },
                        child: Container(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width - 40) / 7,
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
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
                children: List.generate(dataList.length, (index) {
              DateTime selectedDate =
                  (dataList[index]["Incomedate"] as Timestamp).toDate();
              var input = (dataList[index]["Incomedate"] as Timestamp).toDate();
              var Incomedate = DateFormat('dd/MM/yyyy').format(input);

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (size.width - 40) * 0.7,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Icon(
                                  Icons.money,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: (size.width - 90) * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataList[index]["Incometype"],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    dataList[index]["Incomename"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    Incomedate.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              dataList[index]["incomeamt"].toStringAsFixed(3),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      final TextEditingController  Incomeamtedit =  TextEditingController(text: dataList[index]["incomeamt"].toString());
                                      final TextEditingController  Incomenameedit =  TextEditingController(text: dataList[index]["Incomename"]);

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
                                                            width:250.0,
                                                            height: 70.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: TextFormField(


                                                                controller:Incomenameedit,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,// Removes the underline below the text
                                                                  hintText: "Income Name",
                                                                  label: Text("Income name"),
                                                                  fillColor: Colors.white,
                                                                  filled: true,
                                                                ),
                                                                style:TextStyle(
                                                                  fontSize: 20.0,
                                                                  color:Colors.black,
                                                                ) ,

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
                                                  Container(

                                                    width: 250.0,
                                                    height: 70.0,
                                                    child: Material(
                                                      elevation: 5.0,
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[

                                                          Container(
                                                            width:250.0,
                                                            height: 70.0,

                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: TextFormField(

                                                                keyboardType: TextInputType.number,
                                                                controller:Incomeamtedit,
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,// Removes the underline below the text
                                                                  hintText: "Income Amount",
                                                                  label: Text("Income Amount"),
                                                                  fillColor: Colors.white,
                                                                  filled: true,
                                                                ),
                                                                style:TextStyle(
                                                                  fontSize: 20.0,
                                                                  color:Colors.black,
                                                                ) ,

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
                                                  Container(

                                                    width: 250.0,
                                                    height: 60.0,
                                                    child: Material(
                                                      elevation: 5.0,
                                                      color: Colors.deepPurple,
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.arrow_circle_down),
                                                          ),
                                                          Container(
                                                            width:200.0,
                                                            height: 60.0,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: DropdownButton<String>(

                                                                focusColor:Colors.white,
                                                                value: dropdownvalue,
                                                                //elevation: 5,
                                                                style: TextStyle(color: Colors.white),
                                                                iconEnabledColor:Colors.black,
                                                                items: <String>[
                                                                  'Fixed Income',
                                                                  'Non-Fixed Income',
                                                                ].map<DropdownMenuItem<String>>((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value,style:TextStyle(color:Colors.black),),
                                                                  );
                                                                }).toList(),

                                                                hint:Text(

                                                                  "Select Type of Income",
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),

                                                                onChanged: (String? value) {


                                                                  setState(() {
                                                                    dropdownvalue = value;

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
                                                        padding:
                                                            const EdgeInsets.all(
                                                                3.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                _selectDate(
                                                                    context,
                                                                    selectedDate);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                minimumSize:
                                                                    const Size(
                                                                        200, 40),
                                                                maximumSize:
                                                                    const Size(
                                                                        200, 40),
                                                                primary: Colors
                                                                    .deepPurpleAccent,
                                                              ),
                                                              child: Text(
                                                                "Change Income Date",
                                                              ),
                                                            ),
                                                            Text(
                                                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
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
                                                        dataList[index].remove("Income");
                                                        updatedata(
                                                            dataList[index],
                                                            double.parse(Incomeamtedit
                                                                .text), );
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
                                                        "Are you sure you want to delete this Income ?",
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
                                                              dataList[index].remove("Income");
                                                              deleteData(dataList[index]);

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


                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 8),
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
                    sum.toString(),
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
          .collection("Income")
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
          .collection("Income")
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

  Future updatedata(Map<String, dynamic> deletedata, double Incomeamt) async {
    var datato = deletedata.toString();
    Map dataadd = Map<String, dynamic>();


    final CollectionReference collectionref =
        FirebaseFirestore.instance.collection("Student");

    final user = FirebaseAuth.instance.currentUser!;
    try {
      await collectionref
          .doc(user.uid)
          .collection("Income")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          dataadd[result.id] = result.data().toString();

        }
      });
      var Key = dataadd.keys
          .firstWhere((k) => dataadd[k] == datato, orElse: () => null);



      await collectionref.doc(user.uid).collection("Income").doc(Key).update({

          'incomeamt':Incomeamt,

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
    DateTime selectedDate = selecteddate;

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;

      });
  }
}
