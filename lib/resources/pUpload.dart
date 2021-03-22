import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/global/user.dart';

import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/global/constants.dart';
import 'pPermission.dart';

class HomePageUpload extends StatefulWidget {
  final MUser user;
  final MLoan loan;

  final DateTime now = new DateTime.now();

  HomePageUpload({Key key, this.user, this.loan}) : super(key: key);
  @override
  _HomePageUploadState createState() => _HomePageUploadState();
}

class _HomePageUploadState extends State<HomePageUpload> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  final picker = ImagePicker();
  File _photoFile;
  File _cmnd1File;
  File _cmnd2File;
  File _simFile;
  File _shk1File;
  File _shk2File;
  File _gplxFile;
  File _hdldFile;
  File _saokeFile1;
  File _saokeFile2;
  File _saokeFile3;

  DateTime month1, month2, month3;

  @override
  void initState() {
    super.initState();

    month1 = DateTime(widget.now.year, widget.now.month - 3, widget.now.day);
    month2 = DateTime(widget.now.year, widget.now.month - 2, widget.now.day);
    month3 = DateTime(widget.now.year, widget.now.month - 1, widget.now.day);

    checkHint('hintUpload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Tải Hồ Sơ"),
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
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _simFile = File(pickedFile.path);
                          widget.user.imageSIM = _simFile;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageSIM != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageSIM,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _simFile = File(pickedFile.path);
                                  widget.user.imageSIM = _simFile;
                                } else {
                                  log('No image selected.');
                                }
                              });
                            },
                          ),
                    title: Text("SIM chính chủ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _cmnd1File = File(pickedFile.path);
                          widget.user.imageCMND1 = _cmnd1File;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageCMND1 != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageCMND1,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _cmnd1File = File(pickedFile.path);
                                  widget.user.imageCMND1 = _cmnd1File;
                                } else {
                                  log('No image selected.');
                                }
                              });
                            },
                          ),
                    title: Text("CMND/CCCD (mặt trước)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _cmnd2File = File(pickedFile.path);
                          widget.user.imageCMND2 = _cmnd2File;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageCMND2 != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageCMND2,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _cmnd2File = File(pickedFile.path);
                                  widget.user.imageCMND2 = _cmnd2File;
                                } else {
                                  log('No image selected.');
                                }
                              });
                            },
                          ),
                    title: Text("CMND/CCCD (mặt sau)",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _hdldFile = File(pickedFile.path);
                          widget.user.imageHDLD = _hdldFile;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageHDLD != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageHDLD,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _hdldFile = File(pickedFile.path);
                                  widget.user.imageHDLD = _hdldFile;
                                } else {
                                  log('No image selected.');
                                }
                              });
                            },
                          ),
                    title: Text("Hợp đồng làm việc",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _saokeFile1 = File(pickedFile.path);
                          widget.user.imageSAOKE1 = _saokeFile1;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageSAOKE1 != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageSAOKE1,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _saokeFile1 = File(pickedFile.path);
                                  widget.user.imageSAOKE1 = _saokeFile1;
                                }
                              });
                            },
                          ),
                    title: Text("Sao kê tháng " + month1.month.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _saokeFile2 = File(pickedFile.path);
                          widget.user.imageSAOKE2 = _saokeFile2;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageSAOKE2 != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageSAOKE2,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _saokeFile2 = File(pickedFile.path);
                                  widget.user.imageSAOKE2 = _saokeFile2;
                                }
                              });
                            },
                          ),
                    title: Text("Sao kê tháng " + month2.month.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  _buildDivider(),
                  ListTile(
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);

                      setState(() {
                        if (pickedFile != null) {
                          _saokeFile3 = File(pickedFile.path);
                          widget.user.imageSAOKE3 = _saokeFile3;
                        } else {
                          log('No image selected.');
                        }
                      });
                    },
                    trailing: widget.user.imageSAOKE3 != null
                        ? IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogImage(
                                      file: widget.user.imageSAOKE3,
                                    );
                                  });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.add_photo_alternate,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _saokeFile3 = File(pickedFile.path);
                                  widget.user.imageSAOKE3 = _saokeFile3;
                                }
                              });
                            },
                          ),
                    title: Text("Sao kê tháng " + month3.month.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
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

  Divider _buildDivider() {
    return Divider(
      color: Colors.grey,
    );
  }

  void onButtonClicked() {
    // check condition

    if (widget.user.imageSIM == null ||
        widget.user.imageCMND1 == null ||
        widget.user.imageCMND2 == null ||
        widget.user.imageHDLD == null ||
        widget.user.imageSAOKE1 == null ||
        widget.user.imageSAOKE2 == null ||
        widget.user.imageSAOKE3 == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: 'Lỗi !',
              descriptions: 'Vui lòng tải lên tất cả các hồ sơ được yêu cầu.',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => HomePagePermission(
                    user: widget.user,
                    loan: widget.loan,
                  )));
    }
  }

  Future<void> showHint(String name) async {
    await Future.delayed(Duration(milliseconds: 500));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogHint(
            name: name,
            descriptions:
                'Bạn phải cung cấp ít nhất 5 giấy tờ có trong danh sách yêu cầu. Hình ảnh phải rõ nét và phải được chụp mới tại thời điểm đăng ký vay. Các giấy tờ chứng minh thu nhập như hợp đồng làm việc và Sao kê ngân hàng là bắt buộc. Mọi giấy tờ không hợp lệ hoặc đã qua chỉnh sửa sẽ bị từ chối.',
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
