// ignore_for_file: constant_identifier_names

enum ProjectStatus {
  em_andamento('Em andamento'),
  finalizado('Finalizado');

  final String label;
  const ProjectStatus(this.label);
}
