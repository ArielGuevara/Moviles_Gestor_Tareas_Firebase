import 'package:flutter/material.dart';

class PendientsView extends StatelessWidget {
  const PendientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo, reemplaza por tus tareas reales
    final tareasPendientes = [
      'Terminar informe',
      'Llamar al cliente',
      'Actualizar documentación',
      'Preparar presentación',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Pendientes'),
      ),
      body: ListView.separated(
        itemCount: tareasPendientes.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.assignment_late_outlined),
            title: Text(tareasPendientes[index]),
          );
        },
      ),
    );
  }
}