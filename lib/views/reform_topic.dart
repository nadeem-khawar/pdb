import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/reform_topic_model.dart';
import 'package:pdb/widgets/file_item.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_overall_summary.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:sticky_headers/sticky_headers.dart';
class ReformTopic extends StatefulWidget {
  final int reformTopicId;
  final String reformTopicName;
  final String slug;
  final String logo;
  ReformTopic({this.reformTopicId,this.reformTopicName,this.slug,this.logo });
  @override
  _ReformTopicState createState() => _ReformTopicState();
}

class _ReformTopicState extends State<ReformTopic> with AfterLayoutMixin<ReformTopic> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformTopicModel>(context,listen: false).getReformStatisticsByIndicator(widget.reformTopicId, widget.slug, widget.reformTopicName);
  }

  @override
  Widget build(BuildContext context) {
    final reformTopicModel = Provider.of<ReformTopicModel>(context);
    return Scaffold(
      appBar: PDBAppBar(title: 'REFORM TOPIC',),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListenableProvider.value(
              value: reformTopicModel,
              child: Consumer<ReformTopicModel>(
                builder: (context,model,_){
                  return ReformOverallSummary(
                    titleText: widget.reformTopicName,
                    isLoading: model.busy? true:false,
                    delayed: model.busy? 0: model.reformStatistics.reformData.delayed,
                    inProgress: model.busy? 0: model.reformStatistics.reformData.inProgress,
                    completed: model.busy? 0: model.reformStatistics.reformData.completed,
                    total: model.busy? 0: model.reformStatistics.reformData.totalReforms,
                    logo: widget.logo,
                    reformTopicId: widget.reformTopicId,
                  );
                },
              ),
            ),
            Expanded(
              child: ListenableProvider.value(
                value: reformTopicModel,
                child: Consumer<ReformTopicModel>(
                  builder: (context, model, _) {
                    if (model.busy) {
                      return PlaceHolderList(
                        itemCount: 10,
                        child: PlaceholderCardShort(
                          color: Color(0XFFACACAA),
                          backgroundColor: Color(0XFFDEDEDC),
                          height: 100,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: model.files == null
                              ? 0
                              : model.files.length,
                          itemBuilder: (context, index) {
                            return StickyHeader(
                              header: Container(
                                color: kDBPrimaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(model.files.keys.elementAt(index),
                                  style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                                ),
                              ),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: model.files.values.elementAt(index)
                                    .map(
                                        (item) => FileItem(title: item.title,link:  item.linksInContent == null
                                            ? item.externalLink
                                            : item.linksInContent[0],)
                                )
                                    .toList(),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
