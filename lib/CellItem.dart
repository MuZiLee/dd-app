
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Apply/ApplyRolesViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Apply/RolesSelectViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Audit/AuditMutableViewController2.dart';
import 'package:demo2020/Controller/TabBar/Me/BoundInvitationCode/BoundInvitationCodeViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/FactoryHR/FactoryHRViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Favorites/FavoritesViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyExpect/MyExpectAdvancedViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyQRCode.dart';
import 'package:demo2020/Controller/TabBar/Me/MyResume/BasicInformation/BasicInformationViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyResume/EducationExperience/EducationExperienceViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyResume/MyResumeViewControlle.dart';
import 'package:demo2020/Controller/TabBar/Me/MyResume/WorkExperience/WorkExperienceViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/AdvancedDividend/AdvancedDividendViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/EnterpriseCommission/AdvancedEnterpriseCommissionViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/EnterpriseCommission/EnterpriseCommissionViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/MyAdvanced/MyAdvancedViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/MyPrimary/MyPrimaryViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/MyProspectiveWorker/MyProspectiveWorkerViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/MyWorker/MyWorkerViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/PartnerViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/StrategicDividend/StrategicDividendViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Salesman/SalesmanViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/TeacherViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Wallet/MyWalletViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/AdvancePayments/AdvancePaymentsViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/HistoryNode/HistoryNodeViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/Leave/LeaveViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/MyPaySlip/MyPaySlipViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/Quit/QuitViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/Reimbursement/ReimbursementViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/SalaryBudget/SalaryBudgetViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/WorkerServer/WorkerServerViewController.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'Controller/TabBar/Me/Apply/ApplyHistoryViewController.dart';
import 'Controller/TabBar/Me/Partner/EnterpriseCommission/StrategicEnterpriseCommissionViewController.dart';
import 'Controller/TabBar/Me/Partner/EnterpriseCommission/TeacherEnterpriseCommissionViewController.dart';
import 'TouchCallback.dart';

class CellItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final double width;
  final double height;
  Icon icon;
  final VoidCallback onPressed;
  final bool isShowAdd;
  String phone;

  CellItem(
      {Key key,
      this.imagePath,
      this.width = 32.0,
      this.height = 32.0,
      @required this.title,
      this.subtitle = "",
      this.icon,
      this.onPressed,
      this.isShowAdd = true,
      this.phone})
      : super(key: key) {
    if (this.phone == null) {
      this.phone = Account.user.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TouchCallBack(
      onPressed: () async {
        print(this.title);
        if (this.onPressed != null) {
          this.onPressed();
        }
        switch (title) {
          case '??????':
            routePush(MyWalletViewController()).then((value) {
              Account.getUserInfo();
            });
            break;


          case '??????':
            routePush(FavoritesViewController());
            break;
          case '??????':
            routePush(MyResumeViewControlle(this.isShowAdd, phone: this.phone));
            break;
          case '????????????':
            routePush(BasicInformationViewController(this.isShowAdd, phone: this.phone,));
            break;
          case '????????????':
            routePush(EducationExperienceViewController(this.isShowAdd, phone: this.phone));
            break;
          case '????????????':
            routePush(WorkExperienceViewController(this.isShowAdd, phone: this.phone));
            break;
          case '???????????????':
            routePush(BoundInvitationCodeViewController()).then((value) async{
              await Account.getUserInfo();
            });
            break;



          case '???????????????':
            // ????????????
            if (IM.isLogin == false) {
              ZKCommonUtils.showToast("????????????,???????????????");
              return;
            }
            routePush(ConversationViewController(Account.user.partner.user.phone));
            break;
          case '????????????':
            routePush(ApplyHistoryViewController());
            break;
          case '???????????????':
            routePush(RolesSelectViewController()).then((value) {
              Account.getUserInfo();
            });
            break;
          case '?????????????????????':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '?????????????????????':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '??????????????????':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '???????????????':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;



          case '?????????':
            routePush(WorkerServerViewController());
            break;
          case '????????????':
            routePush(SalaryBudgetViewController());
            break;
          case '????????????':
            routePush(HistoryNodeViewController());
            break;
          case '??????':
            routePush(LeaveViewController());
            break;
          case '??????':
            routePush(ReimbursementViewController());
            break;
          case '??????':
            routePush(QuitViewController());
            break;
          case '???????????????':
            routePush(MyPaySlipViewController());
            break;





          case '???????????????':
            routePush(PartnerViewController()).then((value) {
              Account.getUserInfo();
            });
            break;
            //??????
          case '????????????':
            routePush(AuditMutableViewController2());
            break;
          case '????????????':
            routePush(MyWorkerViewController());
            break;
          case '???????????????':
            routePush(MyProspectiveWorkerViewController());
            break;

            // ?????? or ?????????
          case '?????????????????????':
            routePush(MyPrimaryViewController());
            break;
          case '????????????':
            routePush(AdvancedEnterpriseCommissionViewController());
            break;
            //??????
          case '?????????????????????':
            routePush(MyAdvancedViewController());
            break;
          case '????????????????????????':
            routePush(MyExpectAdvancedViewController());
            break;
          case '??????????????????':
            routePush(StrategicEnterpriseCommissionViewController());
            break;
          case '???????????????':
            routePush(MyQRCode());
            break;




          case '????????????':
            routePush(TeacherViewController());
            break;

          case '??????????????????':
            routePush(TeacherEnterpriseCommissionViewController(rid: Account.user.id,));
            break;

          case '??????HR??????':
            routePush(FactoryHRViewController());
            break;

          case '???????????????':
            routePush(SalesmanViewController());
            break;





        }
      },
      child: Container(
        height: 48.0,
        child: Row(
          children: <Widget>[
            Container(
              child: imagePath.contains("http") ?
              SBImage(url: imagePath, width: width, height: height) :
              Image.asset(imagePath, width: width, height: height),
              margin: const EdgeInsets.only(left: 22.0, right: 20.0),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14.0, color: Color(0xFF353535)),
            ),
            Expanded(child: Text(subtitle, textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 14.0),)),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
