import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class price extends StatefulWidget {
  const price({super.key});

  @override
  State<price> createState() => _priceState();
}

class _priceState extends State<price> {
  List stockItems = [];
  List<double>analysisSummary = [
    12,
    23.4,
    34.4,
    54.4,
    75.4,
    83.55,
    92.66,
    1.2,
    // 23.3,
    // 23.3,
    // 22.3,
    // 54.5,
    // 58,7

  ];

  @override
  Widget build(BuildContext context) {
  // BarChart(BarChartData(
  //     alignment: BarChartAlignment.center,
  //     maxY: 100,
  //     minY: 0,
  //     barGroups: stockItems.map((data)=> 
  //     BarChartGroupData(
  //     x: data.x,
  //     barRods: 
  //     [BarChartRodData(
  //       toY: data.y,
  //       color: Colors.grey[800],
  //       width: 12
  //     ),],),

  //   ),
  //   swapAnimationDuration: Duration(milliseconds: 150), // Optional
  // swapAnimationCurve: Curves.linear,
  //)

   return Scaffold(
    // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Analysis',style: TextStyle(color: Colors.black),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
      body: 
          Center(
            // child: SizedBox(
            //   height: 400,
            //   width: 400,
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                  child: BarChart(
                    
                    
                    BarChartData(
                      
                      
                       alignment: BarChartAlignment.center,
                       maxY: 100,
                       minY: 0,
                       gridData: FlGridData(show: false,),
                       titlesData: FlTitlesData(
                        
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                       
                      barGroups:[
                        
                        for (int i=0;i<analysisSummary.length;i++)...[
                          BarChartGroupData(
                          x: i,
                        
                        
                          barRods: [
                           // for(double j=0;j<1;j++)...[
                                BarChartRodData(
                             toY : analysisSummary[i],
                              // double.parse(i.toString()),
                          color: Colors.grey[800],
                          width: 12
                          ),
                        ],
                        ),
                        ],
                      ],
                      ),
                      ),
                ),
      );
  }
}