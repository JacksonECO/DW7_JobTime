import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_time/app/services/projects/project_service.dart';
import 'package:job_time/app/view_models/project_model.dart';
import 'package:job_time/app/view_models/project_task_model.dart';

part 'project_task_state.dart';

class ProjectTaskController extends Cubit<ProjectTaskStatus> {
  late final ProjectModel _projectModel;
  final ProjectService _projectService;

  ProjectTaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectTaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(ProjectTaskStatus.loading);
      final task = ProjectTaskModel(name: name, duration: duration);
      await _projectService.addTask(_projectModel.id!, task);
      emit(ProjectTaskStatus.success);
    } catch (e, s) {
      log('Erro ao salvar task', error: e, stackTrace: s);
      emit(ProjectTaskStatus.failure);
    }
  }
}
