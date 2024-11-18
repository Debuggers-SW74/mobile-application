class UserNotification {
  int? id;
  String? timestamp;
  String? type;
  bool? seen;
  int? userId;
  int? tripId;

  UserNotification(
      {this.id,
        this.timestamp,
        this.type,
        this.seen,
        this.userId,
        this.tripId});

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json['id'],
      timestamp: json['timestamp'],
      type: json['type'],
      seen: json['seen'],
      userId: json['userId'],
      tripId: json['tripId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'type': type,
      'seen': seen,
      'userId': userId,
      'tripId': tripId,
    };
  }
}
