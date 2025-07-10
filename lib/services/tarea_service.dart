import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pry_gestion_tareas/models/Tarea.dart';

class TareaService{

  Future<void> guardarTarea(Tarea tarea) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado");

    final tareasRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('tareas');

    DocumentReference docRef = await tareasRef.add(tarea.toMap()..remove('docId'));
    await docRef.update({'docId': docRef.id});
  }
  Future<List<Tarea>> obtenerTareas() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas')
        .get();

    return snapshot.docs
        .map((doc) => Tarea.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<Tarea>> obtenerTareasPendientes() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas')
        .where('completada', isEqualTo: false)
        .get();

    return snapshot.docs
        .map((doc) => Tarea.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<Tarea>> obtenerTareasCompletadas() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas')
        .where('completada', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => Tarea.fromMap(doc.data(), doc.id))
        .toList();
  }
  Future<int> obtenerNumeroTareasCompletadas() async {
    final tareas = await obtenerTareas(); // Asume que este método ya existe y devuelve List<Tarea>
    final completadas = tareas.where((t) => t.completada).length;
    return completadas;
  }
  Future<int> obtenerNumeroTareasPendientes() async {
    final tareas = await obtenerTareas(); // Asume que este método ya existe y devuelve List<Tarea>
    final pendientes = tareas.where((t) => t.completada == false).length;
    return pendientes;
  }

  Future<List<Tarea>> obtenerTareasPorFecha(DateTime fecha) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final inicioDia = DateTime(fecha.year, fecha.month, fecha.day, 0, 0, 0);
    final finDia = DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59);

    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('tareas')
        .where('fechaLimite', isGreaterThanOrEqualTo: inicioDia.toIso8601String())
        .where('fechaLimite', isLessThanOrEqualTo: finDia.toIso8601String())
        .get();

    return snapshot.docs
        .map((doc) => Tarea.fromMap(doc.data(), doc.id))
        .toList();
  }
  // lib/services/tarea_service.dart
  Future<void> actualizarEstadoTarea(Tarea tarea, bool completada) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || tarea.docId == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('tareas')
        .doc(tarea.docId);

    await docRef.update({'completada': completada});
  }

  Future<void> eliminarTarea(Tarea tarea) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || tarea.docId == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('tareas')
        .doc(tarea.docId);

    await docRef.delete();
  }

}

extension on DocumentReference<Map<String, dynamic>> {
  where(String s, {required int isEqualTo}) {}
}