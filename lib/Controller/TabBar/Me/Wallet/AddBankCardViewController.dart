import 'package:demo2020/Model/BankModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/WalletManager.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesRight.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/ThemeButton.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/card_settings/widgets/card_settings_panel.dart';
import 'package:demo2020/Views/card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';

/// 添加银行卡
class AddBankCardViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/addbankcard";

  @override
  _AddBankCardViewControllerState createState() =>
      _AddBankCardViewControllerState();
}

class _AddBankCardViewControllerState extends State<AddBankCardViewController> {
  BankModel bank;
  String username;
  String cardNumber;

  @override
  Widget build(BuildContext context) {


    List childs = [];

    childs.add(CardViewSeriesRight(
      title: "开户行名称",
      isNotNull: true,
      subtitle: bank != null ? bank.title : "",
      onTap: () async{


        List banklist = await WalletManager.getBanklist();

        CardShowActionSheetController(
          context,
          title: "添加银行卡",
          subtitle: "请选择支持的银行卡",
          actions: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: CardRefresherListView(
                itemCount: banklist.length,
                itemBuilder: (_, index) {

                  BankModel _bank = banklist[index];

                  return CupertinoActionSheetAction(
                    child: Text(_bank.title, style: TextStyle(fontSize: 13)),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        bank = _bank;
                      });
                    },
                  );

                },
              ),
            )
          ],
        );
      },
    ));


    childs.add(CardViewSeriesText(
      title: "持卡人",
      isNotNull: true,
//            subtitle: Account.user.username,
      placeholder: "持卡人姓名",
      onChanged: (value) {
        username = value;
      },
    ));

    childs.add(    CardViewSeriesNumber(
      title: "卡号",
      isNotNull: true,
      autofocus: true,
      placeholder: "",
      onChanged: (value) => cardNumber = value,
      onSubmitted: (value) => cardNumber = value,
    ));


    childs.add(SizedBox(height: 68));

    childs.add(    ThemeButton(
        "下一步",
        onPressed: () async{

          if (bank == null) {
            ZKCommonUtils.showToast("请选择开户行");
            return;
          }
          if (cardNumber == null) {
            ZKCommonUtils.showToast("请输入卡号");
            return;
          }
          BankValidateModel validate = await WalletManager.validateBankCardInfo(cardNo: cardNumber);

          //{messages: [{errorCodes: CARD_BIN_NOT_MATCH, name: cardNo}], validated: false, stat: ok, key: 622260026000107244}
          if (validate.validated == true) {
            await WalletManager.addCard(number: cardNumber, bid:bank.id, name:username);
            ZKCommonUtils.showToast("添加完成");
            pop();
          } else {
            ZKCommonUtils.showToast("卡号与开户行不一致");
          }

        }));


    return BaseScaffold(
      title: "添加银行卡",
      child: ListView.builder(
        itemBuilder: (context, index) {

          return childs[index];

        },
        itemCount: childs.length,
      ),



//         ],
//       ),
    );
  }
}
