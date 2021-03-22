import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/global/user.dart';

import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/global/constants.dart';
import 'pUpload.dart';

class HomePageContract extends StatefulWidget {
  final MUser user;
  final MLoan loan;

  final DateTime now = new DateTime.now();

  final shd =
      DateTime.now().toUtc().millisecondsSinceEpoch.toString().substring(5, 11);

  HomePageContract({Key key, this.user, this.loan}) : super(key: key);

  @override
  _HomePageContractState createState() => _HomePageContractState();
}

class _HomePageContractState extends State<HomePageContract> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  String shd;
  String sotien, thoihan, sotientramoithang;
  String bankname, bankuser, banknum, bankaddress;

  String day, month, year;

  @override
  void initState() {
    super.initState();

    shd = widget.shd;
    sotien = widget.loan.sotien;
    thoihan = widget.loan.thoihan;
    sotientramoithang = widget.loan.sotientramoithang;

    bankname = widget.user.bankName;
    bankuser = widget.user.bankUser;
    banknum = widget.user.bankNumber;
    bankaddress = widget.user.bankAddress;

    day = widget.now.day < 10
        ? '0' + widget.now.day.toString()
        : widget.now.day.toString();

    month = widget.now.month < 10
        ? '0' + widget.now.month.toString()
        : widget.now.month.toString();

    year = widget.now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(' Information was hidden for personal reason !'),
        backgroundColor: Constants.colorPrimary,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16, right: 16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                "N° " + shd,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ' Information was hidden for personal reason !',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          ' Information was hidden for personal reason !',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'Ông/Bà: ',
                            style: TextStyle(color: Constants.colorBack),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.user.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.colorBack),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'CMND Số : ',
                            style: TextStyle(color: Constants.colorBack),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.user.id,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.colorBack),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                 ' Information was hidden for personal reason !',
                  textAlign: TextAlign.justify),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                    color: Constants.colorBack,
                  ),
                  text:
                      ' Information was hidden for personal reason !',
                  children: <TextSpan>[
                    TextSpan(
                      text: sotien,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
               ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(color: Constants.colorBack),
                  text:
                      ' Information was hidden for personal reason !',
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.loan.mucdich,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                  ' Information was hidden for personal reason !',
                  style: TextStyle(),
                  textAlign: TextAlign.justify),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ' Information was hidden for personal reason !',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          banknum +
                              '\n' +
                              bankuser +
                              '\n' +
                              bankname +
                              '\n' +
                              bankaddress,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ' Information was hidden for personal reason !',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          thoihan +
                              '\n' +
                              sotientramoithang +
                              'đ\n' +
                              day +
                              ' tây',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
               ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(color: Constants.colorBack),
                  text:
                    ' Information was hidden for personal reason !',
                  children: <TextSpan>[
                    TextSpan(
                      text: phitratre(sotien) + 'đ /tuần',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                         ' Information was hidden for personal reason !',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                ' Information was hidden for personal reason !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 6),
              child: Text(
                ' Information was hidden for personal reason !',
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
                height: 48,
                margin: EdgeInsets.only(top: 30),
                child: CustomButton(
                  text: 'Tiếp tục',
                  onPressed: () {
                    onButtonClicked();
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

  void onButtonClicked() {
    widget.loan.shd = shd;
    widget.loan.ngaytao = day + "/" + month + "/" + year;
    widget.loan.trangthai = 'pending';

    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => HomePageUpload(
                  user: widget.user,
                  loan: widget.loan,
                )));
  }

  String phitratre(String sotien) {
    double st = double.parse(sotien.replaceAll(RegExp('[^0-9]'), ''));

    var rs = (st * 0.03).round();

    return rs.toString().replaceAll(new RegExp(r"(?=(\d{3})+(?!\d))"), ' ');
  }
}
