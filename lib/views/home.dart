import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/home_model.dart';
import 'package:pdb/widgets/news_item.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/pdb_drawer.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/rounded_shadow.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<HomeModel>(context).getNews();
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.20;

    final homeModel = Provider.of<HomeModel>(context);

    return Scaffold(
      appBar: PDBAppBar(
        title: '',
      ),
      drawer: PDBDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: headerHeight,
              child: RoundedShadow(
                topLeftRadius: 0,
                topRightRadius: 0,
                bottomLeftRadius: 20,
                bottomRightRadius: 20,
                startColor: kDBPrimaryColor,
                endColor: kDBBackgroundGrey,
                shadowColor: Color(0x0).withAlpha(65),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/logo.png'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Pakistan Doing Business',
                              softWrap: true,
                              style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              'Better Business Regulation in Pakistan',
                              softWrap: true,
                              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        child: FlatButton.icon(
                          onPressed: () {
                            {
                              Navigator.pushNamed(context, reformPlanRoute);
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          label: Text(
                            'REFORM PLANS',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                          color: kDBPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 40.0),
                        )),
                  )),
            ),
            Text(
              'REFORM TOPICS',
              style: Theme.of(context).textTheme.headline,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeModel.reformTopics.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, reformTopicRoute,
                            arguments: ReformTopicArguments(
                              reformTopicId: homeModel.reformTopics[index].id,
                              reformTopicName:
                                  homeModel.reformTopics[index].name,
                              logo: homeModel.reformTopics[index].reformLogo,
                              slug: homeModel.reformTopics[index].slug,
                            ));
                      },
                      child: RoundedShadow(
                        topLeftRadius: 8,
                        topRightRadius: 8,
                        bottomLeftRadius: 8,
                        bottomRightRadius: 8,
                        startColor: kDBPrimaryColor,
                        endColor: kDBPrimaryColor,
                        shadowColor: Color(0x0).withAlpha(65),
                        child: Container(
                          width: 140,
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/reformtopics/${homeModel.reformTopics[index].reformLogo}',
                                fit: BoxFit.fill,
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                homeModel.reformTopics[index].name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              'LATEST NEWS',
              style: Theme.of(context).textTheme.headline,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ListenableProvider.value(
                value: homeModel,
                child: Consumer<HomeModel>(
                  builder: (context, value, _) {
                    if (value.busy == true) {
                      return PlaceHolderList(
                        itemCount: 5,
                        child: PlaceholderCardShort(
                          color: Color(0XFFACACAA),
                          backgroundColor: Color(0XFFDEDEDC),
                          height: 100,
                        ),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: value.news.length,
                        itemBuilder: (context, index) {
                          final newsItem = value.news[index];
                          return NewsItem(
                            title: newsItem.title,
                            newsDate: newsItem.newsDate,
                            link: newsItem.linksInContent.length == 0
                                ? newsItem.externalLink
                                : newsItem.linksInContent[0],
                          );
                        });
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
