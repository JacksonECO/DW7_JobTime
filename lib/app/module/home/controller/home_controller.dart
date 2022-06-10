import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/services/projects/project_service.dart';
import 'package:job_time/app/view_models/project_model.dart';

part 'home_status.dart';

class HomeController extends Cubit<HomeState> {
  ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(projects: projects, status: HomeStatus.complete));
    } catch (e, s) {
      log('Erro ao buscar projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
