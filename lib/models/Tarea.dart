import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tarea {
  final String? docId; // ID del documento en Firestore
  final String titulo;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime fechaLimite;
  bool completada;

  Tarea({
    this.docId,
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
      'docId': docId, // Incluir el ID del documento si está presente
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaLimite': fechaLimite.toIso8601String(),
      'completada': completada,
    };
  }

  // Crear una instancia desde Firestore
  factory Tarea.fromMap(Map<String, dynamic> map, String? docId) {
    return Tarea(
      docId: docId, // Asignar el ID del documento si está presente
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fechaCreacion: map['fechaCreacion'] is Timestamp
        ? (map['fechaCreacion'] as Timestamp).toDate()
        : DateTime.parse(map['fechaCreacion']),
      fechaLimite: map['fechaLimite'] is Timestamp
        ? (map['fechaLimite'] as Timestamp).toDate()
        : DateTime.parse(map['fechaLimite']),
      completada: map['completada'] ?? false,
    );
  }
}