import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_gestion_tareas/views/login_view.dart';
import 'package:pry_gestion_tareas/views/pages/calendar_view.dart';
import 'package:pry_gestion_tareas/views/pages/configuration_view.dart';
import 'package:pry_gestion_tareas/views/pages/list_task_view.dart';
import 'package:pry_gestion_tareas/views/pages/estadistics_view.dart';
import 'package:pry_gestion_tareas/views/drawer_view.dart';
import 'package:pry_gestion_tareas/viewmodels/buttom_nav_viewmodel.dart';
import 'package:pry_gestion_tareas/viewmodels/drawer_viewmodel.dart';

class Homeview extends StatelessWidget {
  final List<Widget> pages = [
    CalendarView(),
    ListTaskView(),
    EstadisticsView(),
  ];

  @override
  Widget build(BuildContext context) {
    //instanciar Provider
    final vm = Provider.of<DrawerViewModel>(context, listen: false);
    final navVM = Provider.of<ButtomNavViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text(vm.selected),),
      drawer: DrawerView(),
      // body: Center(
      //   child: Text("Pantalla de ${vm.selected}",
      //   style: TextStyle(fontSize: 22),),
      // ),
      body: pages[navVM.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navVM.selectedIndex,
        onTap: navVM.changeIndex,
        selectedItemColor: Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Lista de Tareas'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadísticas'),
        ],
      ),
    );
  }
}