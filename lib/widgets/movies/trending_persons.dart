import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/movies/get_trending_persons_bloc.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../model/person.dart';
import '../../style/theme.dart' as Style;
import 'trending_persons_list.dart';

class TrendingPersons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TrendingPersons() build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        utilityWidgets.buildTopTitle(
          title: "TRENDING PEOPLE",
          onTap: () {
            // Navigate to all list
          },
        ),
        TrendingPersonsList(),
      ],
    );
  }
}
