import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/reform_topic_action_model.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_action_item_card.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ReformTopicAction extends StatefulWidget {
  final int reformTopicId;
  ReformTopicAction({this.reformTopicId});
  @override
  _ReformTopicActionState createState() => _ReformTopicActionState();
}

class _ReformTopicActionState extends State<ReformTopicAction>
    with AfterLayoutMixin<ReformTopicAction> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformTopicActionModel>(context, listen: false)
        .fetchReformTopicActions(
      widget.reformTopicId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ReformTopicActionModel reformTopicActionModel =
        Provider.of<ReformTopicActionModel>(context);

    return Scaffold(
      appBar: PDBAppBar(
        title: 'Reform Topic Actions',
      ),
      body: SafeArea(
        child: ListenableProvider<ReformTopicActionModel>.value(
          value: reformTopicActionModel,
          child: Consumer<ReformTopicActionModel>(
            builder: (context,model,_){
              if (model.busy) {
                return PlaceHolderList(
                  itemCount: 10,
                  child: PlaceholderCardShort(
                    color: kDBPrimaryColor,
                    backgroundColor: Color(0XFFC0C0C0),
                    height: 100,
                  ),
                );
              }else{
                return ListView.builder(
                  itemCount: model.reformActionAgencies.length,
                  itemBuilder: (context, index){
                    return StickyHeader(
                      header: Container(
                        color: kDBPrimaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          model.reformActionAgencies[index].agency,
                          style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                        ),
                      ),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: model.reformActionAgencies[index].reformActions
                            .map(
                                (item) => ReformActionItemCard(actionName: item.actionName,status: item.status,)
                        )
                            .toList(),
                      ),
                    );
                  }
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
