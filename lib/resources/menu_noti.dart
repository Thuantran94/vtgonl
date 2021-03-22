import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vtgonl/global/constants.dart';
import 'package:vtgonl/global/noti.dart';

class NOTI extends StatelessWidget {
  final List<Noti> notis;

  NOTI({Key key, this.notis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    createTile(Noti noti) => Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Text(
                            noti.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Html(
                        data: noti.content,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        );

    final liste = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: notis.reversed.map((book) => createTile(book)).toList(),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thông Báo"),
        backgroundColor: Constants.colorPrimary,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: liste,
          ),
        ],
      ),
    );
  }
}
