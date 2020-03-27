import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/shows/get_shows_byGrenre_bloc.dart';
import '../../model/genre.dart';
import '../../style/theme.dart' as Style;
import 'shows_by_genre.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  GenresList({
    Key key,
    @required this.genres,
  }) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  _GenresListState(this.genres);
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        showsByGenreBloc..drainStream();
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
      height: 307,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: AppBar(
                backgroundColor: Style.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Style.Colors.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Style.Colors.titleColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((genre) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 10, top: 0),
                      child: Text(
                        genre.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((genre) {
              return ShowsByGenre(genreId: genre.id);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
