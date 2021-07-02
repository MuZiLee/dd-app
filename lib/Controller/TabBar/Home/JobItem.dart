
import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Controller/TabBar/Home/Details/JobDetailsViewController.dart';
import 'package:one/Model/JobModel.dart';
import 'package:one/Views/SBImage.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class JobItem extends StatefulWidget {

  final JobModel job;
  JobItem({this.job});

  @override
  _JobItemState createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.job.toJson());
    return Container(
      child: InkWell(
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                buildJobInfo(),
                buildImage(),
              ],
            ),
          ),
        ),
        onTap: () {
          routePush(JobDetailsViewController(job: widget.job));
        },
      ),
    );
  }


  Container buildJobInfo() {

    return Container(
      child: Row(
        children: <Widget>[

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: AutoSizeText(
                        '${widget.job.job_name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                        minFontSize: 8,
                        maxLines: 1,
                        maxFontSize: 17,
                      ),
                    ),
                    widget.job.isHot == 1 ? Image.asset("images/jobing.png", width: 50.0, height: 14.0) : Container()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    buildLogo(),
                    Container(
                      child: AutoSizeText(
                        '${widget.job.factory.factory_name}',
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.right,
                        minFontSize: 8,
                        maxLines: 1,
                        maxFontSize: 17,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20.0,),
                    Expanded(
                      child: Container(
                        height: 20.0,
                        child: AutoSizeText(
                          '${widget.job.factory.addres}',
                          style: TextStyle(fontSize: 10.0),
                          textAlign: TextAlign.left,
                          minFontSize: 10,
                          maxLines: 2,
                          maxFontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: AutoSizeText(
                    '¥${widget.job.minimum_search_range}-${widget.job.maximum_salary_range}',
                    minFontSize: 8,
                    maxLines: 1,
                    maxFontSize: 17,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.0, color: Colors.deepOrange),
                  ),
                ),
                Container(
                  ///  TODO: 招聘人数
                  child: AutoSizeText(
                    '${widget.job.number_of_people_recruited}/${widget.job.number_of_recruiters}人',
                    style: TextStyle(fontSize: 10.0),
                    textAlign: TextAlign.right,
                    minFontSize: 10,
                    maxLines: 1,
                    maxFontSize: 17,
                  ),
                ),
                Container(
                  child: AutoSizeText(
                    '${widget.job.distance}',
                    style: TextStyle(fontSize: 10.0),
                    textAlign: TextAlign.right,
                    minFontSize: 10,
                    maxLines: 1,
                    maxFontSize: 17,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


  Container buildLogo() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        child: SizedBox(
          width: 20, height: 20,
          child: SBImage(
            url: widget.job.factory.logo,
          ),
        ),
      ),
    );
  }

  Container buildImage() {

    if (widget.job.factory.images.length > 0) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.job.factory.images.length > 0 ? widget.job.factory.images[0].url : ""), fit: BoxFit.cover),
        ),
        height: 120.0,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/Logo.png"), fit: BoxFit.fitHeight),
        ),
        height: 120.0,
      );

    }
  }

}
