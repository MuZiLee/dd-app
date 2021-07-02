
import 'package:one/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:one/Controller/TabBar/Me/Apply/ApplyRolesViewController.dart';
import 'package:one/Controller/TabBar/Me/Apply/RolesSelectViewController.dart';
import 'package:one/Controller/TabBar/Me/Audit/AuditMutableViewController2.dart';
import 'package:one/Controller/TabBar/Me/BoundInvitationCode/BoundInvitationCodeViewController.dart';
import 'package:one/Controller/TabBar/Me/FactoryHR/FactoryHRViewController.dart';
import 'package:one/Controller/TabBar/Me/Favorites/FavoritesViewController.dart';
import 'package:one/Controller/TabBar/Me/MyExpect/MyExpectAdvancedViewController.dart';
import 'package:one/Controller/TabBar/Me/MyQRCode.dart';
import 'package:one/Controller/TabBar/Me/MyResume/BasicInformation/BasicInformationViewController.dart';
import 'package:one/Controller/TabBar/Me/MyResume/EducationExperience/EducationExperienceViewController.dart';
import 'package:one/Controller/TabBar/Me/MyResume/MyResumeViewControlle.dart';
import 'package:one/Controller/TabBar/Me/MyResume/WorkExperience/WorkExperienceViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/AdvancedDividend/AdvancedDividendViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/EnterpriseCommission/EnterpriseCommissionViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/MyAdvanced/MyAdvancedViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/MyPrimary/MyPrimaryViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/MyProspectiveWorker/MyProspectiveWorkerViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/MyWorker/MyWorkerViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/PartnerViewController.dart';
import 'package:one/Controller/TabBar/Me/Partner/StrategicDividend/StrategicDividendViewController.dart';
import 'package:one/Controller/TabBar/Me/Salesman/SalesmanViewController.dart';
import 'package:one/Controller/TabBar/Me/Teacher/TeacherViewController.dart';
import 'package:one/Controller/TabBar/Me/Wallet/MyWalletViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/AdvancePayments/AdvancePaymentsViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/HistoryNode/HistoryNodeViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/Leave/LeaveViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/MyPaySlip/MyPaySlipViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/Quit/QuitViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/Reimbursement/ReimbursementViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/SalaryBudget/SalaryBudgetViewController.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/WorkerServerViewController.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'TouchCallback.dart';

class CellItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final double width;
  final double height;
  Icon icon;
  final VoidCallback onPressed;

  CellItem(
      {Key key,
      this.imagePath,
      this.width = 32.0,
      this.height = 32.0,
      @required this.title,
      this.subtitle = "",
      this.icon,
      this.onPressed})
      : super(key: key);

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
          case '钱包':
            routePush(MyWalletViewController()).then((value) {
              Account.getUserInfo();
            });
            break;


          case '收藏':
            routePush(FavoritesViewController());
            break;
          case '简历':
            routePush(MyResumeViewControlle());
            break;
          case '基本信息':
            routePush(BasicInformationViewController());
            break;
          case '教育经历':
            routePush(EducationExperienceViewController());
            break;
          case '工作经验':
            routePush(WorkExperienceViewController());
            break;
          case '绑定邀请码':
            routePush(BoundInvitationCodeViewController()).then((value) async{
              await Account.getUserInfo();
            });
            break;




          case '我的经纪人':
            // 进入会话
            if (IM.isLogin == false) {
              ZKCommonUtils.showToast("正在链接,请稍候再试");
              return;
            }
            routePush(ConversationViewController(Account.user.partner.user.phone));
            break;
          case '合伙人申请':
            routePush(RolesSelectViewController()).then((value) {
              Account.getUserInfo();
            });
            break;
          case '初级合伙人申请':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '高级合伙人申请':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '战略联盟申请':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;
          case '业务员申请':
            routePush(ApplyRolesViewController(appleByUsable: title));
            break;




          case '员工服务':
            routePush(WorkerServerViewController());
            break;
          case '工资预算':
            routePush(SalaryBudgetViewController());
            break;
          case '历史记录':
            routePush(HistoryNodeViewController());
            break;
          case '请假':
            routePush(LeaveViewController());
            break;
          case '报销':
            routePush(ReimbursementViewController());
            break;
          case '离职':
            routePush(QuitViewController());
            break;
          case '我的工资条':
            routePush(MyPaySlipViewController());
            break;





          case '合伙人服务':
            routePush(PartnerViewController()).then((value) {
              Account.getUserInfo();
            });
            break;
            //初级
          case '报名审核':
            routePush(AuditMutableViewController2());
            break;
          case '我的工人':
            routePush(MyWorkerViewController());
            break;
          case '我的准工人':
            routePush(MyProspectiveWorkerViewController());
            break;

            // 高级 or 准高级
          case '我的初级合伙人':
            routePush(MyPrimaryViewController());
            break;
          case '高级分红':
            routePush(AdvancedDividendViewController("高级分红"));
            break;
            //战略
          case '我的高级合伙人':
            routePush(MyAdvancedViewController());
            break;
          case '我的准高级合伙人':
            routePush(MyExpectAdvancedViewController());
            break;
          case '战略合伙分红':
            routePush(StrategicDividendViewController());
            break;
          case '我的邀请码':
            routePush(MyQRCode());
            break;




          case '驻场老师服务':
            routePush(TeacherViewController());
            break;

          case '工厂HR服务':
            routePush(FactoryHRViewController());
            break;

          case '业务员服务':
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