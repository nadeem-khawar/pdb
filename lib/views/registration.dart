import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/view_models/registration_model.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>
    with AfterLayoutMixin<Registration> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<RegistrationModel>(context).fetchRegistrationInfo();
  }

  @override
  Widget build(BuildContext context) {
    final RegistrationModel registrationModel =
        Provider.of<RegistrationModel>(context);
    return Scaffold(
      appBar: PDBAppBar(
        title: 'REGISTRATION',
      ),
      body: SafeArea(
        child: ListenableProvider<RegistrationModel>.value(
          value: registrationModel,
          child: Consumer<RegistrationModel>(
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
                    itemCount: model.registrations.length,
                    itemBuilder: (context, index) {
                      return StickyHeader(
                        header: Container(
                          color: kDBPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model.registrations[index].heading,
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children:
                          model.registrations[index].linkItems
                              .map((item) => Card(
                            margin: EdgeInsets.all(8),
                            elevation: 1,
                            child: ListTile(
                              leading: Icon(FontAwesomeIcons.link,color: kDBPrimaryColor,size: 18,),
                              title: Text(item.link,),
                              onTap: () {
                                //_launchURL(data.text);
                              },
                            ),
                          ),)
                              .toList(),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
