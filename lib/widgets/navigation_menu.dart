import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtgonl/global/noti.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/global/constants.dart';

import 'package:vtgonl/resources/login.dart';
import 'package:vtgonl/resources/menu_payment.dart';

import 'package:vtgonl/resources/menu_profile.dart';
import 'package:vtgonl/resources/menu_loan.dart';
import 'package:vtgonl/resources/menu_noti.dart';
import 'package:vtgonl/resources/menu_chat.dart';
import 'package:vtgonl/resources/menu_contact.dart';

class MenuItem extends StatefulWidget {
  final MUser user;
  MenuItem({Key key, @required this.user}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  File _avatarFile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 145,
              width: double.infinity,
              child: Image.asset(
                Constants.background,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Constants.colorWhite,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 90.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.user.name,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        widget.user.phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.public_outlined,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text('??ang ho???t ?????ng',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Constants.colorPrimaryLight,
                            Constants.colorPrimary
                          ]),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);

                            setState(() {
                              if (pickedFile != null) {
                                _avatarFile = File(pickedFile.path);
                                widget.user.imageAVATAR = _avatarFile;
                                upLoadAvatar();
                              } else {
                                print('No image selected!');
                              }
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: _avatarFile != null
                                ? Image.file(_avatarFile)
                                : Image.network(
                                    widget.user.linkAVATAR,
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        Profile(user: widget.user)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.person_pin,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "T??i kho???n",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        Loans(user: widget.user)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.description_rounded,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "H???p ?????ng",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        Payments(user: widget.user)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.credit_card,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Thanh to??n",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Chat(
                                          user: widget.user,
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.message,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Tin nh???n",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Spacer(),
                                if (true)
                                  Material(
                                      color: Constants.colorPrimary,
                                      elevation: 5.0,
                                      shadowColor: Colors.red,
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Constants.colorOrange,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          "10+",
                                          style: TextStyle(
                                              color: Constants.colorWhite,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        NOTI(notis: widget.user.notis)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.notifications,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Th??ng b??o",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Spacer(),
                                if (true)
                                  Material(
                                      color: Constants.colorPrimary,
                                      elevation: 5.0,
                                      shadowColor: Colors.red,
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Constants.colorOrange,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          widget.user.notis != null
                                              ? widget.user.notis.length
                                                  .toString()
                                              : '0',
                                          style: TextStyle(
                                              color: Constants.colorWhite,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Contact()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.contact_phone,
                                    color: Constants.colorPrimary),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Li??n h???",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(''),
                                    content:
                                        Text('?????ng ?? ????ng xu???t t??i kho???n ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('????NG')),
                                      FlatButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text("B???n ???? ????ng xu???t!"),
                                          ));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        },
                                        child: Text('OK'),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(Icons.power_settings_new,
                                    color: Colors.red),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "????ng xu???t",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildDivider(),
                        Container(
                          padding: EdgeInsets.only(right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'Version ' + Constants.version,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Constants.colorPrimary,
              ),
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.grey.shade400,
    );
  }

  Future<void> upLoadAvatar() async {
    widget.user.linkAVATAR = await Constants.uploadFile(
        widget.user.imageAVATAR, widget.user.phone + 'avatar');

    String vnphone = '+84' + widget.user.phone.substring(1);

    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_user)
        .child(vnphone)
        .update({
      'linkAVATAR': widget.user.linkAVATAR,
    });
    print('Up loaded avatar successfuly!');
  }
}
