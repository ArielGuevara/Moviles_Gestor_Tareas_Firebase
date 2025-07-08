import 'package:flutter/material.dart';

class EstadisticsView extends StatelessWidget {
  const EstadisticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final int tareasCompletadas = 8;
    final int tareasPendientes = 4;
    final int totalTareas = tareasCompletadas + tareasPendientes;
    final double progreso = totalTareas == 0 ? 0 : tareasCompletadas / totalTareas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Tareas Completadas'),
                trailing: Text('$tareasCompletadas'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.pending_actions, color: Colors.orange),
                title: Text('Tareas Pendientes'),
                trailing: Text('$tareasPendientes'),
              ),
            ),
            const SizedBox(height: 32),
            Text('Progreso general', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progreso,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text('${(progreso * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 22)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}