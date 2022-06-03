import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../services/database.dart';
class Expensenamepie extends StatefulWidget {
  const Expensenamepie({Key? key}) : super(key: key);

  @override
  _ExpensenamepieState createState() => _ExpensenamepieState();
}

class _ExpensenamepieState extends State<Expensenamepie> {
  @override
  List<dynamic> data = [];
  List<dynamic> dataList = [];


  int activeDay = DateTime.now().month-1 ;
  double sum = 0.0;

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.10),
      body: FutureBuilder(
        future: FireStoreDataBase().getExpenseData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            data = snapshot.data as List;



            data.sort((a, b) => a["Expensedate"].compareTo(b["Expensedate"]));


            List<dynamic> fixed_income = [];
            List<dynamic> Non_fixed_income = [];
            num fixed_sum=0;
            num non_fixed_sum=0;


            for (var i=0; i<data.length; i++){

              for (var i = 0; i < data.length; i++) {
                DateTime date = (data[i]["Expensedate"] as Timestamp).toDate();
                data[i]["Expense"] = date;
              }

              sum = 0.0;
              dataList = [];
              for (var i = 0; i < data.length; i++) {

                if (data[i]["Expense"].month == activeDay+1 ) {
                  dataList.add(data[i]);
                  sum += data[i]["Expenseamt"];

                }
              }






            }


            double ttl=sum;
            double Fees=double.parse(((getsum("Tuition & fees")/ttl)*100).toStringAsFixed(0));
            double rent=double.parse(((getsum("Rentals")/ttl)*100).toStringAsFixed(0));
            double Books=double.parse(((getsum('Books & Supplies')/ttl)*100).toStringAsFixed(0));
            double Subs=double.parse(((getsum('Subscriptions')/ttl)*100).toStringAsFixed(0));
            double Transport=double.parse(((getsum("Transportation")/ttl)*100).toStringAsFixed(0));
            double Grocery=double.parse(((getsum('Grocery')/ttl)*100).toStringAsFixed(0));
            double Water=double.parse(((getsum('Water Bill')/ttl)*100).toStringAsFixed(0));
            double Electricity=double.parse(((getsum('Electricity Bill')/ttl)*100).toStringAsFixed(0));
            double Phone=double.parse(((getsum("Phone Bill")/ttl)*100).toStringAsFixed(0));
            double Dining=double.parse(((getsum("Dining & Outing")/ttl)*100).toStringAsFixed(0));
            double Personal=double.parse(((getsum("Personal Expenses")/ttl)*100).toStringAsFixed(0));
            double Credit=double.parse(((getsum("Credit Card repayment")/ttl)*100).toStringAsFixed(0));
            double Loan=double.parse(((getsum("Loan Repayment")/ttl)*100).toStringAsFixed(0));
            double Others=double.parse(((getsum('Others')/ttl)*100).toStringAsFixed(0));








            List<ChartData> chartData = <ChartData> [
              ChartData('Transportation', Transport, Transport.toString()),
              ChartData( 'Tuition & fees', Fees, Fees.toString()),
              ChartData('Rentals', rent, rent.toString()),
              ChartData('Books & Supplies', Books, Books.toString()),
              ChartData('Grocery', Grocery, Grocery.toString()),
              ChartData('Subscriptions', Subs, Subs.toString()),


              ChartData('Water Bill', Water, Water.toString()),
              ChartData('Electricity Bill', Electricity, Electricity.toString()),
              ChartData('Phone Bill', Phone, Phone.toString()),
              ChartData('Dining & Outing', Dining, Dining.toString()),
              ChartData('Personal Expenses', Personal, Personal.toString()),
              ChartData('Credit Card repayment', Credit, Credit.toString()),
              ChartData('Loan Repaymente', Loan, Loan.toString()),
                ChartData('Others', Others, Others.toString()),






            ];





            return Scaffold(

                body: Center(
                    child: Container(
                        child: SfCircularChart(


                            legend: Legend(isVisible: true),
                            series: <CircularSeries>[
                              PieSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,

                                  name: 'Data',
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              showZeroValue : false,

                              // Avoid labels intersection
                              labelIntersectAction: LabelIntersectAction.shift,
                              labelPosition: ChartDataLabelPosition.outside,
                              connectorLineSettings: ConnectorLineSettings(
                                  type: ConnectorType.curve, length: '10%')
                          ),

                                  // Radius for each segment from data source

                                  // Radius of pie

                                  radius: '60%'
                              )
                            ]
                        )
                    )
                )
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  getsum(String Expensename){
    double sumvalue = 0.0;


    for (var i = 0; i < dataList.length; i++) {
      if(dataList[i]["Expensename"]==Expensename){
        sumvalue+=(dataList[i]["Expenseamt"]).toDouble();
      }
    }

    return sumvalue;
  }

}




class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}



