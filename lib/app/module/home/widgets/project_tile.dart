import 'package:flutter/material.dart';

import 'package:job_time/app/core/ui/job_timer_icons_icons.dart';
import 'package:job_time/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectTile({
    Key? key,
    required this.projectModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //? Não faz sentido, uma vez que foi usado um Expanded como filho, e ocupará todo o espaço disponível
      // constraints: const BoxConstraints(maxHeight: 90),
      height: 90,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 4,
        ),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          _ProjectName(projectModel: projectModel),
          Expanded(child: _ProjectProgress(projectModel: projectModel)),
        ],
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectName({
    required this.projectModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectProgress({
    Key? key,
    required this.projectModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks.fold<int>(0, (previousValue, element) => previousValue += element.duration);
    double percentTasks = 0;

    if (totalTasks > 0) {
      percentTasks = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Expanded(
          child: LinearProgressIndicator(
            value: percentTasks,
            color: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('${projectModel.estimate}h'),
        ),
      ]),
    );
  }
}
