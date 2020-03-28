import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/movies/get_trending_persons_bloc.dart';
import 'package:flutterappmovie/model/person.dart';
import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../style/theme.dart' as Style;

class TrendingPersonsByTime extends StatefulWidget {
  final String personTime;
  TrendingPersonsByTime({Key key, @required this.personTime}) : super(key: key);
  @override
  _PersonByTimeState createState() => _PersonByTimeState();
}

class _PersonByTimeState extends State<TrendingPersonsByTime> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingPersonsBloc..getPersons(widget.personTime);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PersonResponse>(
      stream: trendingPersonsBloc.subject.stream,
      builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return utilityWidgets.buildErrorWidget(snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return utilityWidgets.buildErrorWidget(snapshot.error);
        } else {
          return utilityWidgets.buildLoadingWidget(130);
        }
      },
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
                    maxLines: 1,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
