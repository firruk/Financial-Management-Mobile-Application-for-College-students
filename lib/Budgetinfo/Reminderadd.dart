import 'package:budget/Budgetinfo/Expenses.dart';
import 'package:budget/pages/Reminderpage.dart';
import 'package:budget/Home/home.dart';
import 'package:budget/services/database_add1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

class Reminderadd extends StatefulWidget {
  const Reminderadd({Key? key}) : super(key: key);

  @override
  _ReminderaddState createState() => _ReminderaddState();
}

class _ReminderaddState extends State<Reminderadd> {
  @override
  String? dropdownvalue;
  bool isSwitched = false;
  DateTime selectedDate = DateTime.now();
  final TextEditingController Remindername=TextEditingController();
  final TextEditingController Reminderdate=TextEditingController();
  Widget build(BuildContext context) {
    return Form(
      child:Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        color: Colors.deepPurple[200],
        child:Stack(
            children:<Widget>[
              Align(
                alignment: Alignment.bottomRight,
                widthFactor: 0.5,
                heightFactor: 0.5,
                child:Material(
                  color: Color.fromRGBO(255,255, 255, 0.4),
                  borderRadius: BorderRadius.all(Radius.circular(200.0)),
                  child: Container(
                    width:500.0,
                    height: 500.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                widthFactor: 0.5,
                heightFactor: 0.5,
                child:Material(
                  color: Color.fromRGBO(255,255, 255, 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(200.0)),
                  child: Container(
                    width:400.0,
                    height: 400.0,
                  ),
                ),
              ),
              Center(
                child:Container(
                  width: 600,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                    children:<Widget>[


                      Container(
                        child: Text(
                          'Add Reminder',
                          style:TextStyle(
                            fontSize: 30.0,
                            backgroundColor: Colors.deepPurple[200],
                            decoration: TextDecoration.none,
                            color: Colors.white ,

                          ),),),




                      Container(

                        width: 250.0,
                        height: 50.0,
                        child: Material(
                          elevation: 5.0,
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.lock),
                              ),
                              Container(
                                width:200.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: TextFormField(
                                    
                                    controller:Remindername,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Reminder Name",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style:TextStyle(
                                      fontSize: 15.0,
                                      color:Colors.black,
                                    ) ,
                                    validator:(value)=>
                                    value!= null
                                        ?"Please enter the reminder name"
                                        :null,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.timelapse),
                              ),
                              Container(
                                width:200.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                ),

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



                                ),),],
                                  ),
                                ),
                              ),




                      Container(

                        width: 250.0,
                        height: 40.0,
                        child: Material(
                          elevation: 5.0,
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.mail),
                              ),
                              Container(
                                width:200.0,
                                height: 40.0,
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
                                      'Recurring',
                                      'Non Recurring',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:TextStyle(color:Colors.black),),
                                      );
                                    }).toList(),
                                    hint:Text(

                                      "Select Type of Reminder",
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





                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width:150.0,
                              child: RaisedButton(
                                onPressed:(){
                                  String remindername=Remindername.text;
                                  try {

                                    if (dropdownvalue == 'Recurring') {
                                      var dateadd = Jiffy(selectedDate);
                                      addReminder(
                                          remindername, selectedDate, dropdownvalue!);
                                      for (var i = 0; i < 3; ++i) {
                                         dateadd = dateadd
                                          ..add(months: 1);
                                        DateTime date = dateadd.dateTime;
                                        addReminder(
                                            remindername, date, dropdownvalue!);
                                      }
                                    }
                                    else{
                                      addReminder(remindername, selectedDate,
                                          dropdownvalue!);
                                    }

                                  }
                                  catch(e){
                                    Fluttertoast.showToast(
                                        msg: '$e',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  }


                                },
                                color:Colors.deepPurple,
                                textColor:Colors.white ,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Text(
                                  "Add",
                                  style:TextStyle(
                                    fontSize: 20.0,

                                  ),
                                ),

                              ),
                            ),
                          ),
                          Container(
                            width:150.0,
                            child: RaisedButton(
                              onPressed:(){
                                Navigator.push(context,MaterialPageRoute(builder:(contect)=>Reminderpage()));
                              },
                              color:Colors.deepPurple,
                              textColor:Colors.white ,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                "Back",
                                style:TextStyle(
                                  fontSize: 20.0,

                                ),
                              ),

                            ),
                          ),
                        ],
                      ),


                    ],
                  ),


                ),

              ),
            ]
        ),


      ),);

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
