import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtgonl/global/user.dart';
import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/widgets/mStyle.dart';

class Loans extends StatefulWidget {
  final MUser user;
  Loans({Key key, @required this.user}) : super(key: key);

  @override
  _LoansState createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for (var loan in widget.user.loans)
    log(widget.user.loans.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thông Tin Hợp Đồng"),
        backgroundColor: Constants.colorPrimary,
      ),
      body: Column(
        children: <Widget>[
          Stack(
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
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            dense: true,
            title: Text(
              ' Information was hidden for personal reason !',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: widget.user.loans == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          for (var loan in widget.user.loans)
                            CustomCard(
                              shd: loan.shd,
                              sotien: loan.sotien + 'đ',
                              thoihan: loan.thoihan,
                              status: loan.trangthai,
                              ngaytao: loan.ngaytao,
                              onPressed: () {
                                String text;
                                IconData icon;
                                Color color;
                                switch (loan.trangthai) {
                                  case 'pending':
                                    text = 'Hợp đồng đang được phê duyệt !';
                                    icon = Icons.info;
                                    color = Colors.deepOrange;
                                    break;
                                  case 'actived':
                                    text = 'Hợp đồng đang có hiệu lực.';
                                    icon = Icons.check;
                                    color = Colors.green;
                                    break;
                                  case 'refused':
                                    text = 'Hợp đồng đã bị từ chối vì lý do ' +
                                        loan.ghichu +
                                        '.';
                                    icon = Icons.cancel;
                                    color = Colors.red;
                                    break;
                                  case 'finished':
                                    text = 'Hợp đồng đã được kết thúc.';
                                    icon = Icons.check;
                                    color = Colors.grey;
                                    break;
                                  default:
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                          icon: icon,
                                          iconColor: color,
                                          onPressedLeft: () async {
                                            String url = Constants.url_home +
                                                '/contract.html?shd=' +
                                                loan.shd;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          textLeft: 'XEM',
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          title: 'SHD ' + loan.shd,
                                          descriptions: text);
                                    });
                              },
                            ),
                          SizedBox(height: 30)
                        ]))),
          ),
        ],
      ),
    );
  }
}
