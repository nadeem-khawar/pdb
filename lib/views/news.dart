import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/common/route_constants.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/news_model.dart';
import 'package:pdb/widgets/news_item.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/rounded_shadow.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  final String slug;
  final String newsRegion;
  News({this.slug, this.newsRegion});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AfterLayoutMixin<News> {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<NewsModel>(context, listen: false).getNews(widget.slug);
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    double headerHeight = MediaQuery.of(context).size.height * 0.2;
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
      floating: true,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
            title: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: top <= 80.0 ? 1.0 : 0.0,
                //opacity: 1.0,
                child: Text(
                  '${widget.newsRegion.toUpperCase()}',
                )),
            centerTitle: true,
            background: RoundedShadow(
              topLeftRadius: 0,
              topRightRadius: 0,
              bottomLeftRadius: 0,
              bottomRightRadius: 0,
              startColor: kDBPrimaryColor,
              endColor: kDBBackgroundGrey,
              padding: EdgeInsets.only(top: 80, bottom: 20),
              child: Center(child: Text('${widget.newsRegion.toUpperCase()}',style: Theme.of(context).textTheme.headline,),),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            _buildAppBar(context, statusBarHeight),
            SliverList(
              delegate: SliverChildListDelegate([
                ListenableProvider.value(
                  value: newsModel,
                  child: Consumer<NewsModel>(
                    builder: (context,model,_){
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
                      }else{
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
                      }
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
