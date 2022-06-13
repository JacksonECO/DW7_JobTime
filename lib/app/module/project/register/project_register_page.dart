import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_time/app/core/ui/button_with_loader.dart';
import 'package:job_time/app/module/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimativaEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimativaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.initial:
          case ProjectRegisterStatus.loading:
            break;
          case ProjectRegisterStatus.success:
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar projeto').show();
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Criar novo projeto'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text('Nome do projeto')),
                  controller: _nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Estimativas de horas')),
                  controller: _estimativaEC,
                  validator: Validatorless.required('Estimativa obrigatória'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ButtonWithLoader<ProjectRegisterController, ProjectRegisterStatus>(
                    block: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () async {
                      final formValid = _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final name = _nameEC.text;
                        final estimativa = int.parse(_estimativaEC.text);

                        await widget.controller.register(name, estimativa);
                      }
                    },
                    label: 'Salvar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
