import 'package:flutter/material.dart';
import 'package:pry_gestion_tareas/models/Tarea.dart';
import 'package:pry_gestion_tareas/services/tarea_service.dart';

class CrearTareaView extends StatefulWidget {
  const CrearTareaView({Key? key}) : super(key: key);

  @override
  State<CrearTareaView> createState() => _CrearTareaViewState();
}

class _CrearTareaViewState extends State<CrearTareaView> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime _fechaLimite = DateTime.now();

  final TareaService _tareaService = TareaService();

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFechaLimite(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaLimite,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fechaLimite) {
      setState(() {
        _fechaLimite = picked;
      });
    }
  }

  Future<void> _guardarTarea() async {
    if (_formKey.currentState!.validate()) {
      final nuevaTarea = Tarea(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        fechaCreacion: DateTime.now(),
        fechaLimite: DateTime(
          _fechaLimite.year,
          _fechaLimite.month,
          _fechaLimite.day,
          23,
          59
        ),
      );
      await _tareaService.guardarTarea(nuevaTarea);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarea guardada correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Tarea', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un título' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese una descripción' : null,
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Fecha límite: ${_fechaLimite.day}/${_fechaLimite.month}/${_fechaLimite.year}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _seleccionarFechaLimite(context),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarTarea,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}