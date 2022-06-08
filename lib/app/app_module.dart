import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/module/home/home_module.dart';
import 'package:job_time/app/module/login/login_module.dart';
import 'package:job_time/app/module/splash/splash_page.dart';
import 'package:job_time/app/services/auth/auth_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AuthServiceImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => const SplashPage())),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
