

import 'package:one/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:one/Controller/TabBar/Me/Teacher/EditorAgentViewController.dart';
import 'package:one/Controller/TabBar/Me/Teacher/EditorEpfewViewController.dart';
import 'package:one/Controller/TabBar/Me/Teacher/EditorHourlyWorkerViewController.dart';
import 'package:one/Model/EventsPaySlipAgent.dart';
import 'package:one/Model/EventsPaySlipEpfew.dart';
import 'package:one/Model/EventsPaySlipHourlyWorker.dart';
import 'package:one/Model/FactoryStaff.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/FactoryManager.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Provider/PartnerManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 工厂员工
 */
class FactoryEmployeesViewController extends StatefulWidget {
  Teacher teacher;

  FactoryEmployeesViewController(this.teacher);

  @override
  _FactoryEmployeesViewControllerState createState() =>
      _FactoryEmployeesViewControllerState();
}

class _FactoryEmployeesViewControllerState
    extends State<FactoryEmployeesViewController> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List factoryEmploryeeslist = [];

  _onRefresh() async {
    factoryEmploryeeslist =
    await FactoryManager.getStaffInfolist(fid: widget.teacher.id);
    _refreshController.refreshFailed();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "工厂员工",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: factoryEmploryeeslist.length == 0 ? Error404View(text: widget.teacher.factory_name,) : CardRefresherListView(
          itemCount: factoryEmploryeeslist.length,
          itemBuilder: (_, index) {
            FactoryStaff staff = factoryEmploryeeslist[index];
            return Container(
              margin: EdgeInsets.all(5.0),
              child: Column(
                children: [_buildCent(context, staff), SizedBox(height: 10.0), Divider(height: 1.0)],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildCent(BuildContext context, FactoryStaff staff) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: Icon(staff.isSlip == 0 ? Icons.check_circle_outline : Icons.check_circle, color: staff.isSlip == 0 ? Colors.black : Colors.deepOrange),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  width: 38.0,
                  height: 38.0,
                  child: SBImage(
                      url: staff.user.avatar,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
                onTap: () async {
                  /// 进入会话
                  if (IM.isLogin == false) {
                    ZKCommonUtils.showToast("正在链接,请稍候再试");
                    return;
                  }
                  await IM.enterConversation(phone: staff.user.phone);
                  routePush(ConversationViewController(staff.user.phone));
                },
              )
            ],
          ),
        ),
        Expanded(
          child: InkWell(
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(staff.user.username, style: TextStyle(fontSize: 13)),
                        Text("${staff.factory.factory_name}",
                            style: TextStyle(fontSize: 12)),
                        Text("职位:${staff.job.job_name}",
                            style: TextStyle(fontSize: 12)),
                        Text("入职时间:${staff.create_time}",
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            onTap: () async{

              if (widget.teacher.sigingInformation.cooperation_mode.contains("小时工")) {
                EventsPaySlipHourlyWorker hourlyWorker = EventsPaySlipHourlyWorker();
                hourlyWorker.staff = staff;
                hourlyWorker.status = staff.isSlip;
                hourlyWorker.uid = staff.uid;
                hourlyWorker.teacher = widget.teacher;
                // 签单价
                hourlyWorker.sign_unit_price = staff.sigingInformation.signed_unit_price.toString();
                // 员工单价
                hourlyWorker.employee_unit_price = staff.sigingInformation.employee_unit_price.toString();
                //总工时
                staff.punchIn.map((event) {
                  hourlyWorker.total_working_hours = (event.hour + double.parse(hourlyWorker.total_working_hours)).toString();
                }).toList();

                //保险费
                hourlyWorker.insurance = staff.sigingInformation.insurance_premium.toString();
                // 借款 loan
                hourlyWorker.loan = staff.advance?.cost != null ? staff.advance.cost : "0.0";
                //税费
                hourlyWorker.taxes = staff.sigingInformation.income_tax.toString();
                //管理费
                hourlyWorker.management_fee = staff.sigingInformation.management_expense.toString();
                //总工时
                hourlyWorker.total_working_hours;
                // 驻场老师提成
                hourlyWorker.resident_teacher_commission = staff.sigingInformation.commission_for_teacher.toString();
                //业务员提成
                hourlyWorker.salesperson_commission = staff.sigingInformation.commission_for_salesman.toString();
                //初级分红
                hourlyWorker.primary_dividend;
                //高级分红
                hourlyWorker.advanced_dividend;
                //战略分红
                hourlyWorker.strategic_dividend;
                //蛋蛋分红
                hourlyWorker.dividend;
                //实发工资
                hourlyWorker.actual_salary;

                routePush(EditorHourlyWorkerViewController(hourlyWorker: hourlyWorker)).then((value) {
                  _onRefresh();
                });
              }

              if (widget.teacher.sigingInformation.cooperation_mode.contains("同工同酬")) {


                EventsPaySlipEpfew epfew = EventsPaySlipEpfew();
                epfew.staff = staff;
                epfew.uid = staff.uid;
                epfew.teacher = widget.teacher;
                // 签单价
                epfew.sign_unit_price = staff.sigingInformation.signed_unit_price.toString();
                // 员工单价
                epfew.employee_unit_price = staff.sigingInformation.employee_unit_price.toString();

                // 借款 loan
                epfew.loan = staff.advance?.cost != null ? staff.advance.cost : "0.0";
                //税费
                epfew.taxes = staff.sigingInformation.income_tax.toString();
                //管理费
                epfew.management_fee = staff.sigingInformation.management_expense.toString();

                // 驻场老师提成
                epfew.resident_teacher_commission = staff.sigingInformation.commission_for_teacher.toString();
                //业务员提成
                epfew.salesperson_commission = staff.sigingInformation.commission_for_salesman.toString();
//                //初级分红
//                epfew.primary_dividend;
//                //高级分红
//                epfew.advanced_dividend;
//                //战略分红
//                epfew.strategic_dividend;
//                //蛋蛋分红
//                epfew.dividend;
//                //实发工资
//                epfew.actual_salary;

                routePush(EditorEpfewViewController(epfew: epfew)).then((value) {
                  _onRefresh();
                });
              }

              if (widget.teacher.sigingInformation.cooperation_mode.contains("代理招聘")) {
                EventsPaySlipAgent agent = EventsPaySlipAgent();
                agent.staff = staff;
                agent.uid = staff.uid;
                agent.teacher = widget.teacher;
                // 签单价
                agent.sign_unit_price = staff.sigingInformation.signed_unit_price.toString();

                //税费
                agent.taxes = staff.sigingInformation.income_tax.toString();
                //管理费
                agent.management_fee = staff.sigingInformation.management_expense.toString();

                // 驻场老师提成
                agent.resident_teacher_commission = staff.sigingInformation.commission_for_teacher.toString();
                //业务员提成
                agent.salesperson_commission = staff.sigingInformation.commission_for_salesman.toString();
                //初级分红
                agent.primary_dividend;
                //高级分红
                agent.advanced_dividend;
                //战略分红
                agent.strategic_dividend;
                //蛋蛋分红
                agent.dividend;

                routePush(EditorAgentViewController(agent: agent)).then((value) {
                  _onRefresh();
                });
              }


            },
          ),
        ),

      ],
    );
  }




}
