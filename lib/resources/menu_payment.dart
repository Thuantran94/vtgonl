import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtgonl/Animations/FadeAnimation.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/widgets/loader.dart';
import 'package:vtgonl/widgets/mStyle.dart';

class Payments extends StatefulWidget {
  final MUser user;
  Payments({Key key, @required this.user}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController shd_controller = new TextEditingController();

  var results = '', bill = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thanh Toán Khoản Vay"),
        backgroundColor: Constants.colorPrimary,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              FadeAnimation(
                0.4,
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 40, left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                        controller: shd_controller,
                        maxLength: 6,
                        cursorColor: Constants.colorPrimary,
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          counterText: '',
                          labelText: "Số  hợp đồng",
                          labelStyle: TextStyle(color: Constants.colorPrimary),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.colorPrimary),
                              borderRadius: BorderRadius.circular(50)),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ))),
              ),
              FadeAnimation(
                1.2,
                Container(
                    height: 48,
                    margin: EdgeInsets.only(top: 100, left: 16, right: 16),
                    child: CustomButton(
                      text: 'Kiểm tra',
                      onPressed: () {
                        kiemtrahopdong(shd_controller.text);
                      },
                    )),
              ),
              FadeAnimation(
                1.2,
                Container(
                  margin: EdgeInsets.only(
                    top: 180,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              results == ''
                                  ? results
                                  : "Họ và tên: \nSố tiền thanh toán: \nThanh toán trước ngày:\nSố tháng đã trả:\nSố ngày quá hạn:\nLời nhắn:",
                              style: TextStyle(fontSize: 12, height: 2),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              results,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 2,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                Container(
                  margin: EdgeInsets.only(top: 330),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              results == ''
                                  ? results
                                  : "Thanh toán bằng cách chuyển tiền vào tài khoản Ngân hàng sau: \nSố Tài khoản \nTên Tài khoản \nTên Ngân hàng \nChi nhánh \nNội dung ",
                              style: TextStyle(fontSize: 12, height: 2),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              results == ''
                                  ? results
                                  : "\n19035740331018 \nTRAN HOANG SON\nTechcombank\nTp. Hồ Chí Minh\nThanh toán Tên KH + SHD.",
                              style: TextStyle(fontSize: 12, height: 2),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                Container(
                  height: 48,
                  margin: EdgeInsets.only(top: 480, left: 16, right: 16),
                  child: results == ''
                      ? null
                      : CustomButton(
                          text: 'Xem hóa đơn',
                          onPressed: () async {
                            String url = Constants.url_home +
                                '/bill.html?shd=' +
                                shd_controller.text;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> kiemtrahopdong(String shd) async {
    if (shd.length < 6) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: 'Lỗi !',
              descriptions: 'Hợp đồng giao dịch không tồn tại',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ColorLoader();
        });

    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_loan)
        .child(shd)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = snapshot.value;

      if (values == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                icon: Icons.error,
                iconColor: Colors.red,
                title: 'Lỗi !',
                descriptions: 'Hợp đồng giao dịch không tồn tại',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            });
        return;
      }

      var name = values['name'];
      var sotien = values['sotien'];
      var thoihan = values['thoihan'];
      var sotientramoithang = values['sotientramoithang'];
      var sotienconno = values['sotienconno'];
      var laisuatconno = values['laisuatconno'];
      var phidichvuconno = values['phidichvuconno'];
      var phigiahanconno = values['phigiahanconno'];
      var phiquahan = values['phiquahan'];
      var ngayvay = values['ngayvay'];
      var ngaytratieptheo = values['ngaytratieptheo'];
      var note = values['note'];

      var songayquahan = values['songayquahan'];
      var tongsothangdatra = values['tongsothangdatra'];

      if (phiquahan == null || phiquahan == '') {
        phiquahan = '0';
      }
      if (sotienconno == null || sotienconno == '') {
        sotienconno = '0';
      }
      if (laisuatconno == null || laisuatconno == '') {
        laisuatconno = '0';
      }
      if (phidichvuconno == null || phidichvuconno == '') {
        phidichvuconno = '0';
      }
      if (phigiahanconno == null || phigiahanconno == '') {
        phigiahanconno = '0';
      }

      if (songayquahan == null || songayquahan == '') {
        songayquahan = '0';
      }

      if (tongsothangdatra == null || tongsothangdatra == '') {
        tongsothangdatra = '0';
      }
      if (note == null || note == '') {
        note = 'Không';
      }
      if (ngaytratieptheo == '' || ngaytratieptheo == null) {
        ngaytratieptheo = "Đang chờ phê duyệt hồ sơ...";
      }

      var sum =
          double.parse(sotientramoithang.replaceAll(RegExp('[^0-9]'), '')) +
              double.parse(phiquahan.replaceAll(RegExp('[^0-9]'), '')) +
              double.parse(sotienconno.replaceAll(RegExp('[^0-9]'), '')) +
              double.parse(laisuatconno.replaceAll(RegExp('[^0-9]'), '')) +
              double.parse(phidichvuconno.replaceAll(RegExp('[^0-9]'), '')) +
              double.parse(phigiahanconno.replaceAll(RegExp('[^0-9]'), ''));

      var total = ((sum * 0.001).round() * 1000)
          .toString()
          .replaceAll(new RegExp(r"(?=(\d{3})+(?!\d))"), ' ');

      var rs = name +
          '\n' +
          total +
          '\n' +
          ngaytratieptheo +
          '\n' +
          tongsothangdatra +
          '/' +
          thoihan +
          '\n' +
          songayquahan +
          '\n' +
          note +
          '\n';

      Navigator.of(context).pop();
      setState(() {
        results = rs;
      });
    });
  }
}
