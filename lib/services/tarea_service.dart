import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pry_gestion_tareas/models/Tarea.dart';

class TareaService{

  Future<void> guardarTarea(Tarea tarea) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final tareasRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas');

    await tareasRef.add(tarea.toMap());
  }
  Future<List<Tarea>> obtenerTareas() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas')
        .get();

    return snapshot.docs.map((doc) => Tarea.fromMap(doc.data())).toList();
  }

}