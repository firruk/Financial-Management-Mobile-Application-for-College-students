import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../services/database.dart';
class Expensetypepie extends StatefulWidget {
  const Expensetypepie({Key? key}) : super(key: key);

  @override
  _ExpensetypepieState createState() => _ExpensetypepieState();
}

class _ExpensetypepieState extends State<Expensetypepie> {
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
            double recurring=double.parse(((getsum("Recurring Expense")/ttl)*100).toStringAsFixed(0));
            double non_recurring=double.parse(((getsum("Non_Recurring Expense")/ttl)*100).toStringAsFixed(0));






            List<ChartData> chartData = <ChartData> [
              ChartData('Recurring Expense', recurring, recurring.toString()),
              ChartData('Non_Recurring Expense', non_recurring, non_recurring.toString()),






            ];





            return Scaffold(

                body: Center(
                    child: Container(
                        child: SfCircularChart(

                            palette:  <Color> [Colors.blue, Colors.pink, Colors.green, Colors.redAccent, Colors.blueAccent, Colors.teal],
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
  getsum(String Expensetype){
    double sumvalue = 0.0;


    for (var i = 0; i < dataList.length; i++) {
      if(dataList[i]["Expensetype"]==Expensetype){
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



