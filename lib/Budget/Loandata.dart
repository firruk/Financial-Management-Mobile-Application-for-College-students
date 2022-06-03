import 'package:budget/services/database.dart';
import 'package:budget/services/database_add1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Json/budget_json.dart';

class LoanData extends StatefulWidget {
  const LoanData({Key? key}) : super(key: key);

  @override
  _LoanDataState createState() => _LoanDataState();
}

class _LoanDataState extends State<LoanData> {
  @override
  double sum = 0.0;
  double sumttl=0.0;
  double loanpercent=0.0;

  List<dynamic> dataList = [];
  List<dynamic> data = [];

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
            sum=0.0;
            sumttl=0.0;
            data = snapshot.data as List;

            data.sort(
                (a, b) => a["Liabilitydate"].compareTo(b["Liabilitydate"]));

            for (var i = 0; i < data.length; i++) {

                sum += data[i]["Liabilityamt"];
                sumttl += data[i]["Liabilityttlamt"];

            }

              loanpercent=double.parse(((sum/sumttl)*100).toStringAsFixed(2));
            return getBody();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.pink,
                    ),
                    Text(" - add loan repayment details"
                    ,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade200,
                      spreadRadius: 5,
                      blurRadius: 1,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding:
                EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.pink),
                      child: Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          )),
                    ),
                    Text(
                      "Total Loan Summary",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff67727d)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Total Loan to Pay",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color:
                                      Color(0xff67727d).withOpacity(1.0)),
                                ),
                                Text(
                                 sum.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.red.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 3, left: 50.0),
                              child: Text(
                              loanpercent.toString() + "%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color(0xff67727d).withOpacity(1.0)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Total Loans taken",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d).withOpacity(1.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                sumttl.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.green.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: (size.width - 70),
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green.withOpacity(0.6)),
                        ),
                        Container(
                          width: (size.width - 50) *loanpercent / 100,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.withOpacity(0.9)),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "You are laible to pay "+sum.toString()+" out of "+sumttl.toString()+" loan taken.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff67727d).withOpacity(1.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),


                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      children: List.generate(data.length, (index) {
                        double loanpercent=double.parse(((data[index]['Liabilityamt']/data[index]['Liabilityttlamt'])*100).toStringAsFixed(2));
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.shade200,
                                spreadRadius: 5,
                                blurRadius: 1,
                                // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 25, right: 25, bottom: 25, top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data[index]['Liabilityname'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xff67727d)),
                                  ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.pink,
                              size: 30,
                            ), onPressed: () {
                            final TextEditingController Amount=TextEditingController();
                            final TextEditingController premium=TextEditingController();
                            final TextEditingController interest=TextEditingController();
                            final TextEditingController Extra=TextEditingController();
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                AlertDialog(
                                title: const Text("Loan Repayment Details"),

                            actions: <Widget>[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
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
                                                    controller:premium,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,// Removes the underline below the text
                                                      hintText: "Premium Amount",
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


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
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
                                                    controller:interest,
                                                    keyboardType: TextInputType.number,

                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,// Removes the underline below the text
                                                      hintText: "Interest Amount",
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


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
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
                                                    keyboardType: TextInputType.number,
                                                    controller: Extra,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,// Removes the underline below the text
                                                      hintText: "Extra Fees",
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
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Center(
                                    child: Container(

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
                                                      hintText: "Total Amount",
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                    ),
                                                    style:TextStyle(
                                                      fontSize: 20.0,
                                                      color:Colors.black,
                                                    ) ,

                                                    onChanged: (text){

                                                      if(interest.text.isEmpty ){
                                                              interest.text="0";
                                                      }
                                                      if(Extra.text.isEmpty ){
                                                        Extra.text="0";
                                                      }
                                                      if(premium.text.isNotEmpty){
                                                        Amount.text=(double.parse(premium.text)+double.parse(interest.text)+double.parse(Extra.text)).toString();
                                                      }
                                                    }

                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                     "Loan Repayment is an expense and can be seen in the expense section once confirmed. "
                                         "The premium will be deducted from the loan amount. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Color(0xff67727d).withOpacity(1.0)),
                                    ),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      style:
                                      ElevatedButton.styleFrom(
                                        primary: Colors.pink,
                                        // background
                                        onPrimary:
                                        Colors.deepPurple,
                                        // foreground
                                        fixedSize: Size(90, 30),
                                      ),
                                      onPressed: () {
                                        double liabilityamt=data[index]['Liabilityamt'].toDouble();
                                        print(liabilityamt.runtimeType);
                                        updatedata(data[index], liabilityamt, double.parse(premium.text));

                                        addExpense("Recurring Expense", "Loan Repayment", double.parse(Amount.text), " ", now);

                                        setState(() {

                                        });
                                      },
                                      child: Text(
                                        "Confirm ",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),

                                ],
                              ),



                                  ],),);
                          },
                          )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Loan Amount to Pay",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                                color: Color(0xff67727d)
                                                    .withOpacity(0.6),
                                            ),
                                          ),
                                          Text(
                                            data[index]['Liabilityamt'].toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3,left: 25.0),
                                        child: Text(
                                         loanpercent.toString()+"%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                         "Total Loan Amount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d)
                                                  .withOpacity(0.6)),
                                        ),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          data[index]['Liabilityttlamt'].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color:Color(0xff67727d)),
                                        ),

                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: (size.width - 70),
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:Colors.green),
                                  ),
                                  Container(
                                    width: (size.width - 50) *
                                       loanpercent/100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          "You have  " +
                                              loanpercent.toString() +
                                              "% left to pay of your loan amount ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xff67727d).withOpacity(1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),

          ),
        ],
      ),
    );
  }

  Future updatedata(Map<String, dynamic> deletedata, double Liabilityamt , double premium) async {
    print("here");
    var datato = deletedata.toString();
    Map dataadd = Map<String, dynamic>();
    final CollectionReference collectionref =
    FirebaseFirestore.instance.collection("Student");
    double amt=Liabilityamt-premium;

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
        print(dataadd);
      });
      var Key = dataadd.keys
          .firstWhere((k) => dataadd[k] == datato, orElse: () => null);



      await collectionref.doc(user.uid).collection("Liability").doc(Key).update({

        'Liabilityamt':amt,

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
}
