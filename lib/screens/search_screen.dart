import 'package:flutter/material.dart';
import 'package:flutterappmovie/widgets/c_search/movies_search_result.dart';
import 'package:flutterappmovie/widgets/c_search/people_search_result.dart';
import 'package:flutterappmovie/widgets/c_search/shows_search_result.dart';
import '../style/theme.dart' as Style;

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  var _isViewList = true;
  var _searchValue = '';
  final _textEditingController = TextEditingController();
  TabController _tabController;
  List<String> _searchTaps = ['Movies', 'TV Shows', 'People'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _searchTaps.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print('changing tap................');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: TextField(
            controller: _textEditingController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textInputAction: TextInputAction.search,
            cursorColor: Style.Colors.secondColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              hintStyle: TextStyle(
                color: Style.Colors.titleColor,
                fontSize: 18,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchValue = value;
              });
            },
            autofocus: true,
          ),
          actions: <Widget>[
            _searchValue != ''
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                        _searchValue = '';
                      });
                    },
                  )
                : Container(),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon:
                  _isViewList ? Icon(Icons.view_list) : Icon(Icons.view_column),
              onPressed: () {
                setState(() {
                  _isViewList = !_isViewList;
                });
              },
            ),
          ],
          bottom: PreferredSize(
            child: TabBar(
              controller: _tabController,
              indicatorColor: Style.Colors.secondColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              unselectedLabelColor: Style.Colors.titleColor,
              labelColor: Colors.white,
              isScrollable: true,
              tabs: _searchTaps.map((tap) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    tap,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
            preferredSize: Size.fromHeight(35),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _searchTaps.map((tap) {
            switch (tap) {
              case "Movies":
                return MoviesSearchResult(
                  searchValue: _searchValue,
                );
                break;
              case "TV Shows":
                return ShowsSearchResult(
                  searchValue: _searchValue,
                );
                break;
              case "People":
                return PeopleSearchResult(
                  searchValue: _searchValue,
                );
                break;
              default:
                return Container();
                break;
            }
          }).toList(),
        ),
      ),
    );
  }
}
