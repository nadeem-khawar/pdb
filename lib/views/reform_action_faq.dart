import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/reform_action_faq_model.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:provider/provider.dart';

class ReformActionFaq extends StatefulWidget {
  final int reformId;
  ReformActionFaq({this.reformId});
  @override
  _ReformActionFaqState createState() => _ReformActionFaqState();
}

class _ReformActionFaqState extends State<ReformActionFaq>
    with AfterLayoutMixin<ReformActionFaq> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ReformActionFaqModel>(context, listen: false)
        .fetchReformTopicFaq(widget.reformId);
  }

  @override
  Widget build(BuildContext context) {
    final ReformActionFaqModel reformActionFaqModel =
        Provider.of<ReformActionFaqModel>(context);

    return Scaffold(
      appBar: PDBAppBar(
        title: 'FAQ\'s',
      ),
      body: SafeArea(
        child: ListenableProvider.value(
          value: reformActionFaqModel,
          child: Consumer<ReformActionFaqModel>(
            builder: (context, model, _) {
              if (model.busy) {
                return PlaceHolderList(
                  itemCount: 10,
                  child: PlaceholderCardShort(
                    color: kDBPrimaryColor,
                    backgroundColor: Color(0XFFC0C0C0),
                    height: 100,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: model.faqs.length,
                  itemBuilder: (context,index){
                    return Card(
                      margin: EdgeInsets.all(5),
                      elevation: 1,
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        title: Text(model.faqs[index].question,style: Theme.of(context).textTheme.title,),
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom:5.0,left: 5),
                            child: Text(model.faqs[index].answer,style: Theme.of(context).textTheme.subtitle,),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
    return Container();
  }
}
