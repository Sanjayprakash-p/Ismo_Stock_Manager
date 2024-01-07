import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_2/constants/serverkey.dart';

void sendNotification(String token, String title, String body) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //final url = 'https://fcm.googleapis.com/fcm/send';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=${Constant.serverKey}',
  };

  final message = {
    'notification': {
      'title': title,
      'body': body,
    },
    'to': token,
  };

  final response =
      await http.post(url, headers: headers, body: json.encode(message));

  if (response.statusCode == 200) {
    print('Notification sent successfully.');
  } else {
    print('Failed to send notification. Status code: ${response.statusCode}');
  }
}
