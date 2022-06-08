import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/core/database/database.dart';
import 'package:job_time/app/entities/project.dart';
import 'package:job_time/app/entities/project_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                final db = Modular.get<Database>();
                final connection = await db.openConnection();
                connection.writeTxn((isar) {
                  var project = Project();
                  project.name = 'Teste';
                  project.status = ProjectStatus.finalizado;

                  return connection.projects.put(project);
                });
              },
              child: const Text('Cadastrar')),
        ],
      ),
    );
  }
}
