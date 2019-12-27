import 'package:flutter/material.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';

class PDBDrawer extends StatelessWidget {

  Padding _navigationLink(String linkTitle,BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 10),
      child: Text(
        linkTitle,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: ScrollPhysics(),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: kDBBackgroundGrey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Image.asset('assets/logo.png'),
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: Text(
              'MEDIA',
              style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),
            ),
            children: <Widget>[
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Pakistan News',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'news-pakboi',
                          title: 'Pakistan News',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Sindh News',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'news-sindh',
                          title: 'Sindh News',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Punjab News',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'ews-punjab',
                          title: 'Punjab News',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Social Media',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'social',
                          title: 'Social Media',
                        ));
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: Text('NOTIFICATIONS & MINUTES',
              style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),),
            children: <Widget>[
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Federal Circulars & Meeting Minutes',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'circular_fed',
                          title: 'Federal Circulars & Meeting Minutes',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Sindh Circulars & Meeting Minutes',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'circular_sindh',
                          title: 'Sindh Circulars & Meeting Minutes',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Punjab Circulars & Meeting Minutes',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'circular_punjab',
                          title: 'Punjab Circulars & Meeting Minutes',
                        ));
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: Text(
              'REFORM KNOWLEDGE',
              style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),
            ),
            children: <Widget>[
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Federal',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'pres_federal',
                          title: 'Federal',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Sindh',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'pres_sindh',
                          title: 'Sindh',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Punjab',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'pres_punjab',
                          title: 'Punjab',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Sprints',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'pres-sprint',
                          title: 'Sprints',
                        ));
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('Methodology',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, newsRoute,
                        arguments: NewsArgs(
                          slug: 'pres-method',
                          title: 'Methodology',
                        ));
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: Text('REGISTRATION', style: Theme.of(context).textTheme.title.copyWith(color: kDBPrimaryColor),),
            children: <Widget>[
              Container(
                width: double.infinity,
                child: InkWell(
                  child: _navigationLink('REGISTRATION',context),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      registrationRoute,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}