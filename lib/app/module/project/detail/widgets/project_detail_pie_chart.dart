import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectDetailPieChart extends StatelessWidget {
  const ProjectDetailPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.loose, //? faz com que ela ocupe o mínimo possível de tamanho
        children: [
          PieChart(PieChartData(sections: [
            PieChartSectionData(
              value: 50,
              color: theme.primaryColor,
              title: '50h',
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              value: 100,
              color: theme.primaryColorLight,
              title: '100h',
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
          Align(
            alignment: Alignment.center,
            child: Text(
              '200h',
              style: TextStyle(
                fontSize: 25,
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
