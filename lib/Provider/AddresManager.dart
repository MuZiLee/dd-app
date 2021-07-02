

import 'package:one/Model/AddresModel.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:flutter/cupertino.dart';

/**
 * 收货地址管理
 */
class AddresManager extends ChangeNotifier {

  static AddresModel defaultAddres;

  static getAddreslist() async {
    var url = "addres/getAddreslist";
    SBResponse response = await SBRequest.post(url);
    print(response.data);
    List addres = [];
    response.data.map((json) {
      AddresModel model =AddresModel.fromJson(json);
      if (model.isDefault) {
        defaultAddres = model;
      }
      addres.add(model);
    }).toList();
    if (addres.length < 1) {
      defaultAddres = AddresModel(
        province: "",
        city: "",
        district: "",
        addres: "",
        phone: "",
        name: "",
        id: 0
      );
    }

    return addres;
  }

  static deleteAddres({int id}) async {
    var url = "addres/delete";
    var arguments = {
      "id": id
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  static addAddres(var arguments) async {
    var url = "addres/addAddres";

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 设置默认地址
   */
  static setAddresDefault(id) async{
    var url = "addres/setAddresDefault";
    SBResponse response = await SBRequest.post(url, arguments: {"id":id});
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

}