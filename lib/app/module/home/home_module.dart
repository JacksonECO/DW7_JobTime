import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/module/home/controller/home_controller.dart';
import 'package:job_time/app/module/home/home_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton((i) => HomeController(projectService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage(controller: Modular.get()..loadProjects())),
      ];
}
