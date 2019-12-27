

import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';

class PlaceHolderList extends StatelessWidget {
  final int itemCount;
  final Widget child;
  PlaceHolderList({this.itemCount,this.child});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount+1,
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: index == 0? LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kDBPrimaryColor),
            ) : child,
          );
        }
    );
  }
}
