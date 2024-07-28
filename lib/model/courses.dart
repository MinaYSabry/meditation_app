import 'package:meditation_app/model/sessionsData.dart';

class CourseData {
  String? title, description, duration;
  List<SessionsData>? allSessionsData;

  CourseData(
      {this.title, this.description, this.duration, this.allSessionsData});

  // List<SessionsData>? _createSessionsDataList(
  //     List<Map<String, dynamic>> sessionsMap) {
  //   print('_createSessionsDataList called');
  //   List<SessionsData>? temporarySessionsList = [];
  //   for (var singleSessionMap in sessionsMap) {
  //     SessionsData trialSessionData = SessionsData.fromJson(singleSessionMap);
  //     temporarySessionsList.add(trialSessionData);
  //   }
  //   return temporarySessionsList;
  // }

  CourseData.fromJson(
    Map<String, dynamic> json,
  ) {
    title = json["title"];
    description = json["description"];
    duration = json["duration"];
    allSessionsData = json['allSessionsData'];
  }
//

//
}
