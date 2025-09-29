import 'package:event_planningapp/l10n/app_localizations.dart';
import 'package:event_planningapp/utils/app_colors.dart';
import 'package:event_planningapp/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class EventTabItem extends StatefulWidget {
  const EventTabItem({
    super.key,
    required this.eventName,
    required this.isSelected,
  });

  final String eventName;
  final bool isSelected;

  @override
  State<EventTabItem> createState() => _EventTabItemState();
}

class _EventTabItemState extends State<EventTabItem> {
  Map<String, IconData> getEventIcons(BuildContext context) {
    return {
      AppLocalizations.of(context)!.meeting: Icons.people,
      AppLocalizations.of(context)!.gaming: Icons.sports_esports,
      AppLocalizations.of(context)!.work_shop: Icons.handyman,
      AppLocalizations.of(context)!.book_club: Icons.auto_stories,
      AppLocalizations.of(context)!.exhibition: Icons.museum,
      AppLocalizations.of(context)!.holiday: Icons.flight,
      AppLocalizations.of(context)!.eating: Icons.fastfood,
      AppLocalizations.of(context)!.birthday: Icons.cake,
      AppLocalizations.of(context)!.all: Icons.explore,
      AppLocalizations.of(context)!.sport: Icons.directions_bike,
    };
  }
  @override
  Widget build(BuildContext context) {
    final eventIcons = getEventIcons(context);
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
          color: Theme.of(context).focusColor,
          width: 2,
        ),
        color: widget.isSelected
            ? Theme.of(context).focusColor
            : AppColors.transparentColor,
      ),
      child: Row(
        children: [
          Icon(
            eventIcons[widget.eventName] ,
            color: widget.isSelected ? Theme.of(context).cardColor : AppColors.whiteColor,
          ),
          const SizedBox(width: 8),
          Text(
            widget.eventName,
            style: widget.isSelected
                ? Theme.of(context).textTheme.headlineMedium
                : AppStyles.medium16white,
          ),
        ],
      ),
    );
  }
}
