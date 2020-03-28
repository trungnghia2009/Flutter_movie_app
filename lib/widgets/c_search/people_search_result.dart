import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/seach/get_shows_search_bloc.dart';
import 'package:flutterappmovie/model/person.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../style/theme.dart' as Style;
import '../utility_widgets.dart';

class PeopleSearchResult extends StatefulWidget {
  final String searchValue;
  PeopleSearchResult({this.searchValue});
  @override
  _PeopleSearchResultState createState() => _PeopleSearchResultState();
}

class _PeopleSearchResultState extends State<PeopleSearchResult> {
  var _isInit = true;
  var _isDidUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.searchValue != '' && _isInit) {
      searchPeopleBloc..drainStream();
      searchPeopleBloc..getPeople(widget.searchValue);
    }
    _isInit = false;
  }

  @override
  void didUpdateWidget(PeopleSearchResult oldWidget) {
    print('didUpdateWidget PeopleSearchResult()');
    super.didUpdateWidget(oldWidget);
    if (widget.searchValue != '' && _isDidUpdate) {
      searchPeopleBloc..drainStream();
      searchPeopleBloc..getPeople(widget.searchValue);
    }
    _isDidUpdate = true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.searchValue + " at PeopleSearchResult");
    return widget.searchValue == ''
        ? utilityWidgets.buildEmptySearchScreen()
        : StreamBuilder<PersonResponse>(
            stream: searchPeopleBloc.subject.stream,
            builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return utilityWidgets.buildErrorWidget(snapshot.data.error);
                }
                return _buildPeopleWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return utilityWidgets.buildErrorWidget(snapshot.error);
              } else {
                return utilityWidgets.buildLoadingWidget(130);
              }
            },
          );
  }

  Widget _buildPeopleWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    if (persons.length == 0) {
      return Container(
          color: Style.Colors.mainColor,
          child: Center(
            child: Text(
              'No People',
              style: TextStyle(fontSize: 20, color: Style.Colors.titleColor),
            ),
          ));
    } else
      return Container(
        color: Style.Colors.mainColor,
        height: 130,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          itemCount: persons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              padding: EdgeInsets.only(
                top: 5,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  persons[index].profileImg == null
                      ? Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.Colors.secondColor,
                          ),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "https://image.tmdb.org/t/p/w200" +
                                      persons[index].profileImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    persons[index].name,
                    maxLines: 1,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Trending for ${persons[index].know}',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 7,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
  }
}
