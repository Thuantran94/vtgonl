import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/widgets/navigation_menu.dart';
import 'package:vtgonl/Animations/FadeAnimation.dart';

import 'package:vtgonl/widgets/mStyle.dart';
import 'package:vtgonl/global/constants.dart';
import 'pForm.dart';

class HomePage extends StatefulWidget {
  final MUser user;
  final MLoan loan = new MLoan();

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String sotien, thoihan;
  String sotientramoithang, phidichvu;

  @override
  void initState() {
    super.initState();
    sotien = '5 000 000đ';
    thoihan = '1 tháng';
    sotientramoithang = '5 400 000';
    phidichvu = '500 000';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: MenuItem(
          user: widget.user,
        ),
      ),
      body: WillPopScope(
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                height: Constants.background_height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Constants.backgroundapp),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                              child: Icon(Icons.menu,
                                  color: Constants.colorWhite)),
                        ],
                      ),
                    ),
                    FadeAnimation(
                      0.2,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 80, left: 16, right: 16),
                        child: Text(
                          "Bạn cần vay vốn?",
                          style: TextStyle(
                              fontSize: 24,
                              color: Constants.colorWhite,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.4,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 120, left: 16, right: 16),
                        child: Text(
                          "Chọn số tiền muốn vay",
                          style: TextStyle(color: Constants.colorWhite),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.4,
                      Container(
                        margin: EdgeInsets.only(top: 140, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Constants.colorWhite,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: CommonStyle.textFieldStyle('', ''),
                          value: sotien.isNotEmpty ? sotien : null,
                          items: Constants.itemsSotien
                              .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => sotien = value);
                            if (sotien != '' && thoihan != '') {
                              sotientramoithang = tientra(sotien, thoihan);
                              phidichvu = tienphi(sotien, thoihan);
                            }
                          },
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.6,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 200, left: 16, right: 16),
                        child: Text(
                          "Bạn vay trong bao lâu",
                          style: TextStyle(color: Constants.colorWhite),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.6,
                      Container(
                        margin: EdgeInsets.only(top: 220, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Constants.colorWhite,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: CommonStyle.textFieldStyle('', ''),
                          value: thoihan.isNotEmpty ? thoihan : null,
                          items: Constants.itemsThoihan
                              .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    value: item,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => thoihan = value);
                            if (sotien != '' && thoihan != '') {
                              sotientramoithang = tientra(sotien, thoihan);
                              phidichvu = tienphi(sotien, thoihan);
                            }
                          },
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.8,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 300, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Số tiền góp mỗi tháng",
                              style: TextStyle(color: Constants.colorWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      0.8,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 300, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              sotientramoithang + 'đ',
                              style: TextStyle(
                                  color: Constants.colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 320, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Phí dịch vụ",
                              style: TextStyle(color: Constants.colorWhite),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 320, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              phidichvu + 'đ',
                              style: TextStyle(
                                  color: Constants.colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: FadeAnimation(
                  1.2,
                  Container(
                      height: 48,
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: CustomButton(
                        text: 'Tiếp tục',
                        onPressed: () {
                          onButtonClicked();
                        },
                      )),
                ),
              )
            ],
          )),
        ),
        onWillPop: () {
          if (_scaffoldKey.currentState.isDrawerOpen) {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }

  void onButtonClicked() {
    if (sotien != '' && thoihan != '') {
      widget.loan.sotien = sotien;
      widget.loan.thoihan = thoihan;

      widget.loan.sotientramoithang = sotientramoithang;
      widget.loan.phidichvu = phidichvu;

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => HomePage1(
                    user: widget.user,
                    loan: widget.loan,
                  )));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
                icon: Icons.error,
                iconColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: 'Thông báo',
                descriptions:
                    'Vui lòng chọn số tiền và thời hạn vay trước khi tiếp tục.');
          });
    }
  }

  String tientra(String sotien, String thoihan) {
    double st = double.parse(sotien.replaceAll(RegExp('[^0-9]'), ''));
    int th = int.parse(thoihan.replaceAll(RegExp('[^0-9]'), ''));

    var rs = (((st / th) + (st * 0.08)) * 0.001).round();

    return (rs * 1000)
        .toString()
        .replaceAll(new RegExp(r"(?=(\d{3})+(?!\d))"), ' ');
  }

  String tienphi(sotien, thoihan) {
    double st = double.parse(sotien.replaceAll(RegExp('[^0-9]'), ''));
    int th = int.parse(thoihan.replaceAll(RegExp('[^0-9]'), ''));

    var index = 0.10;
    if (th > 1) {
      index = index + (th - 1) * 0.01;
    }
    var rs = (st * index * 0.001).round();
    return (rs * 1000)
        .toString()
        .replaceAll(new RegExp(r"(?=(\d{3})+(?!\d))"), ' ');
  }
}
