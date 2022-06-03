import 'package:budget/login/AddExpenseslogin.dart';
import 'package:budget/Json/Budgetlists.dart';

import 'package:budget/services/database_add1.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:jiffy/jiffy.dart';

class AddIncomelogin extends StatefulWidget {
  const AddIncomelogin({Key? key}) : super(key: key);

  @override
  _AddIncomeloginState createState() => _AddIncomeloginState();
}

class _AddIncomeloginState extends State<AddIncomelogin> {
  bool _isVisible = false;
  bool _isVisiblebutton = true;
  bool _isVisibleadd = false;
  bool _isVisiblebuttonadd = false;


  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  void showToastadd() {
    setState(() {
      _isVisibleadd = !_isVisibleadd;
      _isVisiblebuttonadd=!_isVisiblebuttonadd;
    });
  }
  DateTime selectedDate = DateTime.now();
  final TextEditingController Remindername=TextEditingController();


  final TextEditingController Amount=TextEditingController();
  final TextEditingController Remarks=TextEditingController();
  final TextEditingController Othersadd=TextEditingController();
  String? Reminder;
  String? dropdownvalue;
  String? Incomename;






  @override
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
                    height: 800.0,
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
                    height: 800.0,
                  ),
                ),
              ),
              Center(
                child:Container(
                  width: 600,
                  height: 550,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                    children:<Widget>[

                      Container(
                        child: Text(
                          'Income Information',
                          style:TextStyle(
                            fontSize: 30.0,
                            backgroundColor: Colors.deepPurple[200],
                            decoration: TextDecoration.none,
                            color: Colors.white ,

                          ),),),


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
                                child: Icon(Icons.mail),
                              ),
                              Container(
                                width:200.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DropdownButton(

                                        // Initial Value
                                        value: Incomename,

                                        // Down Arrow Icon
                                        icon: const Icon(Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: incomeitems.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) async {
                                          setState(() {
                                            Incomename = newValue!;
                                            if (Incomename == "Others") {
                                              _isVisibleadd = true;
                                              _isVisiblebuttonadd = true;
                                            }
                                          });
                                        },
                                        hint:Text(
                                          "Select Income name",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: _isVisiblebuttonadd,

                            child:Center(
                              child: RaisedButton(

                                color:Colors.deepPurpleAccent,
                                textColor:Colors.white ,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                onPressed: () {
                                  showToastadd();
                                  if(Othersadd.text.isNotEmpty){
                                    incomeitems.add(Othersadd.text);

                                  }
                                },
                                child: Text(
                                  "Add Income name",
                                  style:TextStyle(
                                    fontSize: 17.0,

                                  ),
                                ),
                              ),
                            ),),
                          Visibility (
                            visible: _isVisibleadd,
                            child: Card(
                              color: Colors.deepPurpleAccent.withOpacity(0.0),
                              child: new ListTile(

                                title: Center(
                                  child:  Container(

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
                                            child: Icon(Icons.lock),
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
                                              child: TextField(

                                                controller:Othersadd,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,// Removes the underline below the text
                                                  hintText: "Income Name",
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
                                ),
                              ),
                            ),
                          ),

                        ],),

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
                                child: Icon(Icons.lock),
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
                                  child: TextFormField(

                                    keyboardType: TextInputType.number,
                                    controller:Amount,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Amount",
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
                                child: Icon(Icons.lock),
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
                                  child: TextField(
                                    controller:Remarks,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Remarks",
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    style:TextStyle(
                                      fontSize: 18.0,
                                      color:Colors.black,
                                    ) ,

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
                                  try {
                                    double amt = double.parse(Amount.text);
                                    String remark = Remarks.text;


                                      var nowdate = Jiffy();
                                      addIncome(dropdownvalue!, Incomename!, amt,
                                          remark, now);
                                      if (dropdownvalue == 'Fixed Income') {
                                        for (var i = 0; i < 6; ++i) {
                                          var dateadd = nowdate
                                            ..add(months: 1);
                                          DateTime date = dateadd.dateTime;
                                          addIncome(dropdownvalue!, Incomename!,
                                              amt, remark, date);
                                        }
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
                                  Remarks.clear();
                                  Amount.clear();


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
                                Navigator.push(context,MaterialPageRoute(builder:(context)=>addExpenseslogin()));
                              },
                              color:Colors.deepPurple,
                              textColor:Colors.white ,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                "Next",
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

      });
  }

}
