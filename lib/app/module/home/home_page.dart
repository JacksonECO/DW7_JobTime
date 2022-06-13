import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:job_time/app/module/home/controller/home_controller.dart';
import 'package:job_time/app/module/home/widgets/header_projects_menu.dart';
import 'package:job_time/app/module/home/widgets/project_tile.dart';
import 'package:job_time/app/services/auth/auth_service.dart';
import 'package:job_time/app/view_models/project_model.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? Limpar banco de dados
    // final Database d = Modular.get<Database>();
    // d.openConnection().then((connection) {
    //   Future.delayed(Duration(seconds: 5), () async {
    //     await connection.writeTxn((isar) => isar.clear());
    //   });
    // });
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao carregar projetos').show();
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: ListTile(title: const Text('Sair'), onTap: () => Modular.get<AuthService>().signOut()),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectsMenu(),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                bloc: controller,
                selector: (state) => state.status == HomeStatus.loading,
                builder: (context, showLoading) {
                  return SliverVisibility(
                    visible: showLoading,
                    sliver: const SliverToBoxAdapter(
                      child: SizedBox(height: 50, child: Center(child: CircularProgressIndicator())),
                    ),
                  );
                },
              ),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: controller,
                selector: (state) => state.projects,
                builder: (context, projects) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      projects.map((project) {
                        return ProjectTile(projectModel: project);
                        // return ListTile(
                        //   title: Text(project.name),
                        //   subtitle: Text('${project.estimate}h'),
                        // );
                      }).toList(),
                    ),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildListDelegate([]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
