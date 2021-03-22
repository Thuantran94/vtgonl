import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/validators/validation.dart';
import 'package:vtgonl/widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/global/constants.dart';
import 'home.dart';

class SignUpPage2 extends StatefulWidget {
  SignUpPage2({Key key, @required this.user}) : super(key: key);
  final MUser user;
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUpPage2> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _userRelationName1Controller =
      new TextEditingController();
  TextEditingController _userRelationPhone1Controller =
      new TextEditingController();
  TextEditingController _userRelationName2Controller =
      new TextEditingController();
  TextEditingController _userRelationPhone2Controller =
      new TextEditingController();
  TextEditingController _userFbController = new TextEditingController();
  TextEditingController _userEmailController = new TextEditingController();

  var _edu = '';
  var _rela1 = '';
  var _rela2 = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Đăng Ký Tài Khoản'),
        backgroundColor: Constants.colorPrimary,
        elevation: 0,
      ),
      body: Container(
        color: Constants.colorWhite,
        constraints: BoxConstraints.expand(),
        width: double.infinity,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thông tin người thân',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userRelationName1Controller,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: CommonStyle.textFieldStyle(
                      'Họ và tên 1', 'Tên người thân 1'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userRelationPhone1Controller,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: CommonStyle.textFieldStyle('Số ĐTDĐ', ''),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration: CommonStyle.textFieldStyle('Mối quan hệ', ''),
                  value: _rela1.isNotEmpty ? _rela1 : null,
                  items: Constants.itemsRela
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _rela1 = value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userRelationName2Controller,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration: CommonStyle.textFieldStyle(
                      'Họ và tên 2', 'Tên người thân 2'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userRelationPhone2Controller,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: CommonStyle.textFieldStyle('Số ĐTDĐ', ''),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration: CommonStyle.textFieldStyle('Mối quan hệ', ''),
                  value: _rela2.isNotEmpty ? _rela2 : null,
                  items: Constants.itemsRela
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _rela2 = value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thông tin bổ sung',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration:
                      CommonStyle.textFieldStyle('Trình độ học vấn', ''),
                  value: _edu.isNotEmpty ? _edu : null,
                  items: Constants.itemsEdu
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _edu = value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userFbController,
                  keyboardType: TextInputType.phone,
                  maxLength: 50,
                  decoration: CommonStyle.textFieldStyle(
                      'Liên kết trang Facebook', 'https://www.facebook.com/id'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userEmailController,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration:
                      CommonStyle.textFieldStyle('Email', 'email@example.com'),
                ),
              ),
              Container(
                  height: 48,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30),
                  child: CustomButton(
                    text: 'Đăng ký',
                    onPressed: () {
                      onSignUpClicked();
                    },
                  )),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSignUpClicked() async {
    if (Validation.isValidName(_userRelationName1Controller.text) &&
        Validation.isValidPhone(_userRelationPhone1Controller.text) &&
        Validation.isValidInput(_rela1) &&
        Validation.isValidName(_userRelationName2Controller.text) &&
        Validation.isValidPhone(_userRelationPhone2Controller.text) &&
        Validation.isValidInput(_rela2) &&
        Validation.isValidInput(_edu) &&
        Validation.isValidInput(_userFbController.text) &&
        Validation.isValidEmail(_userEmailController.text)) {
      //

      widget.user.relationName1 = _userRelationName1Controller.text;
      widget.user.relationPhone1 = _userRelationPhone1Controller.text;
      widget.user.relationRela1 = _rela1;
      widget.user.relationName2 = _userRelationName2Controller.text;
      widget.user.relationPhone2 = _userRelationPhone2Controller.text;
      widget.user.relationRela2 = _rela2;
      widget.user.edu = _edu;
      widget.user.email = _userEmailController.text;

      var parts = _userFbController.text.split('/');
      String fbID = parts[parts.length - 1];

      widget.user.facebook = fbID;

      widget.user.linkAVATAR =
          'https://firebasestorage.googleapis.com/v0/b/vtgonl.appspot.com/o/images%2Favatar.png?alt=media&token=ef50f59f-9d15-48c1-9fea-3108e2d3bed0';

      String vnphone = '+84' + widget.user.phone.substring(1);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ColorLoader();
          });
      await FirebaseDatabase.instance
          .reference()
          .child(Constants.root_user)
          .child(vnphone)
          .update({
        'ACTIVE': 'false',
        'name': widget.user.name,
        'id': widget.user.id,
        'phone': widget.user.phone,
        'email': widget.user.email,
        'birthday': widget.user.birthday,
        'gender': widget.user.gender,
        'status': widget.user.status,
        'province': widget.user.province,
        'village': widget.user.village,
        'address': widget.user.address,
        'lifeTime': widget.user.lifetime,
        'relationName1': widget.user.relationName1,
        'relationPhone1': widget.user.relationPhone1,
        'relationRela1': widget.user.relationRela1,
        'relationName2': widget.user.relationName2,
        'relationPhone2': widget.user.relationPhone2,
        'relationRela2': widget.user.relationRela2,
        'edu': widget.user.edu,
        'facebook': widget.user.facebook,
        'linkAVATAR': widget.user.linkAVATAR
      });

      Navigator.of(context).pop();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.check,
              iconColor: Colors.green,
              title: 'Hoàn tất !',
              descriptions: 'Đăng ký tài khoản thành công.',
              textLeft: 'TÌM HIỂU THÊM',
              onPressedLeft: () async {
                const url = Constants.url_term;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                gotoHomePage();
              },
              onPressed: () {
                gotoHomePage();
              },
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.blue,
              title: 'Lỗi !',
              descriptions: 'Thông tin cung cấp không đầy đủ.',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
  }

  void gotoHomePage() {
    Navigator.of(context).pop();
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => HomePage(user: widget.user)));
  }
}
