import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/view_models/project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;

  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.status,
    required this.tasks,
  });

  factory ProjectModel.fromEntity(Project entity) {
    entity.tasks.loadSync();

    return ProjectModel(
      id: entity.id,
      name: entity.name,
      estimate: entity.estimate,
      status: entity.status,
      tasks: entity.tasks.map(ProjectTaskModel.fromEntity).toList(),
    );
  }
}
