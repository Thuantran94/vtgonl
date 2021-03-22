import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/global/user.dart';

class Chat extends StatefulWidget {
  final MUser user;
  Chat({Key key, @required this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String text;
  TextEditingController _controller;
  final List<String> avatars = [
    "assets/images/avatar.png",
    "assets/images/cskh.jpg",
  ];
  final List<Message> messages = [
    Message(1,
        "Nếu bạn vẫn muốn đăng ký vay thì phải thanh toán phí bảo hiểm trước giải ngân."),
    Message(1,
        "Rất tiết, VTG Online chỉ hỗ trợ cho những khách hàng có đủ hồ sơ và có chứng minh thu nhập"),
    Message(0,
        "Tôi không đủ hồ sơ, hoặc không thể chứng minh thu nhập thì vay được không?"),
    Message(1,
        "Ví dụ bạn vay 5 000 000 trong 1 tháng thì phí dịch vụ là 500 000đ sau khi giải ngân bạn sẽ nhận được 4 500 000đ."),
    Message(1, "Phí dịch vụ sẽ được trừ trực tiếp vào số tiền giải ngân."),
    Message(1,
        "Bạn không cần phải đóng bất kỳ một khoản phí nào trước khi nhận được tiền giải ngân."),
    Message(0, "Tôi có cần đóng phí gì không?"),
    Message(1,
        "Ví dụ bạn vay 5 000 000đ thì tháng sau tổng cộng tất cả tiền bạn phải trả là 5 400 000đ."),
    Message(
        1, "Lãi suất VTG Online quy định là 5% một tháng và 3% phí bảo hiểm."),
    Message(1,
        "Vì vậy bạn cần có số tài khoản ngân hàng chính chủ trước khi đăng ký vay"),
    Message(1,
        "VTG Online hỗ trợ cho khách hàng vay trả góp theo tháng, giải ngân và thanh toán tiền bằng hình thức chuyển khoản ngân hàng"),
    Message(0, "Lãi suất bao nhiêu?"),
    Message(0, "Tôi muốn hỏi hình thức vay như thế nào?"),
    Message(1,
        "Chào bạn, VTG Online có hỗ trợ nợ xấu nên nếu bạn có nợ xấu vẫn vay được."),
    Message(0, "Tôi bị nợ xấu có vay được không?"),
    Message(1,
        "Bạn có thể chứng minh thu nhập bằng cách cung cấp hợp đồng lao động và sao kê tài khoản ngân hàng 3 tháng gần nhất."),
    Message(1,
        "Ngoài ra VTG Online bắt buộc bạn phải có số điện thoại chính chủ và có chứng minh thu nhập."),
    Message(1,
        "Bạn cần chuẩn bị các giấy tờ tùy thân như chứng minh nhân dân và sổ hộ khẩu, các hóa đơn điện nước, internet nếu có"),
    Message(
        1,
        'Chào bạn, để đăng ký vay bạn có thể làm theo các bước hướng dẫn trong ứng dụng hoặc truy cập tại ' +
            Constants.url_homepage +
            ' để điền hồ sơ.'),
    Message(0, "Cần những giấy tờ gì?"),
    Message(0, "Tôi muốn vay thì phải làm thế nào?"),
  ];
  final rand = Random();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("CSKH"),
        actions: <Widget>[
          IconButton(
            color: Constants.colorWhite,
            icon: Icon(Icons.call),
            onPressed: () => UrlLauncher.launch('tel://0763133710'),
          ),
        ],
        backgroundColor: Constants.colorPrimary,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10.0);
              },
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                Message m = messages[index];
                if (m.user == 0) return _buildMessageRow(m, current: true);
                return _buildMessageRow(m, current: false);
              },
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Aa"),
              onEditingComplete: _send,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Constants.colorPrimary,
            onPressed: _send,
          )
        ],
      ),
    );
  }

  _send() async {
    if (_controller.text.isEmpty) return;

    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      messages.insert(0, Message(0, _controller.text));
      _controller.clear();
    });
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      messages.insert(0, Message(1, 'Xin chào ' + widget.user.name));
      messages.insert(
          0,
          Message(1,
              'Bạn vui lòng nhấn vào nút gọi phía trên hoặc liên hệ qua địa chỉ email bên dưới để được tư vấn hỗ trợ sớm nhất nhé!'));
      messages.insert(0, Message(1, 'Email: ' + Constants.email));
    });
  }

  Row _buildMessageRow(Message message, {bool current}) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        if (!current) ...[
          CircleAvatar(
            backgroundImage: AssetImage(avatars[1]),
            radius: 18.0,
          ),
          const SizedBox(width: 5.0),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
                color: current ? Constants.colorPrimary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              message.description,
              style: TextStyle(
                  color: current ? Constants.colorWhite : Constants.colorBack,
                  fontSize: 16.0),
            ),
          ),
        ),
        if (current) ...[
          const SizedBox(width: 5.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              widget.user.linkAVATAR,
              height: 16.0,
              width: 16.0,
            ),
          )
        ],
        SizedBox(width: current ? 20.0 : 30.0),
      ],
    );
  }
}

class Message {
  final int user;
  final String description;

  Message(this.user, this.description);
}
