import 'package:flutter/material.dart';

class Tarea {
  final String titulo;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime fechaLimite;
  bool completada;

  Tarea({
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.fechaLimite,
    this.completada = false,
  });

  void marcarComoCompletada() {
    completada = true;
  }

  void marcarComoPendiente() {
    completada = false;
  }

  // Convertir a Map para subir a Firestore
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaLimite': fechaLimite.toIso8601String(),
      'completada': completada,
    };
  }

  // Crear una instancia desde Firestore
  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
      fechaLimite: DateTime.parse(map['fechaLimite']),
      completada: map['completada'] ?? false,
    );
  }
}