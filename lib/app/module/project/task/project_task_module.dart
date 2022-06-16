import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/module/project/task/controller/project_task_controller.dart';
import 'package:job_time/app/module/project/task/project_task_page.dart';
import 'package:job_time/app/view_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectTaskModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectTaskController(projectService: i()), // AppModule
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          final ProjectModel projectModel = args.data;
          return ProjectTaskPage(
            controller: Modular.get()..setProject(projectModel),
          );
        }),
      ];
}
