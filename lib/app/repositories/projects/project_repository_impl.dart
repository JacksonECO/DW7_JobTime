import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/core/exception/failure.dart';
import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/entities/project_task.dart';
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
      const messageError = 'Erro ao cadastrar projeto';
      log(messageError, error: e, stackTrace: s);
      throw Failure(message: messageError);
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    try {
      final connection = await _database.openConnection();
      return await connection.projects.filter().statusEqualTo(status).findAll();
    } catch (e, s) {
      final messageError = 'Erro ao buscar projetos pelo status: ${status.label}';
      log(messageError, error: e, stackTrace: s);
      throw Failure(message: messageError);
    }
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    try {
      final project = await findById(projectId);
      project.tasks.add(task);

      await connection.writeTxn((isar) => project.tasks.save());

      return project;
    } on IsarError catch (e, s) {
      const messageError = 'Erro ao add task';
      log(messageError, error: e, stackTrace: s);
      throw Failure(message: messageError);
    }
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    try {
      final project = await connection.projects.get(projectId);
      if (project == null) {
        throw Failure(message: 'Projeto não encontrado');
      }
      return project;
    } on IsarError catch (e, s) {
      final messageError = 'Erro ao procurar a task: $projectId';
      log(messageError, error: e, stackTrace: s);
      throw Failure(message: messageError);
    }
  }

  @override
  Future<void> finish(int projectId) async {
    final connection = await _database.openConnection();
    try {
      final project = await connection.projects.get(projectId);
      if (project == null) {
        throw Failure(message: 'Projeto não encontrado');
      }
      project.status = ProjectStatus.finalizado;
      await connection.writeTxn((isar) => isar.projects.put(project, saveLinks: true));
    } on IsarError catch (e, s) {
      final messageError = 'Erro ao finalizar o projeto: $projectId';
      log(messageError, error: e, stackTrace: s);
      throw Failure(message: messageError);
    }
  }
}
