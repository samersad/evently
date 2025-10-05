import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model/event.dart';

class FireBaseUtils{
  static Future<void> addEventToFirestore(Event event){
    //todo create collection
    final eventsRef = FirebaseFirestore.instance.collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, _) => event.toFireStore(),
    );
    //todo create doc
    var docReference=  eventsRef.doc();
    event.id= docReference.id; //auto id
    return
      docReference.set(event); //todo save date
  }

  //todo firebase => json
  //todo [] => json array  , {} => json object
  //todo developers =>object

  // todo json=> object
  // todo object => json
}