import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class FileItem extends StatelessWidget {
  final String title;
  final String link;
  FileItem({this.title,this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 5, top: 5),
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ),

          ButtonBarTheme(
              data: ButtonBarThemeData(
                alignment: MainAxisAlignment.end,
              ),
              child: ButtonBar(
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
              )),
        ],
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
