import 'package:budget/Home/home.dart';
import 'package:budget/services/database_add1.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Savingsadd extends StatefulWidget {
  final double savings;
  const Savingsadd(this.savings, {Key? key}) : super(key: key);


  @override
  _SavingsaddState createState() => _SavingsaddState();
}

class _SavingsaddState extends State<Savingsadd> {
  @override


  Widget build(BuildContext context) {
    double savingsannnualamt=widget.savings*12;
    double savings=widget.savings;
    final TextEditingController Savingsannual=TextEditingController(text: savingsannnualamt.toString());
    final TextEditingController Savingsmonthly=TextEditingController(text: savings.toString());



    List savingsannual=[];
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
                  width: 700,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                    children:<Widget>[

                      Container(
                        child: Text(
                          'Savings Information',
                          style:TextStyle(
                            fontSize: 30.0,
                            backgroundColor: Colors.deepPurple[200],
                            decoration: TextDecoration.none,
                            color: Colors.white ,

                          ),),),



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
                                child: Icon(Icons.money),
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
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller:Savingsmonthly,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Enter savings amount",
                                      label: Text("Monthly savings goal"),
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
                                child: Icon(Icons.money),
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
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller:Savingsannual,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,// Removes the underline below the text
                                      hintText: "Enter savings amount",
                                      label: Text("Annual savings goal"),
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


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width:150.0,
                              child: RaisedButton(
                                onPressed:(){
                                  if(Savingsmonthly.text.isEmpty && Savingsmonthly.text.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: 'Please enter the values to go the next step',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);

                                  }
                                  else {
                                    double savingsannual = double.parse(
                                        Savingsannual.text);
                                    double savingsmonthly = double.parse(
                                        Savingsmonthly.text);
                                    addSavings(savingsmonthly, savingsannual);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Homepage()));
                                  }
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
                          ),

                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              'Inorder to reach the savings goal you want to reach , please add the annual savings amount . This data will help u reach your annual goal',
                              style:TextStyle(
                                fontSize: 10.0,
                                backgroundColor: Colors.deepPurple[200],
                                decoration: TextDecoration.none,
                                color: Colors.white ,

                              ),),),
                        ),
                      ),


                    ],
                  ),


                ),

              ),
            ]
        ),


      ),);
  }
}

