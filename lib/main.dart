import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MaterialApp(
    home:  MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class Sales {
  String year;
  int sales;

  Sales(this.year,this.sales);
}

class _State extends State<MyApp> {

  late List<Sales> _laptops;
  late List<Sales> _desktops;
  late List<charts.Series<Sales, String>> _chartdata;


  void _makeData() {

    _laptops = [];
    _desktops = [];
    _chartdata = [];

    final rnd = Random();
    for(int i = 2016; i < 2021; i++) {
      _laptops.add(Sales(i.toString(), rnd.nextInt(1000)));
      _desktops.add(Sales(i.toString(), rnd.nextInt(1000)));
    }

    _chartdata.add(charts.Series(
        id: 'Sales',
        data: _laptops,
        domainFn: (Sales sales,__) => sales.year,
        measureFn: (Sales sales,__) => sales.sales,
        displayName: 'Sales',
        colorFn: (_,__) => charts.MaterialPalette.green.shadeDefault,
    ));

    _chartdata.add(charts.Series(
      id: 'Sales',
      data: _desktops,
      domainFn: (Sales sales,__) => sales.year,
      measureFn: (Sales sales,__) => sales.sales,
      displayName: 'Sales',
      colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault,
    ));

  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text('Name here'),
      ),
      body:  Container(
        padding: const EdgeInsets.all(32.0),
        child:  Center(
          child:  Column(
            children: <Widget>[
               const Text('Add Widgets Here'),
              Expanded(child:  charts.BarChart(
              _chartdata,
                vertical: true,
            ))
            ],
          ),
        )
      ),
    );
  }
}