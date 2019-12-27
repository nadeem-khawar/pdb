import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/view_models/news_model.dart';
import 'package:pdb/widgets/news_item.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
import 'package:pdb/widgets/placeholder/placehoder_list.dart';
import 'package:pdb/widgets/placeholder/placeholder_card_short.dart';
import 'package:pdb/widgets/view_title.dart';
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
    Provider.of<NewsModel>(context).getNews(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);

    return Scaffold(
      appBar: PDBAppBar(
        title: widget.newsRegion,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: ViewTitle(text: widget.newsRegion,)
            ),
            ListenableProvider.value(
              value: newsModel,
              child: Consumer<NewsModel>(
                builder: (context, value, _) {
                  if (value.busy == true) {
                    return Expanded(
                      child: PlaceHolderList(
                        itemCount: 10,
                        child: PlaceholderCardShort(
                          color: Color(0XFFACACAA),
                          backgroundColor: Color(0XFFDEDEDC),
                          height: 100,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.news.length,
                        itemBuilder: (ctx, index) {
                          final newsItem = value.news[index];

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
    );
  }
}
