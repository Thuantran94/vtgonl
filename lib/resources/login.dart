import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:vtgonl/Animations/FadeAnimation.dart';
import 'package:vtgonl/global/loan.dart';
import 'package:vtgonl/global/noti.dart';
import 'package:vtgonl/widgets/loader.dart';
import 'package:vtgonl/widgets/mStyle.dart';

import 'package:vtgonl/validators/validation.dart';

import 'package:vtgonl/global/user.dart';

import 'package:vtgonl/global/constants.dart';
import 'home.dart';
import 'pSignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController phone_controller = new TextEditingController();
  TextEditingController otp_controller = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool _isCorrectPhone = true;

  List<MLoan> loans = new List<MLoan>();
  List<Noti> notis = new List<Noti>();
  MUser user = new MUser();
  User u;
  @override
  void initState() {
    super.initState();
    u = FirebaseAuth.instance.currentUser;
    if (u != null) {
      getUser(u.phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: WillPopScope(
        child: u != null
            ? Stack(children: <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    //child: ColorLoader(),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/background0.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "VTG ONLINE",
                              style: TextStyle(
                                  color: Constants.colorWhite,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 60),
                            child: Center(
                              child: Text(
                                "Đang tải...",
                                style: TextStyle(color: Constants.colorWhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])
            : Container(
                constraints: BoxConstraints.expand(),
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
                          Positioned(
                            left: 20,
                            width: 80,
                            height: 180,
                            child: FadeAnimation(
                                0.5,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-1.png'))),
                                )),
                          ),
                          Positioned(
                            left: 120,
                            width: 80,
                            height: 150,
                            child: FadeAnimation(
                                0.8,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            right: 30,
                            top: 30,
                            width: 80,
                            height: 120,
                            child: FadeAnimation(
                                1,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/clock.png'))),
                                )),
                          ),
                          Positioned(
                            child: FadeAnimation(
                                1.2,
                                Container(
                                  margin: EdgeInsets.only(top: 60),
                                  child: Center(
                                    child: Text(
                                      "VTG ONLINE",
                                      style: TextStyle(
                                          color: Constants.colorWhite,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ),
                          Positioned(
                            child: FadeAnimation(
                                1.2,
                                Container(
                                  margin: EdgeInsets.only(top: 120),
                                  child: Center(
                                    child: Text(
                                      " Luôn bên bạn vượt qua mọi khó khăn ",
                                      style: TextStyle(
                                          color: Constants.colorWhite,
                                          fontSize: 20,
                                          fontFamily: 'DancingScript'),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.5,
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: TextField(
                                            controller: phone_controller,
                                            maxLength: 10,
                                            cursorColor: Constants.colorPrimary,
                                            autofocus: true,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              counterText: '',
                                              labelText: "Số điện thoại",
                                              labelStyle: TextStyle(
                                                  color: _isCorrectPhone
                                                      ? Constants.colorPrimary
                                                      : Colors.red),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: _isCorrectPhone
                                                          ? Constants
                                                              .colorPrimary
                                                          : Colors.red),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide()),
                                            ))),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            1.8,
                            Container(
                                height: 48,
                                child: CustomButton(
                                  text: 'Đăng nhập',
                                  onPressed: () {
                                    onLoginClicked();
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                            1.8,
                            Container(
                              child: Text(
                                DateTime.now().year.toString() +
                                    ' \u00a9 VTG Online ',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
        onWillPop: () {
          return Future.value(false);
        },
      ),
    );
  }

  void onLoginClicked() {
    if (!Validation.isValidPhone(phone_controller.text)) {
      setState(() {
        _isCorrectPhone = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: 'Lỗi !',
              descriptions: 'Số điện thoại không chính xác',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else {
      setState(() {
        _isCorrectPhone = true;
      });
      checkLoginFirebaseWithPhoneNumber(phone_controller.text);
    }
  }

  void checkLoginFirebaseWithPhoneNumber(String phone) async {
    String vnPhone = '+84' + phone.substring(1, phone.length);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ColorLoader();
        });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: vnPhone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log('verificationCompleted');
        Navigator.of(context).pop();
        // Sign the user in (or link) with the auto-generated credential ANDROID ONLY!
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('verificationFailed: ' + e.code);
        Navigator.of(context).pop();
      },
      codeSent: (String verificationId, int resendToken) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogInput(
                title: 'Nhập OTP',
                text: 'Vui lòng nhập mã xác nhận đã được gửi đến SĐT ' +
                    phone_controller.text +
                    '.',
                controller: otp_controller,
                onPressed: () {
                  Navigator.of(context).pop();
                  signInWithPhoneNumber(verificationId);
                },
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void signInWithPhoneNumber(String verificationId) async {
    log('sign In With Phone Number...');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ColorLoader();
        });

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp_controller.text);

      final User user =
          (await auth.signInWithCredential(phoneAuthCredential)).user;

      String vnphone = '+84' + phone_controller.text.substring(1);
      await getUser(vnphone);
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              icon: Icons.error,
              iconColor: Colors.red,
              title: 'Đăng nhập thất bại !',
              descriptions: e.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
  }

  Future<void> getUser(String vnphone) async {
    log('getting user...' + vnphone);
    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_user)
        .child(vnphone)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = snapshot.value;

      if (snapshot.value == null) {
        log('go to register page...');
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => SignUpPage(
                      phone: phone_controller.text,
                    )));
      } else {
        user = MUser.fromJson(values);
        user.loans = await getLoan(user.phone);
        user.notis = await getNoti();
        log('go to home page...');

        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => HomePage(user: user)));
      }
    });
  }

  Future<List<MLoan>> getLoan(String phone) async {
    await FirebaseDatabase.instance
        .reference()
        .child(Constants.root_loan)
        .orderByChild('phone')
        .equalTo(phone)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        for (var value in snapshot.value.values) {
          MLoan loan = new MLoan.fromJson(value);
          loans.add(loan);
        }
      }
    });

    return loans;
  }

  Future<List<Noti>> getNoti() async {
    await FirebaseDatabase.instance
        .reference()
        .child("NOTI")
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        for (var value in snapshot.value.values) {
          Noti noti = new Noti.fromJson(value);
          notis.add(noti);
        }
      }
    });
    return notis;
  }
}
