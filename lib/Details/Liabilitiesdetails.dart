import 'package:budget/services/database.dart';
import 'package:budget/Json/day_month.dart';
import 'package:budget/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../Json/daily_json.dart';

class Liabilitydetails extends StatefulWidget {
  const Liabilitydetails({Key? key}) : super(key: key);

  @override
  _LiabilitydetailsState createState() => _LiabilitydetailsState();
}

class _LiabilitydetailsState extends State<Liabilitydetails> {
  int activeDay = DateTime.now().month - 1;
  double sum=0.0;


  List<dynamic> dataList = [];
  List<dynamic> data = [];
  List<dynamic> users = [];
  List<dynamic> studentList = [];

  String? dropdownvalue;

  List student = [];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.10),
      body: FutureBuilder(
        future: FireStoreDataBase().getLiabilityData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;

            data.sort((a, b) => a["Liabilitydate"].compareTo(b["Liabilitydate"]));


            for (var i = 0; i < data.length; i++) {
              DateTime date = (data[i]["Liabilitydate"] as Timestamp).toDate();
              data[i]["Liability"] = date;

            }

              sum = 0.0;
              dataList = [];
              for (var i = 0; i < data.length; i++) {

                if (data[i]["Liability"].month == activeDay+1 ) {
                  dataList.add(data[i]);
                  sum += data[i]["Liabilityttlamt"];
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
    var size = MediaQuery
        .of(context)
        .size;
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
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white30,
                      spreadRadius: 10,
                      blurRadius: 3),
                ]),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Liability Transaction",
                        style: TextStyle(
                            fontSize: 15,
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
                              if (data[i]["Liability"].month == index) {
                                dataList.add(data[i]);
                                sum += data[i]["Liabilityttlamt"];
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

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(

                children: List.generate(dataList.length, (index) {
                  DateTime selectedDate =
                  (dataList[index]["Liabilitydate"] as Timestamp).toDate();
                  var input = (dataList[index]["Liabilitydate"] as Timestamp).toDate();


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

                                Container(
                                  width: (size.width - 90) * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataList[index]["Liabilityname"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        dataList[index]["Liabilityamt"].toString(),
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
                                  dataList[index]["Liabilityttlamt"].toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
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
                                          final TextEditingController  Liabilityedit =  TextEditingController(text: dataList[index]["Liabilityttlamt"].toString());
                                          final TextEditingController  Liabilitynameedit =  TextEditingController(text: dataList[index]["Liabilityname"]);

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


                                                                        controller:Liabilitynameedit,
                                                                        decoration: InputDecoration(
                                                                          border: InputBorder.none,// Removes the underline below the text
                                                                          hintText: "Liability Name",
                                                                          label: Text("Liability name"),
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
                                                                        controller:Liabilityedit,
                                                                        decoration: InputDecoration(
                                                                          border: InputBorder.none,// Removes the underline below the text
                                                                          hintText: "Liability Amount",
                                                                          label: Text("LibilityAmount"),
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
                                                                dataList[index].remove("Liability");
                                                                updatedata(
                                                                  dataList[index],
                                                                  double.parse(Liabilityedit
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
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          deleteData(dataList[index]);
                                          setState(() {

                                          });
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
    List datato = deletedata as List;
    Map dataadd = Map<String, dynamic>();

    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");

    final user = FirebaseAuth.instance.currentUser!;
    try {
      await collectionref
          .doc(user.uid)
          .collection("Liability")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          dataadd[result.id] = result.data().toString();
        }
      });

      var Key = dataadd.keys
          .firstWhere((k) => dataadd[k] == datato, orElse: () => null);
      await collectionref
          .doc(user.uid)
          .collection("Liability")
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

  Future updatedata(Map<String, dynamic> deletedata, double Liabilityttlamt) async {
    var datato = deletedata.toString();
    Map dataadd = Map<String, dynamic>();


    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");

    final user = FirebaseAuth.instance.currentUser!;
    try {
      await collectionref
          .doc(user.uid)
          .collection("Liability")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          dataadd[result.id] = result.data().toString();

        }
      });
      var Key = dataadd.keys
          .firstWhere((k) => dataadd[k] == datato, orElse: () => null);



      await collectionref.doc(user.uid).collection("Liability").doc(Key).update({

        'Liabilityttlamt':Liabilityttlamt,

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

