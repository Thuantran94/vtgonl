import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/validators/validation.dart';

import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/global/constants.dart';
import 'pContract.dart';

class HomePage1 extends StatefulWidget {
  final MUser user;
  final MLoan loan;

  HomePage1({Key key, this.user, this.loan}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _userCompanyNameController =
      new TextEditingController();
  TextEditingController _userCompanyAddressController =
      new TextEditingController();
  TextEditingController _userCompanyPhoneController =
      new TextEditingController();
  TextEditingController _bankAddressController = new TextEditingController();
  TextEditingController _bankUserNameController = new TextEditingController();
  TextEditingController _bankUserNumberController = new TextEditingController();
  TextEditingController _mucdichvayController = new TextEditingController();
  TextEditingController _kehoachtraController = new TextEditingController();

  String _userjob, _usersalary, _bankname;

  @override
  void initState() {
    super.initState();

    _userCompanyNameController.text = widget.user.companyName;
    _userCompanyAddressController.text = widget.user.companyAddress;
    _userCompanyPhoneController.text = widget.user.companyPhone;

    _bankUserNameController.text = widget.user.bankUser;
    _bankUserNumberController.text = widget.user.bankNumber;
    _bankAddressController.text = widget.user.bankAddress;

    _userjob = widget.user.job != null ? widget.user.job : '';
    _usersalary = widget.user.salary != null ? widget.user.salary : '';
    _bankname = widget.user.bankName != null ? widget.user.bankName : '';

    _mucdichvayController.text =
        widget.loan.mucdich != null ? widget.loan.mucdich : '';
    _kehoachtraController.text =
        widget.loan.kehoachtra != null ? widget.loan.kehoachtra : '';

    checkHint('hintPForm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Thông Tin Cá Nhân"),
        backgroundColor: Constants.colorPrimary,
        elevation: 0.0,
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
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Thông tin việc làm",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: DropdownButtonFormField<String>(
                decoration:
                    CommonStyle.textFieldStyle('Nghề nghiệp hiện tại', ''),
                value: _userjob.isNotEmpty ? _userjob : null,
                items: Constants.itemsJob
                    .map((item) =>
                        DropdownMenuItem(child: Text(item), value: item))
                    .toList(),
                onChanged: (value) {
                  setState(() => _userjob = value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: DropdownButtonFormField<String>(
                decoration:
                    CommonStyle.textFieldStyle('Lương/thu nhập chính', ''),
                value: _usersalary.isNotEmpty ? _usersalary : null,
                items: Constants.itemsSalary
                    .map((item) => DropdownMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _usersalary = value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _userCompanyNameController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: CommonStyle.textFieldStyle('Tên công ty', ''),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _userCompanyAddressController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: CommonStyle.textFieldStyle('Địa chỉ công ty', ''),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _userCompanyPhoneController,
                keyboardType: TextInputType.text,
                maxLength: 10,
                decoration:
                    CommonStyle.textFieldStyle('Số điện thoại công ty', ''),
              ),
            ),
            _buildDivider(),
            Container(
              width: double.infinity,
              child: Text(
                "Tài khoản ngân hàng",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: DropdownButtonFormField<String>(
                decoration: CommonStyle.textFieldStyle('Tên ngân hàng', ''),
                value: _bankname.isNotEmpty ? _bankname : null,
                items: Constants.itemsBankname
                    .map((item) => DropdownMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _bankname = value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _bankUserNumberController,
                keyboardType: TextInputType.text,
                maxLength: 20,
                decoration: CommonStyle.textFieldStyle('Số tài khoản', ''),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _bankUserNameController,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: CommonStyle.textFieldStyle('Tên tài khoản', ''),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _bankAddressController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: CommonStyle.textFieldStyle('Chi nhánh', ''),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Thông tin bổ sung",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _mucdichvayController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: CommonStyle.textFieldStyle(
                    'Mục đích vay', 'Bạn cần vay vốn để làm gì?'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: TextField(
                controller: _kehoachtraController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: CommonStyle.textFieldStyle(
                    'Kế hoạch chi trả', 'Bạn sẽ trả khoản vay bằng cách nào?'),
              ),
            ),
            Container(
                height: 48,
                margin: EdgeInsets.only(top: 20),
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
    if (Validation.isValidInput(_bankname) &&
        Validation.isValidInput(_userCompanyNameController.text) &&
        Validation.isValidPhone(_userCompanyPhoneController.text) &&
        Validation.isValidInput(_userCompanyAddressController.text) &&
        Validation.isValidInput(_bankUserNumberController.text) &&
        Validation.isValidName(_bankUserNameController.text) &&
        Validation.isValidInput(_bankAddressController.text) &&
        Validation.isValidInput(_mucdichvayController.text) &&
        Validation.isValidInput(_kehoachtraController.text)) {
      // set new user information
      widget.user.job = _userjob;
      widget.user.salary = _usersalary;
      widget.user.companyName = _userCompanyNameController.text;
      widget.user.companyPhone = _userCompanyPhoneController.text;
      widget.user.companyAddress = _userCompanyAddressController.text;

      widget.user.bankName = _bankname;
      widget.user.bankUser = _bankUserNameController.text;
      widget.user.bankNumber = _bankUserNumberController.text;
      widget.user.bankAddress = _bankAddressController.text;

      widget.loan.mucdich = _mucdichvayController.text;
      widget.loan.kehoachtra = _kehoachtraController.text;

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => HomePageContract(
                    user: widget.user,
                    loan: widget.loan,
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

  Divider _buildDivider() {
    return Divider(
      color: Constants.colorWhite,
    );
  }

  Future<void> showHint(String name) async {
    await Future.delayed(Duration(milliseconds: 500));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogHint(
            name: name,
            descriptions:
                'Để đảm bảo quá trình xét duyệt hồ sơ và giải ngân khoản vay mà bạn đã yêu cầu diễn ra nhanh chóng, vui lòng cung cấp thông tin theo mẫu một cách đầy đủ và chính xác. Tất cả các thông tin cá nhân do bạn cung cấp sẽ được giữ bí mật tuyệt đối và được lưu trữ tự động trên cơ sở dữ liệu của chúng tôi. Bất kì thông tin khai báo nào không đúng sự thật sẽ bị khóa tài khoản vĩnh viễn!  ',
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  Future<void> checkHint(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(name) ?? 0;
    if (value == 0) {
      showHint(name);
    }
  }
}
