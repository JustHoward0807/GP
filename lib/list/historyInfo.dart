import 'dart:convert';

HistoryInfo historyInfoFromJson(String str) => HistoryInfo.fromJson(json.decode(str));

String historyInfoToJson(HistoryInfo data) => json.encode(data.toJson());

class HistoryInfo {
    HistoryInfo({
        this.id,
        this.eventsTitle,
        this.points,
        this.location,
        this.organizer,
        this.currentTime,
        this.imagePath,
    });

    int id;
    String eventsTitle;
    String points;
    String location;
    String organizer;
    String currentTime;
    String imagePath;

    factory HistoryInfo.fromJson(Map<String, dynamic> json) => HistoryInfo(
        id: json["id"],
        eventsTitle: json["eventsTitle"],
        points: json["points"],
        location: json["location"],
        organizer: json["organizer"],
        currentTime: json["currentTime"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "eventsTitle": eventsTitle,
        "points": points,
        "location": location,
        "organizer": organizer,
        "currentTime": currentTime,
        "imagePath": imagePath,
    };
}