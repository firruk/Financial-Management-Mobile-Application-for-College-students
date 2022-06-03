import 'package:budget/pages/root_app.dart';
import 'package:budget/services/database_add1.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class liabilitiesadd extends StatefulWidget {
  const liabilitiesadd({Key? key}) : super(key: key);

  @override
  _liabilitiesaddState createState() => _liabilitiesaddState();
}

class _liabilitiesaddState extends State<liabilitiesadd> {


  var now = DateTime.now();
  bool _isVisible = false;
  bool _isVisiblebutton = true;
  var premiumamt;
  var interestamt;
  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  DateTime selectedDate = DateTime.now();
  final TextEditingController Amount=TextEditingController();
  final TextEditingController Liability=TextEditingController();
  final TextEditingController Remarks=TextEditingController();
  final TextEditingController Interestrate=TextEditingController();
  final TextEditingController time=TextEditingController();
  final TextEditingController Othersadd=TextEditingController();
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
                    width:700.0,
                    height: 700.0,
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
                    width:600.0,
                    height: 600.0,
                  ),
                ),
              ),
              Center(
                child:Container(
                  width: 600,
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                    children:<Widget>[

                      Container(
                        child: Text(
                          'Liability Information',
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

                                    controller: Liability,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Liability Name",
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
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: Amount,
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
                                  child: TextFormField(
                                    controller: Remarks,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Remarks",                                                                        fillColor: Colors.white,
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

                                                child: Text("Loan Acquired Date",),
                                              ),
                                              Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                            ],
                                          ),



                                        ),),],
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
                                  double amt=double.parse(Amount.text);
                                  String remark=Remarks.text;
                                  try {
                                    addLiability(
                                        Liability.text, amt,
                                        remark,selectedDate);
                                  }
                                  catch(e){
                                    Fluttertoast.showToast(
                                        msg: '$e',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  }
                                  Amount.clear();
                                  Remarks.clear();
                                  selectedDate = DateTime.now();



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
                                Navigator.push(context,MaterialPageRoute(builder:(context)=>RootApp()));
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

      });
  }}
