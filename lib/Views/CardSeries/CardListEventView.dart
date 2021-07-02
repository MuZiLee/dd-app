import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

/// 事件View
class CardListEventView {
  int indexPath = 0;
  static int defaultIndexPath = 0;

  CardListEventView(
    BuildContext context, {
    List<String> data,
    ValueChanged onTapValue,
    ValueChanged onTapIndex,
    int defaultSelect,
  }) {
    if (data == null) {
      data = ["全部"];
    }
    if (defaultSelect != null) {
      defaultIndexPath = defaultSelect;
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Color(0xFFE8E8E8),
        builder: (con) {
          return Column(
            children: <Widget>[
              Container(
                height: 48,
                color: Colors.white,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("选择类型", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: GridView.custom(
                      primary: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 1.0,
                          crossAxisCount: 3, //横轴三个子widget
                          childAspectRatio: 1.5 //宽高比为1时，子widget
                          ),
                      childrenDelegate: SliverChildListDelegate(
                        List.generate(data.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: InkWell(
                              child: Card(
                                color: defaultIndexPath == index ? Colors.green : Color(0xFFE8E8E8),
                                child: Center(
                                    child: Text(
                                  data[index],
                                  style: TextStyle(color: defaultIndexPath == index ? Colors.white : Colors.black, fontSize: 13),
                                )),
                              ),
                              onTap: () {
                                indexPath = index;
                                defaultIndexPath = index;
                                if (onTapValue != null) {
                                  onTapValue(data[index]);
                                }
                                if (onTapIndex != null) {
                                  onTapIndex(index);
                                }
                                Navigator.pop(context);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              InkWell(
                child: Container(
                  height: 48,
                  color: Colors.white,
                  child: Center(
                    child: Text("取消"),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
