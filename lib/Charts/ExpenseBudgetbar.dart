import 'package:budget/Json/budget_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../services/database.dart';
class ExpenseBudgetbar extends StatefulWidget {
  const ExpenseBudgetbar({Key? key}) : super(key: key);

  @override
  _ExpenseBudgetbarState createState() => _ExpenseBudgetbarState();
}

class _ExpenseBudgetbarState extends State<ExpenseBudgetbar> {
  @override
  List<dynamic> data = [];
  List<dynamic> Budgetlist = [];
  List<dynamic> dataList = [];
  double expensebudget=0.0;


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

          getBudget().then((value) => Budgetlist = value);
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

            expensebudget=Budgetlist[0]["Expensebudget"];


            double ttlExpense=sum;
            double Expensebudget=expensebudget;






           final List<ChartData> chartData = <ChartData> [
              ChartData("Total Expense", ttlExpense,Colors.green ),
              ChartData("Expense Budget", Expensebudget,Colors.blue)

            ];





            return Scaffold(
                body: Center(
                    child: Container(
                        child: SfCartesianChart(
                            primaryYAxis: NumericAxis(
                                minimum: 0,
                              interval: 100,

                            ),
                            primaryXAxis: CategoryAxis(),
                            series: <CartesianSeries>[
                              ColumnSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                            dataLabelMapper: (ChartData data, _) => data.x,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true
                            ),
                                  // Map color for each data points from the data source
                                  pointColorMapper: (ChartData data, _) => data.color

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
  ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}



