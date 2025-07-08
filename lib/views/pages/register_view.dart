import 'package:flutter/material.dart';
import 'package:pry_gestion_tareas/services/login_service.dart';
import 'package:pry_gestion_tareas/views/login_view.dart';
import 'package:pry_gestion_tareas/services/register_service.dart';


class RegisterView extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _claveController = TextEditingController();
  final _confirmClaveController = TextEditingController();

  final controller = RegisterService();

  @override
  void dispose() {
    _emailController.dispose();
    _claveController.dispose();
    _confirmClaveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: controller.validarEmail, // Cambiado a LoginService
              ),
              TextFormField(
                controller: _claveController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: controller.validarClave,
              ),
              TextFormField(
                controller: _confirmClaveController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
                validator: (value) {
                  if (value != _claveController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String mensajeValidator = await controller.register(
                      _emailController,
                      _claveController,
                      context
                    );
                    //Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(mensajeValidator,
                        selectionColor: Colors.white,)),
                    );
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}