import 'package:event_planningapp/provider/app_theme_provider.dart';
import 'package:event_planningapp/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../model/event.dart';
import '../../../provider/event_list_provider.dart';
import '../../../provider/location_provider.dart';
import '../../../utils/app_colors.dart';

class MapTap extends StatefulWidget {
  const MapTap({super.key});

  @override
  State<MapTap> createState() => _MapTapState();
}

class _MapTapState extends State<MapTap> {
  late GoogleMapController _controller;
  Set<Circle> circles = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initCircle();
  }

  void initCircle() {
    circles.clear();
    final eventProvider =
    Provider.of<EventListProvider>(context, listen: false);

    for (var i = 0; i < eventProvider.eventsList.length; i++) {
      final event = eventProvider.eventsList[i];
      circles.add(
        Circle(
          circleId: CircleId(event.id!),
          center: LatLng(event.lat!, event.log!),
          radius: 15,
          fillColor:
          i == 0 ? AppColors.primaryLight : AppColors.grayColor,
          strokeColor: i == 0
              ? AppColors.primaryLight.withOpacity(0.5)
              : AppColors.grayColor.withOpacity(0.5),
          strokeWidth: 15,
        ),
      );
    }
  }

  Set<Circle> updateCircle(Event event) {
    return circles.map((circle) {
      final isSelected = circle.circleId.value == event.id;

      return Circle(
        circleId: circle.circleId,
        center: circle.center,
        radius: circle.radius,
        fillColor:
        isSelected ? AppColors.primaryLight : AppColors.grayColor,
        strokeColor: isSelected
            ? AppColors.primaryLight.withOpacity(0.5)
            : AppColors.grayColor.withOpacity(0.5),
        strokeWidth: circle.strokeWidth,
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final eventListProvider = Provider.of<EventListProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    if (eventListProvider.eventsList.isEmpty) {
      return const SafeArea(
        child: Center(child: Text("No Events")),
      );
    }

    return Stack(
      children: [
        /// MAP
        GoogleMap(
          onMapCreated: (controller) => _controller = controller,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              eventListProvider.eventsList[0].lat!,
              eventListProvider.eventsList[0].log!,
            ),
            zoom: 15,
          ),
          zoomControlsEnabled: false,
          mapType: MapType.terrain,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          circles: circles,
        ),

        /// MY LOCATION BUTTON
        Positioned(
          top: 50,
          right: 16,
          child: InkWell(
            onTap: () {
              if (locationProvider.userLocation == null) {
                locationProvider.getCurrentLocation();
              }
              updateCamera(locationProvider.userLocation);
            },
            child: Image.asset(
              themeProvider.appTheme == ThemeMode.light
                  ? AppAssets.mapLight
                  : AppAssets.mapDark,
              width: 50,
              height: 50,
            ),
          ),
        ),

        /// EVENTS LIST
        Positioned(
          left: 15,
          right: 15,
          bottom: 30,
          child: SizedBox(
            height: screenSize.height * 0.18,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: eventListProvider.eventsList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final event = eventListProvider.eventsList[index];

                return InkWell(
                  onTap: () {
                    updateCamera(LatLng(event.lat!, event.log!));
                    setState(() {
                      circles = updateCircle(event);
                    });
                  },
                  child: Container(
                    width: screenSize.width * 0.83,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        /// IMAGE
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              event.eventImage!,
                              width: 120,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.description!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall,
                                ),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.mapPin,
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        event.address!,
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void updateCamera(LatLng? newLocation) {
    if (newLocation == null) return;
    _controller.animateCamera(
      CameraUpdate.newLatLng(newLocation),
    );
  }
}
