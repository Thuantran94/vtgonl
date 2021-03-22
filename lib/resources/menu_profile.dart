import 'package:flutter/material.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/widgets/mStyle.dart';

class Profile extends StatefulWidget {
  final MUser user;
  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _editProfile = false;
  var _editCar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thông Tin Tài Khoản"),
        backgroundColor: Constants.colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 155,
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
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
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
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Row(
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
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          widget.user.email,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
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
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            Constants.colorPrimaryLight,
                            Constants.colorPrimary
                          ]),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            widget.user.linkAVATAR,
                            height: 80.0,
                            width: 80.0,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          onTap: () {
                            setState(() {
                              _editProfile = !_editProfile;
                            });

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    icon: Icons.error,
                                    iconColor: Colors.blue,
                                    title: 'Thông báo',
                                    descriptions:
                                        'Không thể thay đổi thông tin cá nhân.',
                                    onPressed: () {
                                      setState(() {
                                        _editProfile = !_editProfile;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                });
                          },
                          trailing: _editProfile == false
                              ? Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.lock_open,
                                  color: Colors.red,
                                ),
                          title: Text(
                            "Thông tin cá nhân",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        _buildDivider(),
                        ListTile(
                            dense: true,
                            title: Text("Họ Tên"),
                            subtitle: Text(widget.user.name),
                            leading: Icon(Icons.perm_identity)),
                        ListTile(
                            dense: true,
                            title: Text("Phone"),
                            subtitle: Text(widget.user.phone),
                            leading: Icon(Icons.phone)),
                        ListTile(
                            dense: true,
                            title: Text("Email"),
                            subtitle: Text(widget.user.email),
                            leading: Icon(Icons.email)),
                        ListTile(
                          dense: true,
                          title: Text("Địa chỉ nhà"),
                          subtitle: Text(widget.user.address),
                          leading: Icon(Icons.location_city),
                        ),
                        ListTile(
                            dense: true,
                            title: Text("Facebook"),
                            subtitle: Text(widget.user.facebook),
                            leading: Icon(Icons.apps)),
                        ListTile(
                          dense: true,
                          onTap: () {
                            setState(() {
                              _editCar = !_editCar;
                            });

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    icon: Icons.error,
                                    iconColor: Colors.blue,
                                    title: 'Thông báo',
                                    descriptions:
                                        'Không thể thay đổi thông tin người thân.',
                                    onPressed: () {
                                      setState(() {
                                        _editCar = !_editCar;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                });
                          },
                          trailing: _editCar == false
                              ? Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.lock_open,
                                  color: Colors.red,
                                ),
                          title: Text(
                            "Thông tin người thân",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        _buildDivider(),
                        ListTile(
                          dense: true,
                          title: Row(
                            children: [
                              Icon(
                                Icons.perm_identity,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.user.relationName1,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(widget.user.relationPhone1 +
                                  ' - ' +
                                  widget.user.relationRela1),
                            ],
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Row(
                            children: [
                              Icon(
                                Icons.perm_identity,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.user.relationName2,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(widget.user.relationPhone2 +
                                  ' - ' +
                                  widget.user.relationRela2),
                            ],
                          ),
                        ),
                        FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.grey),
                              ],
                            ),
                            onPressed: () {
                              _displayDialogAddRelation(context);
                            },
                            textColor: Colors.black,
                            color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ),
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

  void _displayDialogAddRelation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Thêm người thân'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Họ và tên'),
                  maxLines: 1,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Số điện thoại'),
                  maxLines: 1,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Quan hệ'),
                  maxLines: 1,
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ĐÓNG'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('ĐỒNG Ý'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          icon: Icons.error,
                          iconColor: Colors.blue,
                          title: 'Thông báo',
                          descriptions: 'Hiện tại không thể thêm người thân.',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      });
                },
              ),
            ],
          );
        });
  }
}
