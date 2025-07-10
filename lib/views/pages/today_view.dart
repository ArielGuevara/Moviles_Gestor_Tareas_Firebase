import 'package:flutter/material.dart';

import '../../models/Tarea.dart';
import '../../services/tarea_service.dart';

class TodayView extends StatefulWidget {
  const TodayView({Key? key}) : super(key: key);

  @override
  State<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  @override
  Widget build(BuildContext context) {
    final TareaService service = TareaService();
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas de Hoy', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<Tarea>>(
          future: service.obtenerTareasPorFecha(today),
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
                child: Text('No hay tareas para hoy'),
              );
            }else{
              final tareas = snapshot.data!;
              return ListView.builder(
                itemCount: tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareas[index];
                  return ListTile(
                      leading: Icon(Icons.check_circle_outline),
                      title: Text(tarea.titulo),
                      subtitle: Text(tarea.descripcion),
                      trailing: IconButton(
                        icon: Icon(
                          tarea.completada ? Icons.check_circle : Icons.circle,
                          color: tarea.completada ? Colors.green : Colors.red,
                        ),
                        onPressed: () async{
                          setState((){
                            tarea.completada = !(tarea.completada);
                          });
                          await service.actualizarEstadoTarea(tarea, tarea.completada);
                          setState(() {});
                        },
                      )
                  );
                },
              );
            }
          }),
    );
  }
}