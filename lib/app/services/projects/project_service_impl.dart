import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/repositories/projects/project_repository.dart';
import 'package:job_time/app/services/projects/project_service.dart';
import 'package:job_time/app/view_models/project_model.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;
  ProjectServiceImpl({required ProjectRepository projectRepository}) : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectModel projectModel) {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..estimate = projectModel.estimate
      ..status = projectModel.status;

    return _projectRepository.registerRepository(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    return projects.map(ProjectModel.fromEntity).toList();
  }
}
