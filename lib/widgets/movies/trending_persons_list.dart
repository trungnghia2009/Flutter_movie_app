import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/movies/get_trending_persons_bloc.dart';
import 'package:flutterappmovie/widgets/movies/trending_persons_by_time.dart';
import '../../model/person.dart';
import '../../style/theme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingPersonsList extends StatefulWidget {
  @override
  _TrendingPersonsListState createState() => _TrendingPersonsListState();
}

class _TrendingPersonsListState extends State<TrendingPersonsList>
    with SingleTickerProviderStateMixin {
  List<String> _personType = ['week', 'day'];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: _personType.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        trendingPersonsBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      child: DefaultTabController(
        length: _personType.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Style.Colors.secondColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              unselectedLabelColor: Style.Colors.titleColor,
              labelColor: Colors.white,
              isScrollable: true,
              tabs: _personType.map((time) {
                return Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    time.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 5),
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: _personType.map((time) {
                return TrendingPersonsByTime(personTime: time);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
