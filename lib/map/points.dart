
class PointsCard {
  final String title;
  final String event;
  final String whatpoints;

  PointsCard(this.title, this.event, this.whatpoints);
}

class Locationnames {
  final String title;

  Locationnames({this.title});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
