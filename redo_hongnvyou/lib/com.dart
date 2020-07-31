import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/services.dart';
import 'package:redo_hongnvyou/admob_info.dart';

class Launch{
   void launchURL() async {
    const url =
        "https://s.click.taobao.com/t?e=m%3D2%26s%3DL2CesJvCNgEcQipKwQzePCperVdZeJvi7UTzUAW%2BpR4YX8TY%2BNEwd6nH6WYiuhowTHm2guh0YLuPPeIuDtKbOVSu19OUhIzkKtj7QYO4MvYzaSBUzKe4y0I9rOd2bI%2Fcl9dxdp2kCvMAKqc2USsXlxmY%2BBNb7CKtfIrCKoPZYrQGZ%2FstJHrpqMR3fWzOxJq8naYpFBIfC%2F0TMkUtS6f4Uee2MEd8mDbNFeX0WK60lukwvJhybyexLXiugMmjfXDRDFhWT5oVJ5fGJe8N%2FwNpGw%3D%3D&union_lens=lensId%3APUB%401574410784%400b152c5a_0d16_16e92320e6a_049a%4001";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
class ToastHelper {
  static void showToast(BuildContext context, String text) {
    const style = TextStyle(color: Colors.white, fontSize: 14.0);

    Widget widget = Center(
      child: Material(
        child: Container(
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
    var entry = OverlayEntry(
      builder: (_) => widget,
    );

    Overlay.of(context).insert(entry);

    Timer(const Duration(seconds: 2), () {
      entry?.remove();
    });
  }
}



class ClipboardData {
  /// Creates data for the system clipboard.
  const ClipboardData({ this.text });

  /// Plain text variant of this clipboard data.
  final String text;
}


class Clipboard {
  Clipboard._();

  // Constants for common [getData] [format] types.

  /// Plain text data format string.
  ///
  /// Used with [getData].
  static const String kTextPlain = 'text/plain';

  /// Stores the given clipboard data on the clipboard.
  ///将ClipboardData中的内容复制的粘贴板
  static Future<void> setData(ClipboardData data) async {
    await SystemChannels.platform.invokeMethod<void>(
      'Clipboard.setData',
      <String, dynamic>{
        'text': data.text,
      },
    );
  }
}
