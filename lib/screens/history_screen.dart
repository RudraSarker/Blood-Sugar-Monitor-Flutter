import 'dart:ffi';

import 'package:blood_sugar_monitor/db/blood_sugar_database.dart';
import 'package:blood_sugar_monitor/models/blood_sugar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatefulWidget {
  static String route = "history_screen";
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  //late List<BloodSugarData> _chartData;
  late TooltipBehavior _toolTipBehavior;

  late List<BloodSugar> _blsCollections = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshHistory();
    //_chartData = getBloodSugarData();
    //_toolTipBehavior = TooltipBehavior(enable: true);
  }

  Future refreshHistory() async {
    setState(() {
      isLoading = true;
      _toolTipBehavior = TooltipBehavior(enable: true);
    });

    _blsCollections = await BloodSugarDatabase.instance.readAllBloodsugar();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _blsCollections.isEmpty
              ? const Center(
                  child: Text("No History of Bloodsugar record!"),
                )
              : SfCircularChart(
                  tooltipBehavior: _toolTipBehavior,
                  title: ChartTitle(text: "Blood Sugar History"),
                  legend: Legend(
                      position: LegendPosition.top,
                      isVisible: true,
                      isResponsive: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  series: <CircularSeries>[
                    DoughnutSeries<BloodSugar, String>(
                      /*BloodSugarData */
                      dataSource: _blsCollections, //_chartData,
                      xValueMapper: (BloodSugar data, _) => data.date,
                      yValueMapper: (BloodSugar data, _) => data.afterFood,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      //maximumValue: 12.0,
                    ),
                  ],
                ),
    ));
  }

  // List<BloodSugarData> getBloodSugarData() {
  //   final List<BloodSugarData> bloodSugarDataCollection = [];
  //   return bloodSugarDataCollection;
  // }
}

// class BloodSugarData {
//   BloodSugarData(this.blshistory, this.blslevel);
//   final String blshistory;
//   final double blslevel;
// }
