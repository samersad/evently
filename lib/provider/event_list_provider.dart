import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../l10n/app_localizations.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier{
  //data
  List<Event> eventsList=[];
  List<Event> filterEventsList=[]; //empty
  List<String>  eventNameList=[];
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
// pty
  Future<void> getAllEvent() async {
    //get all events
    QuerySnapshot<Event> querySnapshot= await FireBaseUtils.getEventCollections().get();
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
  void getFilterEvents()async{
  var querySnapshot =await FireBaseUtils.getEventCollections().get();
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

  Future<void> getFilterFromFireStore() async {
    var querySnapshot= await FireBaseUtils.getEventCollections().
    orderBy("event_date_time").
    where("event_name",isEqualTo: eventNameList[selectedIndex]).get();
    filterEventsList = querySnapshot.docs.map((doc) {
     return  doc.data();
    },).toList();
    notifyListeners();
  }
  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex=newSelectedIndex;
    selectedIndex == 0? getAllEvent() : getFilterFromFireStore();
  }

}