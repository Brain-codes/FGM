// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/event/controller/event_controller.dart';
import 'package:FGM/event/model/all_event_model.dart';
import 'package:FGM/shared/components/bottom_sheet/base_bottom_sheet.dart';
import 'package:FGM/shared/components/empty/empty_event.dart';
import 'package:FGM/shared/components/loading/devotional_loading.dart';
import 'package:FGM/shared/components/tiles/live_event_tile.dart';
import 'package:FGM/shared/components/tiles/upcoming_event_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/constants/app_string.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventController _EventController = Get.put(EventController());
  List<AllEventModel>? _upcomingEventItem;
  List<AllEventModel>? _liveEventItem;

  getAllEvent() async {
    await _EventController.getAllEvent(context);
    setState(() {
      _upcomingEventItem = _EventController.upcomingEventItem;
      _liveEventItem = _EventController.liveEventItem;
    });
  }

  @override
  void initState() {
    getAllEvent();
    super.initState();
  }

  _EventDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BaseBottomSheet(
          items: [
            Text('HAAAA'),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                AppStrings.navEvent,
                style: TextThemes(context).getTextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => _EventController.isLoading.value
                    ? SizedBox(
                        child: ListView.builder(
                          itemCount: 1,
                          padding: EdgeInsets.only(
                            bottom: 20,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: DevotionalLoader(),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        child: ListView.builder(
                          itemCount: _liveEventItem?.length,
                          padding: EdgeInsets.only(
                            bottom: 20,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: LiveEventTile(
                                // image: _eventItem![index].startDateTime,
                                image: _liveEventItem![index].image?.secureUrl,
                                onTaps: () {},
                              ),
                            );
                          },
                        ),
                      ),
              ),
              Text(
                'Upcoming events',
                style: TextThemes(context).getTextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => _EventController.isLoading.value
                    ? SizedBox(
                        child: ListView.builder(
                          itemCount: 4,
                          padding: EdgeInsets.only(
                            bottom: 20,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: DevotionalLoader(),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        child: _upcomingEventItem!.isEmpty
                            ? EmptyEvent()
                            : ListView.builder(
                                itemCount: _upcomingEventItem?.length,
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: UpcomingEventTile(
                                      date: _upcomingEventItem![index]
                                          .startDateTime,
                                      image: _upcomingEventItem![index]
                                          .image
                                          ?.secureUrl,
                                    ),
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
