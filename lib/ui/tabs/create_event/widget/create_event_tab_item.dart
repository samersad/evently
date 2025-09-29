import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CreateEventTabItem extends StatelessWidget {
  const CreateEventTabItem({
    super.key,
    required this.eventName,
    required this.isSelected,
  });

  final String eventName;
  final bool isSelected;

  static const Map<String, IconData> eventIcons = {
    "meeting": Icons.people,
    "gaming": Icons.sports_esports,
    "work shop": Icons.handyman,
    "book club": Icons.auto_stories,
    "exhibition": Icons.museum,
    "holiday": Icons.flight,
    "eating": Icons.fastfood,
    "birthday": Icons.cake,
    "all": Icons.explore,
    "sport": Icons.directions_bike,
  };


  @override
  Widget build(BuildContext context) { 
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.005,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.012,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 1,
        ),
        color: isSelected
            ? AppColors.primaryLight
            : AppColors.transparentColor,
      ),
      child: Row(
        children: [
          Icon(
            eventIcons[eventName.toLowerCase()] ,
            color: isSelected ? Theme.of(context).disabledColor : AppColors.primaryLight
            ,
          ),
          const SizedBox(width: 8),
          Text(
            eventName,
            style: isSelected
                ? Theme.of(context).textTheme.bodySmall
                : AppStyles.bold16Primary,
          ),
        ],
      ),
    );
  }
}
