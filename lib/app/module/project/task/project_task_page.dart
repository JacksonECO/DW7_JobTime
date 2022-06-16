import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_time/app/core/ui/button_with_loader.dart';
import 'package:job_time/app/module/project/task/controller/project_task_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectTaskPage extends StatefulWidget {
  final ProjectTaskController controller;
  const ProjectTaskPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<ProjectTaskPage> createState() => _ProjectTaskPageState();
}

class _ProjectTaskPageState extends State<ProjectTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectTaskController, ProjectTaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == ProjectTaskStatus.success) {
          Navigator.pop(context);
        } else if (state == ProjectTaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar Task').show();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Criar nova Task'),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                controller: _nameEC,
                decoration: const InputDecoration(label: Text('Nome a task')),
                validator: Validatorless.required('Nome obrigatório'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _durationEC,
                decoration: const InputDecoration(label: Text('Duração da task')),
                validator: Validatorless.required('Duração obrigatória'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: ButtonWithLoader<ProjectTaskController, ProjectTaskStatus>(
                  block: widget.controller,
                  label: 'Salvar',
                  selectorStatusLoading: ProjectTaskStatus.loading,
                  onPressed: () {
                    final formValid = _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      final duration = int.tryParse(_durationEC.text);
                      if (duration == null) {
                        return AsukaSnackbar.alert('Duration inválido, deve ter um valor inteiro').show();
                      }
                      widget.controller.register(_nameEC.text, duration);
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
