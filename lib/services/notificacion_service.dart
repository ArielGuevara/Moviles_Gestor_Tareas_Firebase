import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificacionService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initNotificaciones(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Permiso concedido');

      final token = await _fcm.getToken();
      print('🔑 Token: $token');

      // Notificación en primer plano
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        if (notification != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(notification.title ?? 'Nueva notificación')),
          );
        }
      });

      // Cuando el usuario abre la notificación
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('🟢 Abrió notificación: ${message.data}');
        // Aquí puedes navegar a una pantalla específica si lo deseas
      });
    }
  }
}