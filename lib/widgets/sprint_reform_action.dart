import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/sprint_reform_action_model.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/reform_item_card.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class SprintReformAction extends StatefulWidget {
  final int sprintNo;
  SprintReformAction({this.sprintNo});
  @override
  _SprintReformActionState createState() => _SprintReformActionState();
}

class _SprintReformActionState extends State<SprintReformAction>
    with
        AutomaticKeepAliveClientMixin<SprintReformAction>,
        AfterLayoutMixin<SprintReformAction> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<SprintReformActionModel>(context, listen: false)
        .fetchSprintReformActions(widget.sprintNo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final SprintReformActionModel sprintReformActionModel = Provider.of<SprintReformActionModel>(context, listen: false);

    return ListenableProvider.value(
      value: sprintReformActionModel,
      child: Consumer<SprintReformActionModel>(
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
                itemCount: model.sprintReformActions == null
                    ? 0
                    : model.sprintReformActions.length,
                itemBuilder: (context, index) {
                  return StickyHeader(
                    header: Container(
                      color: kDBPrimaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        model.sprintReformActions.keys.elementAt(index),
                        style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                      ),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: model.sprintReformActions.values
                          .elementAt(index)
                          .map(
                            (item) => ReformItemCard(actionName: item.actionName,status: item.status,agencyName: item.fullName,)
                          )
                          .toList(),
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
