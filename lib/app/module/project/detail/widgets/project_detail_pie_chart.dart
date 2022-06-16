import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectDetailPieChart extends StatelessWidget {
  final int projectEstimate;
  final int totalTask;

  const ProjectDetailPieChart({
    Key? key,
    required this.projectEstimate,
    required this.totalTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final residual = projectEstimate - totalTask;
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.loose, //? faz com que ela ocupe o mínimo possível de tamanho
        children: [
          PieChart(PieChartData(sections: [
            PieChartSectionData(
              value: totalTask.toDouble(),
              color: theme.primaryColor,
              title: '${totalTask}h',
              showTitle: true,
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              value: residual.toDouble(),
              color: theme.primaryColorLight,
              title: '${residual}h',
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
              '${projectEstimate}h',
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
