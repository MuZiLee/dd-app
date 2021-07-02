
import 'package:one/Model/FactoryInfo.dart';
import 'package:one/Model/HRFactoryInfoModel.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/Views/syncfusion_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmploymentViewController extends StatefulWidget {
  final HRFactoryInfoModel factoryInfo;
  EmploymentViewController({this.factoryInfo});

  @override
  _EmploymentViewControllerState createState() =>
      _EmploymentViewControllerState();
}

class _EmploymentViewControllerState extends State<EmploymentViewController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "工厂招聘情况",
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
        child: Container(child: getDefaultPieChart(widget.factoryInfo)),
      ),
    );
  }
}

SfCircularChart getDefaultPieChart(HRFactoryInfoModel factoryInfo) {
  return SfCircularChart(
    title: ChartTitle(text: factoryInfo.baseicInfo.factory_name),
    legend: Legend(isVisible: true),
    series: getPieSeries(factoryInfo),
  );
}

List<PieSeries<_PieData, String>> getPieSeries(HRFactoryInfoModel factoryInfo) {
  final List<_PieData> pieData = <_PieData>[
    _PieData('计划招聘人数', factoryInfo.information.expected_demand,
        '计划招聘人数 \n ${factoryInfo.information.expected_demand}人'),
    _PieData('入职', (factoryInfo.injobCount), '入职 \n ${factoryInfo.injobCount}人'),
    _PieData('缺少', factoryInfo.information.expected_demand - factoryInfo.injobCount,
        '缺少 \n ${factoryInfo.information.expected_demand - factoryInfo.injobCount}人'),
    _PieData('离职', factoryInfo.quitCount, '离职 \n ${factoryInfo.quitCount}人'),
  ];
  return <PieSeries<_PieData, String>>[
    PieSeries<_PieData, String>(
        explode: true,
        explodeIndex: 20,
        explodeOffset: '25%',
        dataSource: pieData,
        strokeColor: Colors.white,
        xValueMapper: (_PieData data, _) => data.xData,
        yValueMapper: (_PieData data, _) => data.yData,
        dataLabelMapper: (_PieData data, _) => data.text,
        startAngle: 50,
        endAngle: 50,
        dataLabelSettings: DataLabelSettings(isVisible: true)),
  ];
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;
  final String text;
}

class JobTotalObject {
  int num_in;
  int num_lack;
  int num_out;
  String num_plan;

  JobTotalObject({this.num_in, this.num_lack, this.num_out, this.num_plan});

  factory JobTotalObject.fromJson(Map<String, dynamic> json) {
    return JobTotalObject(
      num_in: json['num_in'],
      num_lack: json['num_lack'],
      num_out: json['num_out'],
      num_plan: json['num_plan'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_in'] = this.num_in;
    data['num_lack'] = this.num_lack;
    data['num_out'] = this.num_out;
    data['num_plan'] = this.num_plan;
    return data;
  }
}
