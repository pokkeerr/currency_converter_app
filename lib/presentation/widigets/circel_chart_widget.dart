import 'package:currency_converter_app/data/models/convert_rates_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Package import import 'package:flutter/material.dart';

class CircelChartWidget extends StatefulWidget {
  const CircelChartWidget(this.converterRatesModel, {Key? key})
      : super(key: key);
  final ConverterRatesModel converterRatesModel;
  @override
  State<CircelChartWidget> createState() => _CircelChartWidgetState();
}

class _CircelChartWidgetState extends State<CircelChartWidget> {
  SelectionBehavior? selectionBehavior;
  ConverterRatesModel? converterRatesModel;
  late bool enableMultiSelect;
  late bool _toggleSelection;

  @override
  void initState() {
    enableMultiSelect = false;
    _toggleSelection = true;
    converterRatesModel = widget.converterRatesModel;
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final double screenWidth = MediaQuery.of(context).size.width;
  //   return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter stateSetter) {
  //     return ListView(
  //       shrinkWrap: true,
  //       children: <Widget>[
  //         Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text('Enable multi-selection',
  //                   softWrap: false,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: model.textColor,
  //                   )),
  //               Container(
  //                   padding: EdgeInsets.only(left: 0.01 * screenWidth),
  //                   width: 0.4 * screenWidth,
  //                   child: CheckboxListTile(
  //                       controlAffinity: ListTileControlAffinity.leading,
  //                       contentPadding: EdgeInsets.zero,
  //                       activeColor: model.backgroundColor,
  //                       value: enableMultiSelect,
  //                       onChanged: (bool? value) {
  //                         setState(() {
  //                           enableMultiSelect = value!;
  //                           stateSetter(() {});
  //                         });
  //                       }))
  //             ]),
  //         Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text('Toggle selection',
  //                   softWrap: false,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: model.textColor,
  //                   )),
  //               Container(
  //                   padding: EdgeInsets.only(left: 0.01 * screenWidth),
  //                   width: 0.4 * screenWidth,
  //                   child: CheckboxListTile(
  //                       controlAffinity: ListTileControlAffinity.leading,
  //                       contentPadding: EdgeInsets.zero,
  //                       activeColor: model.backgroundColor,
  //                       value: _toggleSelection,
  //                       onChanged: (bool? value) {
  //                         setState(() {
  //                           _toggleSelection = value!;
  //                           stateSetter(() {});
  //                         });
  //                       }))
  //             ]),
  //       ],
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    selectionBehavior =
        SelectionBehavior(enable: true, toggleSelection: _toggleSelection);
    return SfCircularChart(
        title: ChartTitle(text: "api.exchangerate-api.com Converter"),
        selectionGesture: ActivationMode.singleTap,
        enableMultiSelection: enableMultiSelect,
        series: getCircularSelectionSeries());
  }

  List<PieSeries<ChartSampleData, String>> getCircularSelectionSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            if (converterRatesModel != null)
              ...converterRatesModel!.rates.entries.map<ChartSampleData>((e) {
                return ChartSampleData(
                    x: e.key,
                    y: e.value,
                    secondSeriesYValue: e.value,
                    thirdSeriesYValue:
                        converterRatesModel!.rates.entries.length,
                    text: '${e.key}: ${e.value}');
              }).toList()
          ],
          radius: '100%',
          startAngle: 45,
          endAngle: 45,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          dataLabelMapper: (ChartSampleData sales, _) => sales.text,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.inside),

          /// To enable the selection settings and its functionalities.
          selectionBehavior: selectionBehavior)
    ];
  }
}

class ChartSampleData {
  final String x;
  final num y;
  final num secondSeriesYValue;
  final num thirdSeriesYValue;
  final String text;
  ChartSampleData({
    required this.x,
    required this.y,
    required this.secondSeriesYValue,
    required this.thirdSeriesYValue,
    required this.text,
  });
}
