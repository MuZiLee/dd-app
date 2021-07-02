import 'package:one/Model/Resume.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:nav_router/nav_router.dart';

class ResumeManager {
  static get() async {
    var url = "resumes/get";
    SBResponse response = await SBRequest.post(url);
    if (response.code == 0) {
      Resume resume = Resume.fromJson(response.data);
      return resume;
    } else {
      return null;
    }
  }

  static saveBasicInformation(
      {String origin,
      int marriage,
      String nation,
      String education,
      String speciality,
      String sos_name,
      String sos_phone}) async {
    var url = "resumes/saveBasicInformation";
    var arguments = {
      "origin": origin,
      "marriage": marriage,
      "nation": nation,
      "education": education,
      "speciality": speciality,
      "sos_name": sos_name,
      "sos_phone": sos_phone
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showLongToast(response.msg);
    if (response.code == 0) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  static delBasicInformation({int id}) async {
    var url = "resumes/delBasicInformation";
    var arguments = {"id": id};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  static saveResumeEducationalExperience(
      {String education,
      String school,
      String major,
      String graduation_time}) async {
    var url = "resumes/saveResumeEducationalExperience";
    var arguments = {
      "education": education,
      "school": school,
      "major": major,
      "graduation_time": graduation_time
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showLongToast(response.msg);
    if (response.code == 0) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  static delResumeEducationalExperience({int id}) async {
    var url = "resumes/delResumeEducationalExperience";
    var arguments = {"id": id};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  static saveResumeWorkExperience(
      {String company_name,
      String company_address,
      String company_phone,
      String company_job,
      String work_time,
      String dimission_time,
      String work_content}) async {
    var url = "resumes/saveResumeWorkExperience";
    var arguments = {
      "company_name": company_name,
      "company_address": company_address,
      "company_phone": company_phone,
      "company_job": company_job,
      "work_time": work_time,
      "dimission_time": dimission_time,
      "work_content": work_content
    };
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    ZKCommonUtils.showLongToast(response.msg);
    if (response.code == 0) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  static delResumeWorkExperience({int id}) async {
    var url = "resumes/delResumeWorkExperience";
    var arguments = {"id": id};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response.code == 0) {
      return true;
    } else {
      return false;
    }
  }
}
