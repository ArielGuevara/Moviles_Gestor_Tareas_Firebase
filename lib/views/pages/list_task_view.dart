import 'package:flutter/material.dart';
import 'package:pry_gestion_tareas/services/tarea_service.dart';

import '../../models/Tarea.dart';
import 'package:pry_gestion_tareas/views/pages/crear_tarea_view.dart';

class ListTaskView extends StatefulWidget {
  const ListTaskView({Key? key}) : super(key: key);

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> {
  final TareaService service = TareaService();
  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo, reemplaza por tus tareas reales

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<Tarea>>(
          future: service.obtenerTareas(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (snapshot.hasError){
              return Center(
                child: Text('Error al cargar las tareas: ${snapshot.error}'),
              );
            }else if (!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(
                child: Text('No hay tareas disponibles'),
              );
            }else{
              final tareas = snapshot.data!;
              return ListView.builder(
                itemCount: tareas.length + 1,
                itemBuilder: (context, index) {
                  if (index == tareas.length) {
                    return SizedBox(height: 80); // Espacio para el FAB
                  }
                  final tarea = tareas[index];
                  return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(tarea.titulo),
                    subtitle: Text(tarea.descripcion),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirmar eliminación'),
                                content: Text('¿Estás seguro de que deseas eliminar esta tarea?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await service.eliminarTarea(tarea);
                              setState(() {}); // Refresca la lista
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Tarea eliminada correctamente')),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            tarea.completada ? Icons.check_circle : Icons.circle,
                            color: tarea.completada ? Colors.green : Colors.red,
                          ),
                          onPressed: () async {
                            setState(() {
                              tarea.completada = !tarea.completada;
                            });
                            await service.actualizarEstadoTarea(tarea, tarea.completada);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Acción al presionar la tarea (puedes personalizar)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tarea seleccionada: ${tarea.titulo}')),
                      );
                    },
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Acción al presionar el botón flotante (puedes personalizar)
          final result = await Navigator.pushNamed(context, '/crearTask');
          if (result == true){
            setState(() {});
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Añadir Tarea',
      ),
    );
  }
}
