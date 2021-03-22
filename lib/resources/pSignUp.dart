import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtgonl/global/user.dart';

import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/widgets/mStyle.dart';
import 'package:vtgonl/validators/validation.dart';

import 'pSignUp2.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, @required this.phone}) : super(key: key);
  final String phone;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();

  MUser user = new MUser();

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userIdController = new TextEditingController();
  TextEditingController _userBirthDayController = new TextEditingController();
  TextEditingController _userProvinceController = new TextEditingController();
  TextEditingController _userVillageController = new TextEditingController();
  TextEditingController _userAddressController = new TextEditingController();
  TextEditingController _userLifeTimeController = new TextEditingController();

  var _gender = '';
  var _status = '';

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
                  'Thông tin cá nhân',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userNameController,
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  decoration:
                      CommonStyle.textFieldStyle('Họ và tên', 'Nguyễn Văn A'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userIdController,
                  keyboardType: TextInputType.phone,
                  maxLength: 20,
                  decoration: CommonStyle.textFieldStyle('Số CMND', ''),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userBirthDayController,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  onTap: () {
                    selectDate(context);
                  },
                  decoration:
                      CommonStyle.textFieldStyle('Ngày sinh', 'dd/mm/yyyy'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration: CommonStyle.textFieldStyle('Giới tính', ''),
                  value: _gender.isNotEmpty ? _gender : null,
                  items: Constants.itemsGender
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _gender = value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration:
                      CommonStyle.textFieldStyle('Tình trạng hôn nhân', ''),
                  value: _status.isNotEmpty ? _status : null,
                  items: Constants.itemsStatus
                      .map((item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _status = value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thông tin địa chỉ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userProvinceController,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  decoration: CommonStyle.textFieldStyle(
                      'Thành phố', 'Tên thành phố , tỉnh hiện tại đang sống '),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userVillageController,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  decoration: CommonStyle.textFieldStyle(
                      'Quận/Huyện', 'Tên quận/huyện hiện tại đang sống'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userAddressController,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: CommonStyle.textFieldStyle(
                      'Địa chỉ', 'Địa chỉ nhà ở hiện tại'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: _userLifeTimeController,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  decoration:
                      CommonStyle.textFieldStyle('Thời gian cư trú', ''),
                ),
              ),
              Container(
                  height: 48,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30),
                  child: CustomButton(
                    text: 'Tiếp tục',
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

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1975, 1),
        lastDate: DateTime(2030));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _userBirthDayController.text = selectedDate.day.toString() +
            '/' +
            selectedDate.month.toString() +
            '/' +
            selectedDate.year.toString();
      });
  }

  void onSignUpClicked() {
    if (Validation.isValidName(_userNameController.text) &&
        Validation.isValidInput(_userIdController.text) &&
        Validation.isValidInput(_userBirthDayController.text) &&
        Validation.isValidInput(_gender) &&
        Validation.isValidInput(_status) &&
        Validation.isValidInput(_userProvinceController.text) &&
        Validation.isValidInput(_userVillageController.text) &&
        Validation.isValidInput(_userAddressController.text) &&
        Validation.isValidInput(_userLifeTimeController.text)) {
      user.name = _userNameController.text;
      user.id = _userIdController.text;
      user.phone = widget.phone;
      user.birthday = _userBirthDayController.text;
      user.gender = _gender;
      user.status = _status;
      user.province = _userProvinceController.text;
      user.village = _userVillageController.text;
      user.address = _userAddressController.text;
      user.lifetime = _userLifeTimeController.text;

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => SignUpPage2(
                    user: user,
                  )));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: 'Lỗi !',
              descriptions: 'Thông tin cung cấp không đầy đủ.',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
  }
}
