import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/module/home/widgets/header_projects_menu.dart';
import 'package:job_time/app/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                  child: const Center(child: Text('FIM')),
                ),
                Container(
                  color: Colors.blue,
                  height: 200,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
