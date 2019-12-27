import 'package:flutter/material.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';

class PDBAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  PDBAppBar({Key key,this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _PDBAppBarState createState() => _PDBAppBarState();
}

class _PDBAppBarState extends State<PDBAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kDBPrimaryColor,
      title: Text(widget.title),

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_comment,color: Colors.white,),
          onPressed: (){Navigator.pushNamed(context, contactFeedbackRoute);},
        ),
      ],
    );
  }
}