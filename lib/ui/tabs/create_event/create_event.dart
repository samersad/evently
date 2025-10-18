import 'package:event_planningapp/firebase_utils.dart';
import 'package:event_planningapp/home_screen/widget/custom_elevated_buttom.dart';
import 'package:event_planningapp/home_screen/widget/custom_text_form_field.dart';
import 'package:event_planningapp/model/event.dart';
import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/ui/tabs/create_event/widget/create_event_tab_item.dart';
import 'package:event_planningapp/ui/tabs/create_event/widget/date_or_time_widget.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../provider/event_list_provider.dart';
import '../../../provider/user_provider.dart';

class CreateEvent extends StatefulWidget {
  CreateEvent({super.key});


  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String? dateError;
  String? timeError;
  String? locationError;
  int selectedIndex=0;
  String selectedEventImage="";
  String selectedEventName="";
  TextEditingController eventTitleCRl=TextEditingController(text: "");
  TextEditingController descriptionCRl=TextEditingController(text: "");
  var formkey=GlobalKey<FormState>();
  DateTime? selectedDate ;
  TimeOfDay? selectedTime ;
  String? formatDate;
  String? formatTime;
 late EventListProvider eventListProvider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    List<String> eventNameList=[
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
    List<String> eventImageListLight=[
      AppAssets.sportBgLight,
      AppAssets.birthdayBgLight,
      AppAssets.meetingBgLight,
      AppAssets.gamingBgLight,
      AppAssets.workShopBgLight,
      AppAssets.bookClubBgLight,
      AppAssets.exhibitionBgLight,
      AppAssets.holidayBgLight,
      AppAssets.eatingBgLight,
    ];
    List<String> eventImageListDark=[
      AppAssets.sportBgDark,
      AppAssets.birthdayBgDark,
      AppAssets.meetingBgDark,
      AppAssets.gamingBgDark,
      AppAssets.workShopBgDark,
      AppAssets.bookClubBgDark,
      AppAssets.exhibitionBgDark,
      AppAssets.holidayBgDark,
      AppAssets.eatingBgDark,
    ];
    var providerTheme=Provider.of<AppThemeProvider>(context);
    eventListProvider=Provider.of<EventListProvider>(context);
    selectedEventName = eventNameList[selectedIndex];
    userProvider=Provider.of<UserProvider>(context);




    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.primaryLight,
        title: Text(AppLocalizations.of(context)!.createEvent,style: AppStyles.bold20primary,),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:providerTheme.appTheme==ThemeMode.light ?
                    Image.asset(selectedEventImage=eventImageListLight[selectedIndex],fit: BoxFit.fill,)
                        :
                    Image.asset(selectedEventImage=eventImageListDark[selectedIndex],fit: BoxFit.fill)
                ),
                SizedBox(height: height*0.005),
                SizedBox(
                  height: height*0.07,
                  child: ListView.separated(scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap:() {
                              selectedIndex=index;
                              setState(() {
                              });
                            },
                            child: CreateEventTabItem(eventName: eventNameList[index], isSelected: selectedIndex==index ));
                      }
                      , separatorBuilder: (context, index) {
                        return SizedBox(width: width*0.02,);
                      }
                      , itemCount:eventNameList.length
                  ),
                ),
                SizedBox(height: height*0.005),
                Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: height*0.005),
                CustomTextFormField(controller: eventTitleCRl,
                  prefixIconName: Image.asset(AppAssets.titleIcon,color: Theme.of(context).highlightColor,)
                  ,hintText: AppLocalizations.of(context)!.event_Title,
                  validator: (text) {
                    if (text==null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEventTitle;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height*0.01),
                Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: height*0.01),
                CustomTextFormField(controller: descriptionCRl,
                  maxLines: 4
                  ,hintText: AppLocalizations.of(context)!.eventDescription,
                  validator: (text) {
                    if (text==null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEventDescription;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height*0.01),
                DateOrTimeWidget(iconName: AppAssets.eventIcon,eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                  chooseDateOrTime: selectedDate == null ?
                  AppLocalizations.of(context)!.chooseDate
                      :
                  formatDate!,

                  error: dateError!=null ?
                  Text(dateError!, style: AppStyles.medium12Red )
                      :null ,
                  onPressed: () {
                    chooseDate();

                  } ,
                ),

                DateOrTimeWidget(iconName: AppAssets.timeIcon,eventDateOrTime: AppLocalizations.of(context)!.eventTime,

                    chooseDateOrTime:selectedTime == null ?AppLocalizations.of(context)!.chooseTime
                        :
                    formatTime!,

                    error: timeError!=null ? Text(timeError!,style:AppStyles.medium12Red )
                        :
                    null
                    ,
                    onPressed: () {
                      chooseTime();
                    }),

                SizedBox(height: height*0.01),
                Text(AppLocalizations.of(context)!.location,style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: height*0.01),
                CustomElevatedButtom(onPressed: (){},customPadding: 10,
                  borderColor: AppColors.primaryLight,
                  backgroundColorElevated: AppColors.transparentColor,
                  hasIcon: true,
                  childIconWidget: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
                        margin: EdgeInsetsDirectional.only(start: width*0.04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryLight
                        ),
                        child: Image.asset(AppAssets.locationIcon,color: Theme.of(context).disabledColor),),
                      SizedBox(width: width*0.02,),
                      Text(AppLocalizations.of(context)!.chooseEventLocation,style: AppStyles.medium16primary,),
                      Spacer(),
                      Padding(
                        padding:  EdgeInsetsDirectional.only(end: width*0.03),
                        child: Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryLight,),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height*0.01),
                CustomElevatedButtom(onPressed: (){
                  //todo add event
                  addEvent();
                },
                  borderColor: AppColors.primaryLight,
                  text: AppLocalizations.of(context)!.addEvent,
                  textStyle: AppStyles.medium20white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> chooseDate() async {
    var chooseDate=await showDatePicker(context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate=chooseDate;
    if (selectedDate!=null) {
      formatDate=DateFormat('dd/MM/yyyy').format(selectedDate!);

    }
    setState(() {

    });
  }
  Future<void> chooseTime() async {
    var chooseTime=await showTimePicker(context: context
        , initialTime: TimeOfDay.now()
    );
    selectedTime=chooseTime;
    if (selectedTime!=null) {
      formatTime=selectedTime!.format(context);

    }
    setState(() {

    });
  }
  Future<void> addEvent() async {
    dateError = selectedDate == null ? AppLocalizations.of(context)!.please_choose_event_date : null;
    timeError = selectedTime == null ? AppLocalizations.of(context)!.please_choose_event_time : null;
    if (formkey.currentState?.validate()==true && dateError == null && timeError == null) {
      Event event=Event(
          title: eventTitleCRl.text,
          description:descriptionCRl.text ,
          eventImage:selectedEventImage ,
          eventName:selectedEventName ,
          eventDateTime: selectedDate,
          eventTime:formatTime
      );
     await FireBaseUtils.addEventToFirestore(event,userProvider.currentUser!.id).then((value) {
       final snackBar = SnackBar(
             behavior: SnackBarBehavior.floating,
             elevation: 6,
             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16),
             ),
             duration: Duration(seconds: 1),
             content:
             Text(AppLocalizations.of(context)!.event_added_successfully),backgroundColor: AppColors.primaryLight,
             action: SnackBarAction(
               textColor: AppColors.primaryLight,
               label: AppLocalizations.of(context)!.close ,backgroundColor: AppColors.whiteColor,
               onPressed: () {
                 // Some code to undo the change.
               },
             ),
           );
       Navigator.pop(context);

     },
     ).catchError((error) {
      }
      );    }
    setState(() {
    });
  }
  @override
  void dispose(){
    super.dispose();
  eventListProvider.getAllEvent(userProvider.currentUser!.id);

  }
}

/*
            final snackBar = SnackBar(
              content: const Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);


 */