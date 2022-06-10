import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';

abstract class ProjectRepository {
  Future<void> registerRepository(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
}
