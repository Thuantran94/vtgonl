import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtgonl/global/constants.dart';

class CommonStyle {
  static InputDecoration textFieldStyle(String label, String str) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      labelText: label,
      hintText: str,
      counterText: '',
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.colorPrimary),
        borderRadius: BorderRadius.circular(Constants.textFieldRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.colorPrimary),
        borderRadius: BorderRadius.circular(Constants.textFieldRadius),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;

  CustomButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Constants.colorPrimary,
      child: Container(
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Constants.colorPrimary, Constants.colorPrimaryLight]),
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.buttonRadius)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                  color: Constants.colorWhite, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.buttonRadius)),
      onPressed: onPressed,
    );
  }
}

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title, descriptions;
  final String textLeft;
  final GestureTapCallback onPressed, onPressedLeft;

  CustomDialog(
      {this.icon,
      this.iconColor,
      @required this.title,
      @required this.descriptions,
      this.onPressedLeft,
      this.textLeft,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.buttonRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Constants.padding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(Constants.diagRadius),
                boxShadow: [
                  BoxShadow(
                      color: Constants.colorBack,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  color: iconColor,
                  size: 70,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  descriptions,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: onPressedLeft,
                          child: Text(
                            textLeft != null ? textLeft : '',
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: onPressed,
                          child: Text(
                            'ĐÓNG',
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialogHint extends StatefulWidget {
  @override
  _CustomDialogHintState createState() => _CustomDialogHintState();
  final String name;
  final String descriptions;
  final GestureTapCallback onPressed;

  CustomDialogHint(
      {@required this.name,
      @required this.descriptions,
      @required this.onPressed});
}

class _CustomDialogHintState extends State<CustomDialogHint> {
  bool ischeckedbox = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.buttonRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Constants.padding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(Constants.diagRadius),
                boxShadow: [
                  BoxShadow(
                      color: Constants.colorBack,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.descriptions,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                              value: ischeckedbox,
                              onChanged: (value) {
                                setState(() {
                                  ischeckedbox = value;
                                  setHint(widget.name, ischeckedbox);
                                });
                              },
                            ),
                            Text('Không hiển thị lại'),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                                onPressed: widget.onPressed,
                                child: Text(
                                  'ĐÃ HIỂU',
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setHint(String name, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    value ? prefs.setInt(name, 1) : prefs.setInt(name, 0);
  }
}

class CustomDialogInput extends StatelessWidget {
  final String title, text;
  final GestureTapCallback onPressed;

  final TextEditingController controller;

  CustomDialogInput(
      {@required this.title,
      @required this.text,
      @required this.controller,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.buttonRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Constants.padding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(Constants.diagRadius),
                boxShadow: [
                  BoxShadow(
                      color: Constants.colorBack,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.code,
                  color: Colors.blue,
                  size: 60,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(counterText: ''),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: onPressed,
                      child: Text(
                        'XONG',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialogImage extends StatelessWidget {
  final File file;
  CustomDialogImage({@required this.file});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.buttonRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(Constants.padding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Constants.colorWhite,
                borderRadius: BorderRadius.circular(Constants.diagRadius),
                boxShadow: [
                  BoxShadow(
                      color: Constants.colorBack,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(child: Image.file(file)),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ĐÓNG',
                      style: TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String shd, sotien, thoihan, status, ngaytao;
  final GestureTapCallback onPressed;

  var colorStart, colorEnd;
  var stt;

  CustomCard(
      {@required this.shd,
      @required this.sotien,
      @required this.thoihan,
      @required this.status,
      @required this.ngaytao,
      this.onPressed});

  Color getColorStart(String status) {
    switch (status) {
      case 'pending':
        colorStart = Colors.orange[600];
        break;
      case 'actived':
        colorStart = Colors.green[600];
        break;
      case 'refused':
        colorStart = Colors.red[600];
        break;
      case 'finished':
        colorStart = Colors.grey[600];
        break;
      default:
    }
    return colorStart;
  }

  Color getColorEnd(String status) {
    switch (status) {
      case 'pending':
        colorEnd = Colors.orange[400];
        break;
      case 'actived':
        colorEnd = Colors.green[400];
        break;
      case 'refused':
        colorEnd = Colors.red[400];
        break;
      case 'finished':
        colorEnd = Colors.grey[400];
        break;
      default:
    }
    return colorEnd;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 300,
          height: 100,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [getColorStart(status), getColorEnd(status)]),
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.cardRadius)),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'SHD ' + shd,
                              style: TextStyle(
                                  color: Constants.colorWhite,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              sotien,
                              style: TextStyle(
                                  color: Constants.colorWhite,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Thời hạn',
                              style: TextStyle(
                                color: Constants.colorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              thoihan + ' tháng',
                              style: TextStyle(color: Constants.colorWhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Ngày yêu cầu',
                              style: TextStyle(
                                color: Constants.colorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              ngaytao,
                              style: TextStyle(color: Constants.colorWhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
