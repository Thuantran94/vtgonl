import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Constants {
  Constants._();
  static const double background_height = 450;
  static const double padding = 16;
  static const double diagRadius = 16;
  static const double buttonRadius = 50;
  static const double textFieldRadius = 50;
  static const double cardRadius = 5;

  static const Color colorPrimary = Colors.green;
  static const colorPrimaryLight = Colors.lightGreen;
  static const colorOrange = Colors.deepOrange;
  static const colorWhite = Colors.white;
  static const colorBack = Colors.black;
  static const colorGrey = Colors.grey;

  static const version = '1.0.0';

  static const avatar = 'assets/images/avatar.png';
  static const background = 'assets/images/cover.png';
  static const backgroundapp = 'assets/images/background.png';

  static const url_policy = ' Information was hidden for personal reason !';
  static const url_term = ' Information was hidden for personal reason !';

  static const url_home = ' Information was hidden for personal reason !';
  static const url_homepage = ' Information was hidden for personal reason !';
  static const email = ' Information was hidden for personal reason !';

  static const url_facebook = ' Information was hidden for personal reason !';
  static const url_zalo = ' Information was hidden for personal reason !';

  static const root_user = ' Information was hidden for personal reason !';
  static const root_loan = ' Information was hidden for personal reason !';

  static const itemsGender = [' Information was hidden for personal reason !'];
  static const itemsStatus = [' Information was hidden for personal reason !'];
  static const itemsEdu = [' Information was hidden for personal reason !'];
  static const itemsRela = [' Information was hidden for personal reason !'];
  static const itemsSotien = [' Information was hidden for personal reason !'];
  static const itemsThoihan = [' Information was hidden for personal reason !'];

  static const itemsJob = [' Information was hidden for personal reason !'];
  static const itemsSalary = [' Information was hidden for personal reason !'];
  static const itemsBankname = [
    ' Information was hidden for personal reason !'
  ];

  static Future<String> readFile(String filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final _localPath = directory.path;
      final _localFile = File('$_localPath/$filename');

      // Read the file.
      String contents = await _localFile.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return null;
    }
  }

  static Future<void> writeJson(
      Map<String, dynamic> file, String key, dynamic value) async {
    Map<String, dynamic> _newJson = {key: value};
    file.addAll(_newJson);
  }

  static Future<File> writeFile(String filename, String value) async {
    final directory = await getApplicationDocumentsDirectory();
    final _localPath = directory.path;
    final _localFile = File('$_localPath/$filename');

    _localFile.writeAsString('$value', mode: FileMode.append);

    return _localFile;
  }

  static Future<String> uploadFile(File _image, String name) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(name);
    TaskSnapshot taskSnapshot = await ref.putFile(_image);

    return await taskSnapshot.ref.getDownloadURL();
  }
}
