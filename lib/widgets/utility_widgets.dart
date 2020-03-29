import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style/theme.dart' as Style;

final utilityWidgets = UtilityWidgets();

class UtilityWidgets {
  Widget buildLoadingWidget(double height) {
    print('Loading.....');
    return Container(
      color: Style.Colors.mainColor,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoadingSearchWidget() {
    print('Loading.....');
    return Container(
      padding: EdgeInsets.only(top: 100),
      color: Style.Colors.mainColor,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildErrorWidget(String error) {
    return Container(
      color: Style.Colors.mainColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Error occured: $error'),
          ],
        ),
      ),
    );
  }

  Widget buildTopTitle({String title, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: Style.Colors.titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_forward,
                color: Style.Colors.titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptySearchScreen(String title, String content) {
    return Container(
      color: Style.Colors.mainColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Icon(
            Icons.search,
            color: Style.Colors.titleColor,
            size: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Style.Colors.titleColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 18,
                color: Style.Colors.titleColor,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
