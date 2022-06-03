import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../services/database.dart';
class Simplepiechart extends StatefulWidget {
  const Simplepiechart({Key? key}) : super(key: key);

  @override
  _SimplepiechartState createState() => _SimplepiechartState();
}

class _SimplepiechartState extends State<Simplepiechart> {
  @override
  List<dynamic> data = [];


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
              if(data[i]["Incometype"]=="Non-Fixed Income"){

                non_fixed_sum=non_fixed_sum+data[i]["incomeamt"];
              }
              if(data[i]["Incometype"]=="Fixed Income"){
                fixed_income.add(data[i]["incomeamt"]);
                fixed_sum=fixed_sum+data[i]["incomeamt"];
              }

            }
            num ttl=fixed_sum+non_fixed_sum;
            double fixed_percent=double.parse(((fixed_sum/ttl)*100).toStringAsFixed(0));
            double non_fixed_percent=double.parse(((non_fixed_sum/ttl)*100).toStringAsFixed(0));



             List<ChartData> chartData = <ChartData> [
              ChartData('Fixed Income', fixed_percent, fixed_percent.toString()),
              ChartData('Non-Fixed Income', non_fixed_percent, non_fixed_percent.toString()),


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
                            dataLabelSettings:DataLabelSettings(isVisible : true),
                            name: 'Data',

                                  // Radius for each segment from data source
                                  pointRadiusMapper: (ChartData data, _) => data.size

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

}




  class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
  }
