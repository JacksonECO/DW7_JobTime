import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/core/exception/failure.dart';
import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/repositories/projects/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;
  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> registerRepository(Project project) async {
    final connection = await _database.openConnection();
    try {
      await connection.writeTxn((isar) => isar.projects.put(project));
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    try {
      final connection = await _database.openConnection();
      return await connection.projects.filter().statusEqualTo(status).findAll();
    } catch (e, s) {
      log('Erro ao buscar projetos pelo status: ${status.label}', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }
}
