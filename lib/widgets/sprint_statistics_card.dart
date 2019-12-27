import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/rounded_shadow.dart';

class SprintStatisticsCard extends StatefulWidget {
  final double nominalHeightClosed;
  final double nominalHeightOpen;
  final Function onTap;
  final bool isOpen;


  SprintStatisticsCard(
      {Key key,
      this.nominalHeightOpen,
      this.nominalHeightClosed,
      this.isOpen,
      this.onTap})
      : super(key: key);

  @override
  _SprintStatisticsCardState createState() => _SprintStatisticsCardState();
}

class _SprintStatisticsCardState extends State<SprintStatisticsCard> {

  bool _wasOpen = false;
  double _cardHeight;


  @override
  Widget build(BuildContext context) {
    _cardHeight =
    _wasOpen ? widget.nominalHeightOpen : widget.nominalHeightClosed;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        curve: _wasOpen ? Curves.easeOut : Curves.easeIn,
        duration: Duration(milliseconds: _wasOpen ? 500 : 700),
        height: _cardHeight,
        child: RoundedShadow(
          bottomRightRadius: 10,
          bottomLeftRadius: 10,
          endColor: kDBPrimaryColor,
          startColor: kDBPrimaryColor,
          topRightRadius: 10,
          topLeftRadius: 10,
          shadowColor: Color(0x20000000),
          child: Container(
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  _buildTopContent(),
                  SizedBox(height: 12),
                  AnimatedOpacity(
                    duration: Duration(
                        milliseconds: _wasOpen ? 600 : 600),
                    curve: Curves.easeOut,
                    opacity: _wasOpen ? 1 : 0,
                    //Bottom Content
                    child: _buildBottomContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildTopContent() {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.fitWidth,
          width: 50,
        ),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            'TEST',
          ),
        ),
      ],
    );
  }

  Column _buildBottomContent() {
    List<Widget> rowChildren = [];

    rowChildren.addAll([
      Text(
        "You're only ",
      ),
      Text(
        " 12 ",
      ),
      Text(
        " points away",
      ),
    ]);
    return Column(
      children: [
        //Body Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        SizedBox(height: 16),
        Text(
          "Redeem your points for a cup of happiness! Our signature espresso is blanced with steamed milk and topped with a light layer of foam. ",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        //Main Button
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: FlatButton(
            //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Text("REDEEM",),
          ),
        )
      ],
    );
  }

  void _handleTap() {
    setState(() {
      _wasOpen = !_wasOpen;
    });
    if (widget.onTap != null) {
      widget.onTap();
    }
  }
}
