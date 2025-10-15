import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planningapp/model/my_user.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model/event.dart';

class FireBaseUtils{
  static CollectionReference<Event> getEventCollections(String uId) {
    return  getUsersCollections().doc(uId).collection(Event.collectionName)
      .withConverter<Event>(
    fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
    toFirestore: (event, _) => event.toFireStore(),
  );}
  static Future<void> addEventToFirestore(Event event,String uId){
    //todo create collection
    CollectionReference<Event> collectionRef=getEventCollections( uId);
    //todo create doc
    var docRef=  collectionRef.doc();
    event.id= docRef.id; //auto id
    return
      docRef.set(event); //todo save date
  }

  static CollectionReference<MyUser> getUsersCollections() {
    return  FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, _) => MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (myUser, _) => myUser.toFireStore(),
    );}
  static Future<void> addUserToFirestore(MyUser myUser){
   return getUsersCollections().doc(myUser.id).set(myUser);
  }
  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot= await getUsersCollections().doc(id).get();
    return querySnapshot.data();
  }




//todo firebase => json
  //todo [] => json array  , {} => json object
  //todo developers =>object

  // todo json=> object
  // todo object => json
}