import 'package:flutter/material.dart';
import 'package:job_time/app/core/ui/job_timer_icons_icons.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_pie_chart.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_task_tile.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProjectDetailApp(),
          SliverList(
            delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: ProjectDetailPieChart(),
              ),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
              const ProjectDetailTaskTile(),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(JobTimerIcons.ok_circled2),
                  label: const Text('Finalizar Projeto'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
