class CurrentTime {
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? seconds;
  int? milliSeconds;
  String? dateTime;
  String? date;
  String? time;
  String? timeZone;
  String? dayOfWeek;
  bool? dstActive;

  CurrentTime(
      {this.year,
      this.month,
      this.day,
      this.hour,
      this.minute,
      this.seconds,
      this.milliSeconds,
      this.dateTime,
      this.date,
      this.time,
      this.timeZone,
      this.dayOfWeek,
      this.dstActive});

  CurrentTime.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    seconds = json['seconds'];
    milliSeconds = json['milliSeconds'];
    dateTime = json['dateTime'];
    date = json['date'];
    time = json['time'];
    timeZone = json['timeZone'];
    dayOfWeek = json['dayOfWeek'];
    dstActive = json['dstActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['seconds'] = this.seconds;
    data['milliSeconds'] = this.milliSeconds;
    data['dateTime'] = this.dateTime;
    data['date'] = this.date;
    data['time'] = this.time;
    data['timeZone'] = this.timeZone;
    data['dayOfWeek'] = this.dayOfWeek;
    data['dstActive'] = this.dstActive;
    return data;
  }
}
