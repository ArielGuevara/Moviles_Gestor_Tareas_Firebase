import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_gestion_tareas/viewmodels/drawer_viewmodel.dart';
import 'package:pry_gestion_tareas/viewmodels/buttom_nav_viewmodel.dart';
import 'package:pry_gestion_tareas/views/home_view.dart';
import 'package:pry_gestion_tareas/views/login_view.dart';
import 'package:pry_gestion_tareas/views/pages/configuration_view.dart';
import 'package:pry_gestion_tareas/views/pages/pendients_view.dart';
import 'package:pry_gestion_tareas/views/pages/register_view.dart';
import 'package:pry_gestion_tareas/views/pages/today_view.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerViewModel()),
        ChangeNotifierProvider(create: (_) => ButtomNavViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Tareas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white24,
            elevation: 2,
          ),
        ),
        home: LoginView(),
        routes: {
          '/home': (context) => Homeview(),
          'register': (context) => RegisterView(), // Puedes cambiar esto por la vista de registro que desees
          '/today': (context) => TodayView(),
          '/pendients': (context) => PendientsView(),
          '/settings': (context) => ConfigurationView(), // Puedes cambiar esto por la vista de configuración que desees
        },
      ),
    ),
  );
}