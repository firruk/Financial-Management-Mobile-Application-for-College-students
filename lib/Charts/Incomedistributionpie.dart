import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../services/database.dart';
class Incomedistributionpie extends StatefulWidget {
  const Incomedistributionpie({Key? key}) : super(key: key);

  @override
  _IncomedistributionpieState createState() => _IncomedistributionpieState();
}

class _IncomedistributionpieState extends State<Incomedistributionpie> {
  @override
  List<dynamic> data = [];
  List<dynamic> dataList = [];


  int activeDay = DateTime.now().month-1 ;
  double sum = 0.0;

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


            List<dynamic> fixed_income = [];
            List<dynamic> Non_fixed_income = [];
            num fixed_sum=0;
            num non_fixed_sum=0;


            for (var i=0; i<data.length; i++){

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






            }


            double ttl=sum;
            double Salary=double.parse(((getsum("Salary")/ttl)*100).toStringAsFixed(0));
            double Scholarship=double.parse(((getsum("Scholarship grants")/ttl)*100).toStringAsFixed(0));
            double Allowance=double.parse(((getsum('Monthly Allowance')/ttl)*100).toStringAsFixed(0));
            double Occassional=double.parse(((getsum('Occassional Earnings')/ttl)*100).toStringAsFixed(0));
            double Research=double.parse(((getsum("Research Grants")/ttl)*100).toStringAsFixed(0));
            double Parttime=double.parse(((getsum('Part-Time',)/ttl)*100).toStringAsFixed(0));
            double Others=double.parse(((getsum('Others',)/ttl)*100).toStringAsFixed(0));








            List<ChartData> chartData = <ChartData> [
              ChartData('Salary', Salary, Salary.toString()),
              ChartData( 'Scholarship grants', Scholarship, Scholarship.toString()),
              ChartData('Monthly Allowance', Allowance, Allowance.toString()),
              ChartData('Occassional Earnings', Occassional, Occassional.toString()),
              ChartData('Research Grants', Research, Research.toString()),
              ChartData('Part-Time', Parttime, Parttime.toString()),
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
  getsum(String Incomename){
    double sumvalue = 0.0;


    for (var i = 0; i < dataList.length; i++) {
      if(dataList[i]["Incomename"]==Incomename){
        sumvalue+=(dataList[i]["incomeamt"]).toDouble();
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



