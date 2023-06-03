// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:FGM/auth/ui/auth_screens_header.dart';
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
import 'package:FGM/shared/ui/event_small_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  _EventDetailsBottomSheet(AllEventModel data, String status) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BaseBottomSheet(
          items: [
            // SizedBox(
            //   height: 20,
            // ),
            Text(
              '${data.title}',
              style: TextThemes(context).getTextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 0,
                  child: SmallDetailsEventTile(
                    title: 'Time',
                    icon: AppIcons.time,
                    value: _EventController.formatTime(
                      DateTime.parse(
                        '${data.startDateTime}',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: SmallDetailsEventTile(
                      title: 'Date',
                      icon: AppIcons.date,
                      value: '${_EventController.formatDate(
                        DateTime.parse(
                          '${data.startDateTime}',
                        ),
                      )} - ${_EventController.formatDate(
                        DateTime.parse(
                          '${data.endDateTime}',
                        ),
                      )}'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            LocationSmallDetailsEventTile(
              title: 'Location',
              icon: AppIcons.location,
              value: data.venue,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Streaming Link',
              style: TextThemes(context).getTextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: status != 'live'
                  ? Text(
                      'Sorry! Streaming link isn\'t available now check back whenever this event is live',
                      style: TextThemes(context).getTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.placeHolderTextColor,
                      ),
                    )
                  : Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: AudioButton(
                                title: 'Audio',
                                onTaps: () {},
                                radius: 2,
                              ),
                            ),
                            Flexible(
                              flex: 0,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: StreamButton(
                                title: 'Video',
                                onTaps: () {},
                                radius: 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: 30,
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Live events',
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
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
                    : Container(
                        child: _liveEventItem!.isEmpty
                            ? SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.monitor,
                                        color: AppColors.primaryColor,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Text(
                                          'Oops! There is no current live Event at the moment. \n Please check back later.',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextThemes(context).getTextStyle(
                                            fontSize: 10,
                                            color:
                                                AppColors.placeHolderTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                                    return GestureDetector(
                                      onTap: () {
                                        _EventDetailsBottomSheet(
                                          _liveEventItem![index],
                                          'live',
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: LiveEventTile(
                                          // image: _eventItem![index].startDateTime,
                                          image: _liveEventItem![index]
                                              .image
                                              ?.secureUrl,
                                          onTaps: () {},
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
                                  return GestureDetector(
                                    onTap: () {
                                      _EventDetailsBottomSheet(
                                        _upcomingEventItem![index],
                                        'upcoming',
                                      );
                                    },
                                    child: Padding(
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
