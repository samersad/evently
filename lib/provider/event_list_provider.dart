import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';
import '../utils/flutter_toast.dart';
class EventListProvider extends ChangeNotifier{
  //data
  List<Event> eventsList=[];
  List<Event> filterEventsList=[]; //empty
  List<String>  eventNameList=[];
  List<Event> eventsFavoriteList=[];
  List<Event> eventsSearchList=[];
  int selectedIndex=0;

  List<String> getEventNameList( BuildContext context ){
    return eventNameList=[
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }
  Future<void> getAllEvent(String uId) async {
    //get all events in List
    QuerySnapshot<Event> querySnapshot= await FireBaseUtils.getEventCollections(uId).get();
    eventsList= querySnapshot.docs.map((doc) {
      return doc.data();
    }, ).toList();
    filterEventsList=eventsList;  //all events
    //to do sorting events
    filterEventsList.sort((event1, event2) {
      return event1.eventDateTime!.compareTo(event2.eventDateTime!);
    },);
    notifyListeners();
  }
  void getFilterEvents(String uId)async{
    var querySnapshot =await FireBaseUtils.getEventCollections( uId).get();
    eventsList= querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    filterEventsList= eventsList.where((event) {
      return event.eventName==eventNameList[selectedIndex];
    },).toList();
    filterEventsList.sort((event1, event2) {
      return event1.eventDateTime!.compareTo(event2.eventDateTime!);
    },);
    notifyListeners();
  }

  Future<void> getFilterFromFireStore(String uId) async {
    var querySnapshot= await FireBaseUtils.getEventCollections(uId).
    orderBy("event_date_time").
    where("event_name",isEqualTo: eventNameList[selectedIndex]).get();
    filterEventsList = querySnapshot.docs.map((doc) {
      return  doc.data();
    },).toList();
    notifyListeners();
  }
  void changeSelectedIndex(int newSelectedIndex,String uId){
    selectedIndex=newSelectedIndex;
    selectedIndex == 0? getAllEvent( uId) : getFilterEvents(uId);
  }

  Future<void> updateIsFavoriteEvent(Event event,String uId) async {
    await FireBaseUtils.getEventCollections( uId).doc(event.id)
        .update({"is_favorite":!event.isFavorite!}).then((value) {
      FlutterToast.showToastMes(msg: "event updated successfully",
          backgroundColor: AppColors.greenColor, textColor: AppColors.whiteColor);
        },);
    getAllFavoriteEvents( uId);

    selectedIndex == 0? getAllEvent( uId) : getFilterEvents( uId);
    notifyListeners();
  }
  Future<void> getAllFavoriteEvents(String uId) async {
    var querySnapshot=await FireBaseUtils.getEventCollections( uId).get();
    eventsList=querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    eventsFavoriteList= eventsList.where((event) {
      return  event.isFavorite==true;
    },).toList();
    eventsFavoriteList.sort((a, b) {
      return a.eventDateTime!.compareTo(b.eventDateTime!);
    },);
    notifyListeners();
  }
  Future<void> getAllFavoriteEventsFromFirebase(String uId) async {
    var querySnapshot=await FireBaseUtils.getEventCollections( uId)
        .orderBy("event_date_time")
        .where("is_favorite",isEqualTo: true)
        .get();
    eventsFavoriteList=querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();

    notifyListeners();
  }


  Future<void> deleteEvent(String eventId,String uId) async {
    await FireBaseUtils.getEventCollections( uId).doc(eventId).delete().then((value) {
      FlutterToast.showToastMes(msg: "event updated successfully",
          backgroundColor: AppColors.greenColor, textColor: AppColors.whiteColor);
    },);

    eventsList.removeWhere((event) => event.id == eventId);
    filterEventsList.removeWhere((event) => event.id == eventId);
    eventsFavoriteList.removeWhere((event) => event.id == eventId);

    notifyListeners();

  }

  Future<void> updateEventInFirestore(Event event,String uId) async {
    FireBaseUtils.getEventCollections( uId).doc(event.id)
        .update(event.toFireStore()).then((value) {
      FlutterToast.showToastMes(msg: "event updated successfully", backgroundColor: AppColors.greenColor, textColor: AppColors.whiteColor);

    },);
    notifyListeners();

  }

}