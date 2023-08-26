import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/foundation.dart';

class SendMail {
  static void sendMail(
      {required String recieverMail, required String message}) async {
    String senderMail = 'mmhasan5365@gmail.com';
    String senderPass = 'scnxgukypjldebar';

    final smtpServer = gmail(senderMail, senderPass);
    final body = Message()
      ..from = Address(senderMail, 'Mail Service')
      ..recipients.add(recieverMail)
      ..subject = 'Mail '
      ..text = 'Message: $message';

    try {
      await send(body, smtpServer);
      print('Mail Successful');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  
}
