
import 'package:demo2020/Controller/TabBar/Chat/TouchCallBack.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherSliverList.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
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
                                hintText:'??????',border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          width: 68,
                          margin: EdgeInsets.all(5),
                          child: RaisedButton(
                            color: Colors.white,
                            child: Text("??????", style: TextStyle(color: Colors.deepOrange)),
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
                              _onTap(_user, index);
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

  _onTap(User user, index) async {

    CardShowActionSheetController(
      context,
      title: "????????????",
      subtitle: "?????????TA?????????????",
      actions: [
        CupertinoActionSheetAction(
            child: Text('????????????', style: TextStyle(fontSize: 14)),
            onPressed: () async{

              await IM.addFriend(phone:user.phone);
              await Account.addFriend(tuid: user.id, fuid: Account.user.id);
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