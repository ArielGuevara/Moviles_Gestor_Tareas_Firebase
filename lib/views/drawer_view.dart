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
                      gradient: LinearGradient(colors: [Colors.blueAccent, Colors.lightBlue])
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.add, size: 50, color: Colors.white),
                      Text("Gestión de Tareas", style: TextStyle(fontSize: 22, color: Colors.white),),
                      Text("www.traveling.com", style: TextStyle(fontSize: 10, color: Colors.white70),),
                    ],
                  ),
                ),
                ListTile(
                  selected: vm.selected == 'Home',
                  selectedTileColor: Colors.blue.shade300,
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    vm.selct('Home');
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'Today',
                  selectedTileColor: Colors.blue.shade300,
                  leading: Icon(Icons.task_alt_rounded),
                  title: Text('Hoy'),
                  onTap: () {
                    vm.selct('Today');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/today');
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'Pendients',
                  selectedTileColor: Colors.blue.shade300,
                  leading: Icon(Icons.assignment_late_outlined),
                  title: Text('Pendientes'),
                  onTap: () {
                    vm.selct('Pendients');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/pendients');
                  },
                ),
                Divider(),
                ListTile(
                  selected: vm.selected == 'settings',
                  selectedTileColor: Colors.blue.shade300,
                  leading: Icon(Icons.settings),
                  title: Text('Configuración'),
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