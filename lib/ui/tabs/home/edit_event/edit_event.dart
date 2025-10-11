import 'package:event_planningapp/home_screen/widget/custom_elevated_buttom.dart';
import 'package:event_planningapp/home_screen/widget/custom_text_form_field.dart';
import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/ui/tabs/create_event/widget/create_event_tab_item.dart';
import 'package:event_planningapp/ui/tabs/create_event/widget/date_or_time_widget.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_routes.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../firebase_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/event.dart';
import '../../../../provider/event_list_provider.dart';


class EditEvent extends StatefulWidget {
  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<EditEvent> {
  int selectedIndex=0;
  TextEditingController eventTitleCRl=TextEditingController(text: "");
  TextEditingController descriptionCRl=TextEditingController(text: "");
  var formkey=GlobalKey<FormState>();
  DateTime? selectedDate ;
  TimeOfDay? selectedTime ;
  String? formatDate;
  String? formatTime;
  String selectedEventImage="";
  String selectedEventName="";
  Event? event;
  late List<String> eventNameList;
  late List<String> eventImageListLight;
  late List<String> eventImageListDark;
  late EventListProvider eventListProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    event = ModalRoute.of(context)!.settings.arguments as Event;

    eventTitleCRl.text = event?.title ?? "";
    descriptionCRl.text = event?.description ?? "";

  eventImageListLight = [
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
   eventImageListDark=[
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


    int foundIndex = eventImageListLight.indexOf(event!.eventImage ?? "");
    if (foundIndex != -1) {
      selectedIndex = foundIndex;
    } else {
      selectedIndex = 0;
    }
  }


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
   // final event = ModalRoute.of(context)!.settings.arguments as Event;
    var providerTheme=Provider.of<AppThemeProvider>(context);
    eventListProvider=Provider.of<EventListProvider>(context);

    selectedEventName = eventNameList[selectedIndex];

    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.primaryLight,
        title: Text(AppLocalizations.of(context)!.editEvent,style: AppStyles.bold20primary,),
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
                  Image.asset( selectedEventImage=eventImageListLight[selectedIndex],fit: BoxFit.fill,) ///to get index last page details screen
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
                  ,hintText: event?.title,
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
                  ,hintText:event?.description,
                  validator: (text) {
                    if (text==null||text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterEventDescription;
                    }
                  },
                ),
                SizedBox(height: height*0.01),
                DateOrTimeWidget(iconName: AppAssets.eventIcon,eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                  chooseDateOrTime: selectedDate == null ?
                  DateFormat("dd MMM yyyy").format(event!.eventDateTime!)
                      :
                  formatDate!,
                    onPressed: () {
                  chooseDate();
                  setState(() {

                  });
                },),
                DateOrTimeWidget(iconName: AppAssets.timeIcon,eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                    chooseDateOrTime: selectedTime == null ?
                   "${event?.eventTime}"
                        :
                    formatTime!,
                    onPressed: () {
                      chooseTime();
                    }),
                SizedBox(height: height*0.01),
                Text(AppLocalizations.of(context)!.location,style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: height*0.01),
                CustomElevatedButtom(onPressed: (){},
                  customPadding: 10,
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
                      Text("Cairo , Egypt",style: AppStyles.medium16primary,),
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
                  updateEvent();
                },
                  borderColor: AppColors.primaryLight,
                    text: AppLocalizations.of(context)!.updateEvent,
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
      formatDate=DateFormat('dd/MMM/yyyy').format(selectedDate!);

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
  void updateEvent()  {
    if (formkey.currentState?.validate() == true) {
      Event updatedEvent = Event(
        id: event!.id,
        title: eventTitleCRl.text,
        description: descriptionCRl.text,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventDateTime: selectedDate ?? event!.eventDateTime,
        eventTime: formatTime ?? event!.eventTime,
        isFavorite: event!.isFavorite,
      );

      eventListProvider.updateEventInFirestore(updatedEvent);
        // Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreenRouteNamed);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeScreenRouteNamed,
            (route) => route.isFirst,
      );

    }
  }
}
