import 'package:flutter/material.dart';

class TodayView extends StatelessWidget {
  const TodayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo, reemplaza por tus tareas reales
    final tareasHoy = [
      'Revisar correos',
      'Reunión con el equipo',
      'Desarrollar nueva funcionalidad',
      'Enviar reporte diario',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas de Hoy'),
      ),
      body: ListView.separated(
        itemCount: tareasHoy.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text(tareasHoy[index]),
          );
        },
      ),
    );
  }
}