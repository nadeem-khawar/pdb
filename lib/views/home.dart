import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdb/common/navigation_args.dart';
import 'package:pdb/common/pdb_screenutil.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/home_model.dart';
import 'package:pdb/widgets/news_item.dart';
import 'package:pdb/widgets/pdb_drawer.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/rounded_shadow.dart';
import 'package:provider/provider.dart';
import 'package:pdb/common/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    double headerHeight = MediaQuery.of(context).size.height * 0.3;
    var top = 0.0;
    return SliverAppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_comment,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, contactRoute);
          },
        ),
      ],
      elevation: 0,
      expandedHeight: headerHeight,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
            title: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: top <= 120.0 ? 1.0 : 0.0,
                //opacity: 1.0,
                child: Text(
                  'PAKISTAN DOING BUSINESS',
                )),
            centerTitle: true,
            background: RoundedShadow(
              topLeftRadius: 0,
              topRightRadius: 0,
              bottomLeftRadius: 0,
              bottomRightRadius: 0,
              startColor: kDBPrimaryColor,
              endColor: kDBBackgroundGrey,
              padding: EdgeInsets.only(top: 80,bottom: 20),
              child: Image.asset(
                kLogoImage,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Constant.setScreenAwareConstant(context);
    //ScreenUtil().setSp(24, allowFontScalingSelf: true);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final homeModel = Provider.of<HomeModel>(context);
    homeModel.getNews();
    return Scaffold(
      drawer: PDBDrawer(),
      body: SafeArea(
          top: false,
          bottom: true,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildAppBar(context, statusBarHeight),
              SliverToBoxAdapter(
                child: Padding(
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
                                    .copyWith(
                                        color: Colors.white, fontSize: 18),
                              ),
                              color: kDBPrimaryColor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 40.0),
                            )),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'REFORM TOPICS',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
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
                                  reformTopicId:
                                      homeModel.reformTopics[index].id,
                                  reformTopicName:
                                      homeModel.reformTopics[index].name,
                                  logo:
                                      homeModel.reformTopics[index].reformLogo,
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
              ),
              SliverToBoxAdapter(
                child: Text(
                  'LATEST NEWS',
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListenableProvider.value(
                      value: homeModel,
                      child: Consumer<HomeModel>(
                        builder: (context, model, _) {
                          if (model.busy) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(11, (i) {
                                if (i == 0) {
                                  return LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kDBPrimaryColor),
                                  );
                                }
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: PlaceholderCardShort(
                                    color: Color(0XFFACACAA),
                                    backgroundColor: Color(0XFFDEDEDC),
                                    height: 100,
                                  ),
                                );
                              }),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(model.news.length, (i) {
                              final newsItem = model.news[i];
                              return NewsItem(
                                title: newsItem.title,
                                newsDate: newsItem.newsDate,
                                link: newsItem.linksInContent.length == 0
                                    ? newsItem.externalLink
                                    : newsItem.linksInContent[0],
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}