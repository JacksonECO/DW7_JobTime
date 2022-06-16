import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/module/project/detail/project_detail_module.dart';
import 'package:job_time/app/module/project/register/project_register_module.dart';
import 'package:job_time/app/module/project/task/project_task_module.dart';

class ProjectModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/register', module: ProjectRegisterModule()),
        ModuleRoute('/detail', module: ProjectDetailModule()),
        ModuleRoute('/task', module: ProjectTaskModule()),
      ];
}
