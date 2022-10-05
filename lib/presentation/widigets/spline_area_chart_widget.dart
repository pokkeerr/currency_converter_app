import 'package:currency_converter_app/data/models/currencyconverter_model.dart';
import 'package:currency_converter_app/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineAreaChartWidget extends StatefulWidget {
  const SplineAreaChartWidget(this.currencyWeeklyconverterModel, {Key? key})
      : super(key: key);
  final CurrencyWeeklyconverterModel currencyWeeklyconverterModel;
  @override
  State<SplineAreaChartWidget> createState() => _SplineAreaChartWidgetState();
}

class _SplineAreaChartWidgetState extends State<SplineAreaChartWidget> {
  late CurrencyWeeklyconverterModel currencyWeeklyconverterModel;

  List<_SplineAreaData> _chartData() {
    List<DateTime> dates =
        currencyWeeklyconverterModel.res.entries.first.value.entries.map((e) {
      return DateTime.parse(e.key);
    }).toList();

    List<num> num1 = List.generate(dates.length, (i) {
      return currencyWeeklyconverterModel.res.entries.first.value.entries
          .elementAt(i)
          .value;
    }).toList();
    List<num> num2 = List.generate(dates.length, (i) {
      return currencyWeeklyconverterModel.res.entries.last.value.entries
          .elementAt(i)
          .value;
    }).toList();
    final list = List<_SplineAreaData>.generate(dates.length, (i) {
      return _SplineAreaData(dates[i], num1[i].toDouble(), num2[i].toDouble());
    });
    return list;
  }

  @override
  void initState() {
    currencyWeeklyconverterModel = widget.currencyWeeklyconverterModel;
    chartData = _chartData();
    // <_SplineAreaData>[
    // ...currencyWeeklyconverterModel.res.entries.map<_SplineAreaData>((e) {
    //   return _SplineAreaData(

    //   );
    // }).toList(),
    //   _SplineAreaData(2010, 10.53, 3.3),
    //   _SplineAreaData(2011, 9.5, 5.4),
    //   _SplineAreaData(2012, 10, 2.65),
    //   _SplineAreaData(2013, 9.4, 2.62),
    //   _SplineAreaData(2014, 5.8, 1.99),
    //   _SplineAreaData(2015, 4.9, 1.44),
    //   _SplineAreaData(2016, 4.5, 2),
    //   _SplineAreaData(2017, 3.6, 1.56),
    //   _SplineAreaData(2018, 3.43, 2.1),
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplineAreaChart();
  }

  /// Returns the cartesian spline are chart.
  SfCartesianChart _buildSplineAreaChart() {
    return SfCartesianChart(
      legend: Legend(
        isVisible: true,
        opacity: 0.7,
        alignment: ChartAlignment.near,
        // itemPadding: 2,
        backgroundColor: Colors.white,
        isResponsive: true,
        position: LegendPosition.top,
      ),
      // title:
      //     ChartTitle(text: currencyWeeklyconverterModel.res.entries.first.key),
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        axisLabelFormatter: (axisLabelRenderArgs) {
          final String text = DateTime.fromMillisecondsSinceEpoch(
                  axisLabelRenderArgs.value.toInt())
              .toString()
              .substring(5, 10);
          const TextStyle style = TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10);
          return ChartAxisLabel(text, style);
        },
      ),
      primaryYAxis: NumericAxis(
          axisLabelFormatter: (args) {
            return ChartAxisLabel('${args.value.toStringAsFixed(2)}%',
                const TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
          },
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getSplieAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<_SplineAreaData>? chartData;

  List<ChartSeries<_SplineAreaData, DateTime>> _getSplieAreaSeries() {
    return <ChartSeries<_SplineAreaData, DateTime>>[
      SplineAreaSeries<_SplineAreaData, DateTime>(
          dataSource: chartData!,
          color: const Color.fromRGBO(75, 135, 185, 0.6),
          borderColor: const Color.fromRGBO(75, 135, 185, 1),
          borderWidth: 2,
          name: currencyWeeklyconverterModel.res.entries.first.key
              .split('_')
              .first,
          xValueMapper: (_SplineAreaData sales, _) => sales.date,
          yValueMapper: (_SplineAreaData sales, _) => sales.y1),
      SplineAreaSeries<_SplineAreaData, DateTime>(
          dataSource: chartData!,
          borderColor: const Color.fromRGBO(192, 108, 132, 1),
          color: const Color.fromRGBO(192, 108, 132, 0.6),
          borderWidth: 2,
          name: currencyWeeklyconverterModel.res.entries.first.key
              .split('_')
              .last,
          xValueMapper: (_SplineAreaData sales, _) => sales.date,
          yValueMapper: (_SplineAreaData sales, _) => sales.y2)
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

/// Private class for storing the spline area chart datapoints.
class _SplineAreaData {
  _SplineAreaData(this.date, this.y1, this.y2);
  final DateTime date;
  final num y1;
  final num y2;
}
