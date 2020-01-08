import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class NewsItem extends StatelessWidget {
  final String title;
  final DateTime newsDate;
  final String link;
  NewsItem({this.title, this.newsDate, this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0,top: 5,right: 0,left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat('d MMM yyyy').format(newsDate),
                  style: Theme.of(context).textTheme.subtitle,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  buttonPadding: EdgeInsets.all(0),
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        if (link.isEmpty == false) {
                          Share.share('$title $link');
                        }
                      },
                      icon: Icon(Icons.share),
                      label: Text('Share'),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        if (link.isEmpty == false) {
                          _launchURL(link);
                        }
                      },
                      icon: Icon(Icons.link),
                      label: Text('Read'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  var launcher = UrlLauncherPlatform.instance;
  if (await launcher.canLaunch(url)) {
    if (Platform.isIOS) {
      await launcher.launch(url,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: const <String, String>{});
    } else if (Platform.isAndroid) {
      await launcher.launch(url,
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: true,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: const <String, String>{});
    }
  } else {
    throw 'Could not launch $url';
  }
}