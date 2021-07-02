import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo2020/Views/card_settings/card_settings.dart';

class CardViewSeriesBottomSheet {
  CardViewSeriesBottomSheet(BuildContext context,
      {String prompt = "提示",
      String title = "title",
      String placeholder = "备注",
      TextAlign textAlign = TextAlign.left,
      ValueChanged<String> onCorrect}) {

    String text;
    final FocusNode focusNode = new FocusNode(skipTraversal: true);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CardViewSeriesHeader(
                            textAlign: textAlign,
                            title: title,
                            color: Colors.redAccent,
                          ),
                          CardViewSeriesTextView(
                            title: prompt,
                            focusNode: focusNode,
                            placeholder: placeholder,
                            color: Colors.grey[100],
                            valueChanged: (value) {
                              text = value;
                            },
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  elevation: 0.0,
                                  child: Text('提交',
                                      style: TextStyle(color: Colors.white)),
                                  color: Colors.blueAccent,
                                  onPressed: () => onCorrect(text),
                                ),
                                SizedBox(width: 32),
                                RaisedButton(
                                  elevation: 0.0,
                                  child: Text('返回'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              focusNode.unfocus();
            },
          );
        });
  }
}
