import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtgonl/global/constants.dart';

class Contact extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thông Tin Liên Hệ"),
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
              margin: EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Giới thiệu VTG Online",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text(
                      "VTG là một trong những nền tảng vay vốn trực tuyến #1 Việt Nam. Đồng hành cùng chúng tôi, bạn sẽ có cơ hội tìm kiếm cho mình các khoản vay tốt nhất, dịch vụ hỗ trợ tốt nhất với lãi suất vô cùng hấp dẫn. VTG sử dụng nền tảng công nghệ 4.0, duyệt hồ sơ tự động giúp việc giải quyết các khó khăn về tài chính của bạn trở nên nhanh chóng, thuận tiện và an toàn.",
                      style: TextStyle(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tổng đài chăm sóc khách hàng",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Icon(Icons.phone, color: Colors.green),
                          Text(
                            "  1900 94 09 04",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Icon(Icons.access_time_rounded, color: Colors.green),
                          Text(
                            "   08:00 – 18:00, Thứ Hai – Thứ Bảy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.green),
                          Text(
                            "   hotrovtgonline@gmail.com",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Kết nối với chúng tôi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          InkWell(
                            child: Image.asset(
                              "assets/images/facebook1.png",
                              fit: BoxFit.cover,
                            ),
                            onTap: () async {
                              const url = Constants.url_facebook;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: Image.asset(
                              "assets/images/zalo1.png",
                              fit: BoxFit.cover,
                            ),
                            onTap: () async {
                              const url = Constants.url_zalo;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
