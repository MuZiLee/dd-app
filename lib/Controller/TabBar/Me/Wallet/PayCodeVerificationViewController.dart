
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// 支付密码
class PayCodeVerificationViewController extends StatefulWidget {
  static const routeName = "/me/mywallet/paycodeverification";

  Widget viewController;
  PayCodeVerificationViewController(this.viewController);

  @override
  _PayCodeVerificationViewControllerState createState() => _PayCodeVerificationViewControllerState();
}

class _PayCodeVerificationViewControllerState extends State<PayCodeVerificationViewController> {

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          subtitle: TextStyle(color: Colors.black38),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '支付密码',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "请输入支付密码，以验证身份",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 6,
                    obsecureText: true,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Colors.grey,
                    borderWidth: 1.0,
                    animationDuration: Duration(milliseconds: 100),
                    borderRadius: BorderRadius.circular(5),
                    backgroundColor: Colors.white,
                    fieldWidth: MediaQuery.of(context).size.width * 0.135,
                    fieldHeight: MediaQuery.of(context).size.width * 0.15,
                    controller: textEditingController,
                    onCompleted: (v) {
                      routePush(widget.viewController).then((value) {
                        pop();
                      });
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*请把所有的格子都填满" : "",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      // conditions for validating
                      if (currentText.length != 6) {
                        setState(() {
                          hasError = true;
                        });
                      }
                    },
                    child: Center(
                        child: Text(
                          "验证".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.deepOrange.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

}
