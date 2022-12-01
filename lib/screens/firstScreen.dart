import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:news/screens/data.dart';
import 'package:news/api/api.dart';
import 'package:news/screens/secondScreen.dart';

late List<SourceObject> sources;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

TextStyle base(double fontSize) {
  return TextStyle(
      fontFamily: "Barlow-ExtraLight",
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: -1);
}

TextStyle mainLight(double fontSize) {
  return TextStyle(
      fontFamily: "Barlow-ExtraLight",
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.7);
}

TextStyle blueFont(double fontSize) {
  return TextStyle(
      fontFamily: "Barlow-ExtraLight",
      color: Color(0xFF007AFF),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.7);
}

TextStyle textStyleSecondary(double fontSize) {
  return TextStyle(
      fontFamily: "Barlow-ExtraLight",
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.7);
}

class _HomeState extends State<Home> {
  List options = ['USA'];

  List valuations = ['us'];

  List types = [
    'general',
    'entertainment',
    'business',
    'health',
    'science',
    'sports',
    'technology'
  ];

  int systemIndex = 0;
  int systemType = 0;

  String locale = "us";
  String category = "general";

  String demoImgURL =
      "https://wideeducation.org/wp-content/uploads/2022/06/IKEA.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NetworkSystem().sysInit(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data!.imgURL,
                    ),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 200.0),
                child: Column(
                  children: [
                    const SizedBox(height: 66),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "News",
                            style: TextStyle(
                              fontFamily: "Barlow-ExtraLight",
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.hardEdge,
                      width: (MediaQuery.of(context).size.width) - 50,
                      height: (MediaQuery.of(context).size.width) - 50,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data!.imgURL),
                            fit: BoxFit.cover),
                        shadows: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 30.0,
                              spreadRadius: 5,
                              offset: Offset(0, 6))
                        ],
                        color: Colors.grey.withOpacity(0.75),
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 18,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.only(
                            top: 0, right: 0, left: 0, bottom: 6),
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: -0.3,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(snapshot.data!.source,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ],
                          ),
                        ],
                      ).frosted(
                        blur: 20,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        frostColor: Colors.black.withOpacity(0.1),
                      ), /*Row (children: [
                              Text(snapshot.data!.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    letterSpacing: -0.5,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(snapshot.data!.source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 16)),
                            ],)*/
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 40,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          NetworkSystem().showSources();
                          showMaterialModalBottomSheet(
                            clipBehavior: Clip.hardEdge,
                            duration: Duration(milliseconds: 300),
                            backgroundColor: Color.fromARGB(0, 51, 63, 103),
                            context: context,
                            builder: (context) => Container(
                              clipBehavior: Clip.hardEdge,
                              height: MediaQuery.of(context).size.height - 55,
                              decoration: ShapeDecoration(
                                color: Color(0xFF1C1C1E),
                                shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 26,
                                    cornerSmoothing: 0.9,
                                  ),
                                ),
                              ),
                              child: sources(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("News Sources", style: textStyleSecondary(20)),
                            Icon(FeatherIcons.chevronRight,
                                size: 24, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox(width: 10)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 14,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Region",
                            style: base(18),
                          ),
                          SizedBox(
                            height: 38,
                            child: CupertinoButton(
                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  duration: Duration(milliseconds: 300),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                    height:
                                        (MediaQuery.of(context).size.height) *
                                            0.3,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF1C1C1E),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 26,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 20, right: 24, left: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                height: 20,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: blueFont(18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height) *
                                              0.2,
                                          child: CupertinoPicker(
                                            looping: true,
                                            itemExtent: 37.0,
                                            children: <Widget>[
                                              for (String each in options)
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Text(each,
                                                        style: mainLight(21)))
                                            ],
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                systemIndex = index;
                                                locale = valuations[index];
                                                print(locale);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      options[valuations.indexOf(locale)],
                                      style: base(18),
                                    ),
                                    Icon(
                                      FeatherIcons.chevronDown,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 14,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Topic",
                            style: base(18),
                          ),
                          SizedBox(
                            height: 38,
                            child: CupertinoButton(
                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  duration: Duration(milliseconds: 300),
                                  barrierColor: Colors.black.withOpacity(0.7),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                    height:
                                        (MediaQuery.of(context).size.height) *
                                            0.3,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF1D1D1E),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 26,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 20, left: 24, right: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                height: 20,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Done",
                                                    style: blueFont(18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height) *
                                              0.2,
                                          child: CupertinoPicker(
                                            looping: true,
                                            itemExtent: 37.0,
                                            children: <Widget>[
                                              for (String typex in types)
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Text(
                                                        typex.toCapitalized(),
                                                        style: mainLight(21)))
                                            ],
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                category = types[index];

                                                print(category);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      category.toCapitalized(),
                                      style: base(18),
                                    ),
                                    Icon(
                                      FeatherIcons.chevronDown,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    button("Go!", () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AppStream(category: category, locale: locale)));
                    }),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
                color: Color(0xFF111111),
                child: Center(
                    child: CupertinoActivityIndicator(
                  radius: 14,
                )));
          }
        },
      ),
    );
  }

  button(String text, dynamic tap) {
    return CupertinoButton(
      onPressed: tap,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 54,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        decoration: ShapeDecoration(
            color: Colors.black87,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.9,
              ),
            ),
            shadows: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 14.0,
                  spreadRadius: 1,
                  offset: Offset(0, 6))
            ]),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 3,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color(0xFF4D7EFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.7,
                    fontSize: 17),
              ),
              const SizedBox(
                width: 4,
              )
            ],
          ),
        ),
      ),
    );
  }

  sources() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 23, left: 21, right: 20, bottom: 20),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF333333), width: 1.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sources", style: mainLight(18)),
              SizedBox(
                height: 20,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: blueFont(18),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.94,
              height: 40,
              child: CupertinoSearchTextField(
                backgroundColor: Color(0xFF252525),
                borderRadius: BorderRadius.circular(11),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(
                    FeatherIcons.search,
                    color: Colors.grey.withOpacity(0.7),
                    size: 18,
                  ),
                ),
              )),
        ),
        FutureBuilder<List<SourceObject>>(
          future: NetworkSystem().showSources(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                  child: Center(
                      child: CupertinoActivityIndicator(
                color: Colors.white.withOpacity(0.7),
              )));
            } else {
              List<SourceObject> sources = snapshot.data!;
              return Expanded(
                child: Container(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      itemCount: sources.length,
                      itemBuilder: (context, index) =>
                          sourcePage(sources[index].name, sources[index].type),
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }

  sourcePage(String name, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: ShapeDecoration(
        color: Colors.grey.withOpacity(0.1),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12,
            cornerSmoothing: 0.9,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: base(16),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                text.toCapitalized(),
                style: textStyleSecondary(12),
              ),
            ],
          ),
          Container(
            width: 20,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    print(" ");
                  },
                  child: Icon(
                    FeatherIcons.chevronRight,
                    color: Colors.white.withOpacity(0.5),
                    size: 22,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
