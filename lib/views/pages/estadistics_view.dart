import 'package:flutter/material.dart';
import 'package:pry_gestion_tareas/services/tarea_service.dart';

class EstadisticsView extends StatefulWidget {
  const EstadisticsView({Key? key}) : super(key: key);

  @override
  State<EstadisticsView> createState() => _EstadisticsViewState();
}

class _EstadisticsViewState extends State<EstadisticsView>{
  int _tareasCompletadas = 0;
  int _tareasPendientes = 0;

  @override
  void initState() {
    super.initState();
    _cargarCantidadTareasCompletas();
    _cargarCantidadTareasPendientes();
  }

  Future<void> _cargarCantidadTareasCompletas() async {
    final cantidad = await TareaService().obtenerNumeroTareasCompletadas();
    setState(() {
      _tareasCompletadas = cantidad;
    });
  }

  Future<void> _cargarCantidadTareasPendientes() async {
    final cantidadP = await TareaService().obtenerNumeroTareasPendientes();
    setState(() {
      _tareasPendientes = cantidadP;
    });
  }

@override
  Widget build(BuildContext context) {

    final TareaService tareaService = TareaService();
    final int tareasCompletadas = _tareasCompletadas;
    final int tareasPendientes = _tareasPendientes;
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