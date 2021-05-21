import 'dart:convert';

TrackingInfo trackingInfoFromJson(String str) => TrackingInfo.fromJson(json.decode(str));

String trackingInfoToJson(TrackingInfo data) => json.encode(data.toJson());

class TrackingInfo {
    TrackingInfo({
        this.trackingId,
        this.pointsType,
        this.currentPoints,
    });

    int trackingId;
    String pointsType;
    int currentPoints;

    factory TrackingInfo.fromJson(Map<String, dynamic> json) => TrackingInfo(
        trackingId: json["trackingId"],
        pointsType: json["pointsType"],
        currentPoints: json["currentPoints"],
    );

    Map<String, dynamic> toJson() => {
        "trackingId": trackingId,
        "pointsType": pointsType,
        "currentPoints": currentPoints,
    };
}
