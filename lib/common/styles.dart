import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdb/common/pdb_screenutil.dart';



const kDBPrimaryColor = const Color(0xFF09B5F5);


const kShrineBrown900 = const Color(0xFF442B2D);

const kShrineErrorRed = const Color(0xFFC5032B);

const kYellow = const Color(0xFFFFC309);

const kDarkBlue = const Color(0xFF1E3970);

const kDBBackgroundGrey = const Color(0xFFEAEDEF);
const kDBBackgroundWhite = const Color(0xFFFFFFFF);
const sliverHeaderTextStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 14,
);
const titleHeadingTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const mainDescriptionTextStyle = const TextStyle(
  fontSize: 14.0,
  color: Colors.black,
);

const normalTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.black,
);

const normalBoldTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.black54,
  fontWeight: FontWeight.bold,
);
const largeBoldTextStyle = const TextStyle(
  fontSize: 14.0,
  color: Colors.black54,
  fontWeight: FontWeight.bold,
);

const newsTitleTextStyle = const TextStyle(
  fontSize: 13.0,
  color: Colors.black87,
);

const newsSubTitleTextStyle = const TextStyle(
  fontSize: 11.0,
  color: Colors.black45,
);

const drawerTitleTextStyle = const TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.bold,
  color: kDBPrimaryColor,
);
const drawerSubTitleTextStyle = const TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.normal,
  color: kDBPrimaryColor,
);

const mainDescriptionWhiteTextStyle = const TextStyle(
  fontSize: 14.0,
  color: Colors.white,
);

const normalWhiteTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);

const normalBoldWhiteTextStyle = const TextStyle(
  fontSize: 12.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const largeWhiteTextStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const largeTextStyle = const TextStyle(
  color: kDarkBlue,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const linkTitleTextStyle = const TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.normal,
  color: kDBPrimaryColor,
);

const titleBarTextStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

final buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
      Radius.circular(10)),
  border: Border.all(
    color: Colors.white,
    width: 2,
  ),
);

ThemeData buildDoingBusinessTheme(context) {
  final textTheme = Theme.of(context).textTheme;
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      brightness: Brightness.light,
      accentColor: kShrineBrown900,
      primaryColor: kDBPrimaryColor,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kDBPrimaryColor,
        textTheme: ButtonTextTheme.normal,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: kDBPrimaryColor,
        textTheme: GoogleFonts.oswaldTextTheme(textTheme),
      ),
      scaffoldBackgroundColor: kDBBackgroundGrey,
      cardColor: kDBBackgroundGrey,
      textSelectionColor: kDBPrimaryColor,
      errorColor: kShrineErrorRed,
      cardTheme: CardTheme.of(context).copyWith(
        elevation: 1.0,
      ),
      backgroundColor: kDBBackgroundGrey,
      textTheme: GoogleFonts.oswaldTextTheme(textTheme).copyWith(
        title: GoogleFonts.oswald(textStyle: textTheme.title,fontWeight: FontWeight.normal,),
        body1: GoogleFonts.oswald(textStyle: textTheme.body1,),
        body2: GoogleFonts.oswald(textStyle: textTheme.body2,),
        button: GoogleFonts.oswald(textStyle: textTheme.button,),
        caption: GoogleFonts.oswald(textStyle: textTheme.caption,),
        display1: GoogleFonts.oswald(textStyle: textTheme.display1,),
        display2: GoogleFonts.oswald(textStyle: textTheme.display2,),
        display3: GoogleFonts.oswald(textStyle: textTheme.display3,),
        display4: GoogleFonts.oswald(textStyle: textTheme.display4,),
        headline: GoogleFonts.oswald(textStyle: textTheme.headline,),
        overline: GoogleFonts.oswald(textStyle: textTheme.overline,),
        subhead: GoogleFonts.oswald(textStyle: textTheme.subhead,),
        subtitle: GoogleFonts.oswald(textStyle: textTheme.subtitle,),
      )
    // TODO: Add the text themes (103)
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}