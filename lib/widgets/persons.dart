import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/get_persons_bloc.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/person.dart';
import '../style/theme.dart' as Style;

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  @override
  void initState() {
    super.initState();
    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        utilityWidgets.buildTopTitle(
          title: "TRENDING PERSONS ON THIS WEEK",
          onTap: () {
            // Navigate to all list
          },
        ),
        StreamBuilder<PersonResponse>(
          stream: personsBloc.subject.stream,
          builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return utilityWidgets.buildErrorWidget(snapshot.data.error);
              }
              return _buildNowPlayingWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return utilityWidgets.buildErrorWidget(snapshot.error);
            } else {
              return utilityWidgets.buildLoadingWidget(130);
            }
          },
        )
      ],
    );
  }

  Widget _buildNowPlayingWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    if (persons.length == 0) {
      return Container(
        child: Text('No persons'),
      );
    } else
      return Container(
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
                    maxLines: 2,
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
