import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model/event.dart';

class FireBaseUtils{
  static CollectionReference<Event> getEventCollections() {
    return  FirebaseFirestore.instance.collection(Event.collectionName)
      .withConverter<Event>(
    fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
    toFirestore: (event, _) => event.toFireStore(),
  );}
  static Future<void> addEventToFirestore(Event event){
    //todo create collection
    CollectionReference<Event> collectionRef=getEventCollections();
    //todo create doc
    var docRef=  collectionRef.doc();
    event.id= docRef.id; //auto id
    return
      docRef.set(event); //todo save date
  }

  //todo firebase => json
  //todo [] => json array  , {} => json object
  //todo developers =>object

  // todo json=> object
  // todo object => json
}