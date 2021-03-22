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

  static const url_policy =
      'https://firebasestorage.googleapis.com/v0/b/vtgonl.appspot.com/o/Documents%2Fpolicy.pdf?alt=media&token=8d747097-12f2-4680-a063-7ad3be2be59f';
  static const url_term =
      'https://firebasestorage.googleapis.com/v0/b/vtgonl.appspot.com/o/Documents%2Fterm.pdf?alt=media&token=d5294fb6-dfea-424e-a0e6-c00582747c83';

  static const url_home = 'https://vtgonl.firebaseapp.com';
  static const url_homepage = 'https://vtgonline.tk';
  static const email = 'hotrovtgonline@gmail.com';

  static const url_facebook = 'https://m.me/vtgonl';
  static const url_zalo = 'https://zalo.me/+33763133710';

  static const root_user = 'USER';
  static const root_loan = 'LOAN';

  static const itemsGender = [
    'Nam',
    'Nữ',
  ];
  static const itemsStatus = [
    'Độc thân',
    'Đã kết hôn',
    'Đã ly hôn',
    'Đã ly thân',
  ];
  static const itemsEdu = [
    '12/12',
    'Cao đẳng',
    'Đại học',
  ];
  static const itemsRela = [
    'Cha, mẹ',
    'Anh, chị, em',
    'Vợ, chồng',
  ];
  static const itemsSotien = [
    '1 000 000đ',
    '2 000 000đ',
    '3 000 000đ',
    '4 000 000đ',
    '5 000 000đ',
    '6 000 000đ',
    '7 000 000đ',
    '8 000 000đ',
    '9 000 000đ',
    '10 000 000đ'
  ];
  static const itemsThoihan = [
    '1 tháng',
    '2 tháng',
    '3 tháng',
    '4 tháng',
    '5 tháng',
    '6 tháng'
  ];

  static const itemsJob = [
    'Kinh doanh tự do',
    'Công nhân',
    'NV văn phòng',
    'NV nhà nước',
    'Học sinh/Sinh Viên',
    'Nội trợ',
    'Về hưu'
  ];
  static const itemsSalary = [
    '1 - 3tr /tháng',
    '3 - 5tr /tháng',
    '5 - 8tr /tháng',
    '8 - 12tr /tháng',
    'Trên 12tr /tháng'
  ];
  static const itemsBankname = [
    'ACB',
    'ABBank',
    'Agribank',
    'BacABank',
    'BAOVIET Bank',
    'BIDV',
    'Đông Á - DAB',
    'HDBank',
    'HSBC',
    'NamABank',
    'Sacombank',
    'SAIGONBANK',
    'SCB',
    'SeABank',
    'Techcombank',
    'TPBank',
    'Vietcombank',
    'VietinBank',
    'VIB',
    'Viet Capital Bank',
    'VPBank'
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
