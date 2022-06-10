import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/core/database/database_impl.dart';
import 'package:job_time/app/module/home/home_module.dart';
import 'package:job_time/app/module/login/login_module.dart';
import 'package:job_time/app/module/project/project_module.dart';
import 'package:job_time/app/module/splash/splash_page.dart';
import 'package:job_time/app/repositories/projects/project_repository_impl.dart';
import 'package:job_time/app/services/auth/auth_service_impl.dart';
import 'package:job_time/app/services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AuthServiceImpl()),
        Bind.lazySingleton((i) => DatabaseImpl()),
        Bind.lazySingleton((i) => ProjectRepositoryImpl(database: i())),
        Bind.lazySingleton((i) => ProjectServiceImpl(projectRepository: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => const SplashPage())),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/project', module: ProjectModule()),
      ];
}
