import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/core/ui/job_timer_icons_icons.dart';
import 'package:job_time/app/entities/project_status.dart';
import 'package:job_time/app/module/project/detail/controller/project_detail_controller.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_appbar.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_pie_chart.dart';
import 'package:job_time/app/module/project/detail/widgets/project_detail_tile.dart';
import 'package:job_time/app/view_models/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert('Erro interno').show();
          }
        },
        builder: (context, state) {
          final projectModel = state.projectModel;
          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando Projeto'),
              );
            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);
            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                return _buildProjectDetail(context, projectModel);
              }
              return const Center(
                child: Text('Erro ao carregar o projeto'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    final totalTask = projectModel.tasks.fold<int>(0, (totalValue, task) => totalValue += task.duration);
    return CustomScrollView(
      slivers: [
        ProjectDetailApp(
          projectModel: projectModel,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: ProjectDetailPieChart(
                projectEstimate: projectModel.estimate,
                totalTask: totalTask,
              ),
            ),
            ...projectModel.tasks.map((task) => ProjectDetailTile(task)).toList(),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: projectModel.status != ProjectStatus.finalizado,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.finishProject();
                  },
                  icon: const Icon(JobTimerIcons.ok_circled2),
                  label: const Text('Finalizar Projeto'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
