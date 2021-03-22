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
        "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(0,
        "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(1, "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(0, "Tôi có cần đóng phí gì không?"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(
        1, "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(0, "' Information was hidden for personal reason !'"),
    Message(0, "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(0, "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(1,
        "' Information was hidden for personal reason !'"),
    Message(
        1,
        ' Information was hidden for personal reason !' +
            Constants.url_homepage +
            ' Information was hidden for personal reason !'),
    Message(0, ' Information was hidden for personal reason !'),
    Message(0, ' Information was hidden for personal reason !'),
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
              ' Information was hidden for personal reason !'));
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
