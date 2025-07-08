import 'package:flutter/material.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo, reemplaza por tus tareas reales
    final tareas = [
      'Comprar víveres',
      'Estudiar para el examen',
      'Llamar al doctor',
      'Pagar servicios',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: ListView.separated(
        itemCount: tareas.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.task),
            title: Text(tareas[index]),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Acción al tocar la tarea (puedes personalizar)
            },
          );
        },
      ),
    );
  }
}