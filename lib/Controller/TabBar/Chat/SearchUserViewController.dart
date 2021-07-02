
import 'package:one/Controller/TabBar/Chat/TouchCallBack.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherSliverList.dart';
import 'package:one/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUserViewController extends StatefulWidget{
  static const routeName = "/caht/search";

  @override
  SearchUserViewControllerState createState() => new SearchUserViewControllerState();
}

class SearchUserViewControllerState extends State<SearchUserViewController> {

  FocusNode focusNode = new FocusNode();

  var keyword = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[

                  TouchCallBack(
                    isfeed: false,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.only(left: 15.0,right: 10.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),


                  Container(
                    alignment: Alignment.centerLeft,
                    height: 45.0,
                    padding: const EdgeInsets.only(left: 50.0,right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) {
                              keyword = value;
                              _onRefresh();
                            },
                            onSubmitted: (value) {
                              keyword = value;
                              _onRefresh();
                            },
                            decoration: InputDecoration(
                                hintText:'搜索',border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          width: 68,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text("搜索", style: TextStyle(color: Colors.deepOrange)),
                            onPressed: () {
                              focusNode.unfocus();
                              _onRefresh();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoScrollbar(
                  child: CardRefresher(
                    onRefresh: _onRefresh,
                    child: CardRefresherSliverList(
                        childCount: users.length,
                        builder: (_, index) {
                          User _user = users[index];
//                          print(_user.avatar);
                          return CardChatTableViewCell(
                            avatar: _user.avatar,
                            title: _user.username != null ? _user.username : "",
                            subTitle: _user.phone,
                            trailing: IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.deepOrange, size: 21),
                            ),
                            onTap: () {
                              _onTap(_user.phone, index);
                            },
                          );
                        }
                    ),
                  ),
                )
              )

            ],
          ),
        ),
      ),
    );
  }

  _onTap(phone, index) async {

    CardShowActionSheetController(
      context,
      title: "添加好友",
      subtitle: "您添加TA为好友吗?",
      actions: [
        CupertinoActionSheetAction(
            child: Text('申请好友', style: TextStyle(fontSize: 14)),
            onPressed: () async{

              await IM.addFriend(phone:phone);
              Navigator.pop(context);
            }),
      ]
    );
  }

  List<User> users = [];
  _onRefresh() async{
    users = await IM.searchKeyword(keyword);
//    print(users.length);
    setState(() {});
  }

}