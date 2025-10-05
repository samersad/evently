class Event{
  //todo collection
  static const String collectionName="event_name";
  //todo arr
    String? id;
    String? title;
    String? description;
    String? eventImage;
    String? eventName;
    DateTime? eventDateTime;
    String? eventTime;
    bool? isFavorite;

    Event({
      this.id='',
      required this.title,
      required this.description,
      required this.eventImage,
      required this.eventName,
      required this.eventDateTime,
      required this.eventTime,
      this.isFavorite=false,
});
    //todo json to object
    Event.fromFireStore(Map<String,dynamic> data):this(
      id:data["id"] ,
      title:data["title"] ,
      description:data["description"] ,
      eventName:data["event_name"] ,
      eventImage: data["event_image"],
      eventDateTime:DateTime.fromMillisecondsSinceEpoch(data["event_date_time"]),
      eventTime: data["event_time"],
      isFavorite: data["is_favorite"] as bool
    );

    //todo object to json
    Map<String,dynamic>toFireStore(){
  return {
    'id': id,
    'title': title,
    'description': description,
    'event_image': eventImage,
    'event_name': eventName,
    'event_date_time': eventDateTime?.millisecondsSinceEpoch,
    'is_favorite': isFavorite,
    'event_time': eventTime
  };
}


}
