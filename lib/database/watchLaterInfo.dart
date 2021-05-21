import 'dart:convert';

WatchLaterInfo watchLaterInfoFromJson(String str) => WatchLaterInfo.fromJson(json.decode(str));

String watchLaterInfoToJson(WatchLaterInfo data) => json.encode(data.toJson());

class WatchLaterInfo {
    WatchLaterInfo({
        this.watchLaterId,
        this.eventsTitle,
        this.points,
        this.location,
        this.organizer,
        this.watchLater,
        this.pointsType,
        this.eventsDetail,
        this.startDate,
        this.endDate,
        this.typeInt,
    });

    int watchLaterId;
    String eventsTitle;
    String eventsDetail;
    int points;
    String location;
    String organizer;
    String watchLater;
    String pointsType;
    String startDate;
    String endDate;
    int typeInt;
 

    factory WatchLaterInfo.fromJson(Map<String, dynamic> json) => WatchLaterInfo(
        watchLaterId: json["watchLaterId"],
        eventsTitle: json["eventsTitle"],
        points: json["points"],
        location: json["location"],
        organizer: json["organizer"],
        watchLater: json["watchLater"],
        pointsType: json["pointsType"],
        eventsDetail: json["eventsDetail"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        typeInt: json["typeInt"],

    );

    Map<String, dynamic> toJson() => {
        "watchLaterId": watchLaterId,
        "eventsTitle": eventsTitle,
        "points": points,
        "location": location,
        "organizer": organizer,
        "watchLater": watchLater,
        "pointsType": pointsType,
        "eventsDetail": eventsDetail,
        "startDate": startDate,
        "endDate": endDate,
        "typeInt": typeInt,
    };
}