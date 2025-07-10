import 'package:flutter/material.dart';

import '../../models/Tarea.dart';
import '../../services/tarea_service.dart';

class PendientsView extends StatefulWidget {
  const PendientsView({Key? key}) : super(key: key);

  @override
  State<PendientsView> createState() => _PendientsViewState();
}

class _PendientsViewState extends State<PendientsView> {

  @override
  Widget build(BuildContext context) {
    final TareaService service = TareaService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Pendientes', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<Tarea>>(
          future: service.obtenerTareasPendientes(),
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
                child: Text('No hay tareas Pendientes'),
              );
            }else{
              final tareas = snapshot.data!;
              return ListView.builder(
                itemCount: tareas.length,
                itemBuilder: (context, index) {
                  final tarea = tareas[index];
                  return ListTile(
                    leading: Icon(Icons.assignment_late_outlined),
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