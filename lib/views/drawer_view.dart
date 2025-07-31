import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_gestion_tareas/viewmodels/drawer_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DrawerViewModel>(context);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.orange, Colors.red])
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.add, size: 50, color: Colors.white),
                      Text("Gestión de Tareas", style: TextStyle(fontSize: 22, color: Colors.white),),
                      Text("Universidad de las Fuerzas Armadas ESPE", style: TextStyle(fontSize: 10, color: Colors.white70),),
                    ],
                  ),
                ),
                ListTile(
                  selected: vm.selected == 'Home',
                  selectedTileColor: Colors.orange.shade200,
                  leading: Icon(Icons.home, color: Colors.orange),
                  title: Text('Home', style: TextStyle(color: Colors.orange)),
                  onTap: () {
                    vm.selct('Home');
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'Today',
                  selectedTileColor: Colors.orange.shade200,
                  leading: Icon(Icons.task_alt_rounded, color: Colors.red),
                  title: Text('Hoy', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    vm.selct('Today');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/today');
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'Pendients',
                  selectedTileColor: Colors.orange.shade200,
                  leading: Icon(Icons.assignment_late_outlined, color: Colors.orange),
                  title: Text('Pendientes', style: TextStyle(color: Colors.orange)),
                  onTap: () {
                    vm.selct('Pendients');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/pendients');
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'settings',
                  selectedTileColor: Colors.orange.shade200,
                  leading: Icon(Icons.settings, color: Colors.red),
                  title: Text('Configuración', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    vm.selct('settings');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
