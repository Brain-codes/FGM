// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:FGM/devotional/controller/devotional_controller.dart';
import 'package:FGM/devotional/model/all_devotional_model.dart';
import 'package:FGM/devotional/ui/devotional_screen.dart';
import 'package:FGM/home/controller/home_controller.dart';
import 'package:FGM/home/model/all_wotw_model.dart';
import 'package:FGM/media/audio_bottom_player.dart';
import 'package:FGM/media/controller/media_controller.dart';
import 'package:FGM/media/media_screen.dart';
import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/shared/components/empty/empty_event.dart';
import 'package:FGM/shared/components/loading/devotional_loading.dart';
import 'package:FGM/shared/components/loading/message_loading.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/components/tiles/devotion_tile.dart';
import 'package:FGM/shared/components/tiles/home_heading_tile.dart';
import 'package:FGM/shared/components/tiles/messages_tile.dart';
import 'package:FGM/shared/components/tiles/word_tiles.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../devotional/ui/devotional_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userDetails =
      LocalDatabaseService().getData(DbKeyStrings.userDetailsKey);
  final HomeController _HomeController = Get.put(HomeController());

  List<AllDevotionalModel>? devotionaItem;
  String name = '';
  List<AllMediaModel>? _mediaItem;
  List<AllWotwModel>? _wotwItem;
  bool _hasPreviousSnackbar = false;

  getAllDevotion() async {
    await _HomeController.getAllDevotional(context);
    setState(() {
      devotionaItem = _HomeController.devotionaItem;
    });
  }

  getAllMedia() async {
    await _HomeController.getAllMedia(context);
    setState(() {
      _mediaItem = _HomeController.mediaItem;
    });
  }

  getAllWotw() async {
    await _HomeController.getAllWotw(context);
    setState(() {
      _wotwItem = _HomeController.wotwItem;
    });
  }

  Future<void> _downloadFile(String url, String filename, int index) async {
    successSnackBar('Downloading!', filename);
    setState(() {
      _mediaItem![index].progress = 0;
    });
    FileDownloader.downloadFile(
        url: url,
        onProgress: (fileName, progress) {
          setState(() {
            _mediaItem![index].progress = progress;
          });
        },
        onDownloadCompleted: (value) {
          successSnackBar(
            'Download Complete.',
            'Check your Download Folder to preview',
          );

          setState(() {
            _mediaItem![index].progress = null;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      name = _userDetails['name'].split(' ').last;
    });
    getAllDevotion();
    getAllMedia();
    getAllWotw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Hello $name',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                //WORD FRO THE WEEK
                Text(
                  'Word for the week',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // WORD FOR THE WEEK CONTAINER
                Obx(
                  () => _HomeController.isLoadingWotw.value
                      ? DevotionalLoader()
                      : _wotwItem!.isEmpty
                          ? EmptyEvent()
                          : WordTile(
                              image: _wotwItem![_wotwItem!.length - 1 - 0]
                                  .image
                                  ?.secureUrl,
                              title:
                                  _wotwItem![_wotwItem!.length - 1 - 0].content,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DevotionalDetails(
                                      type: 'wotw',
                                      wotwDetails:
                                          _wotwItem![_wotwItem!.length - 1 - 0],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),

                SizedBox(
                  height: 30,
                ),

                //DEVOTION HEADER
                HomeHeadingTile(
                  title: 'Devotional',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DevotionalScreen(),
                      ),
                    );
                  },
                  isEmpty: _HomeController.isLoading.value
                      ? true
                      : devotionaItem!.isEmpty,
                ),

                SizedBox(
                  height: 20,
                ),

                //DEVOTIONAL ITEM

                Obx(
                  () => _HomeController.isLoading.value
                      ? DevotionalLoader()
                      : devotionaItem!.isEmpty
                          ? EmptyEvent()
                          : DevotionTile(
                              image:
                                  devotionaItem![devotionaItem!.length - 1 - 0]
                                      .image
                                      ?.secureUrl,
                              title:
                                  devotionaItem![devotionaItem!.length - 1 - 0]
                                      .title,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DevotionalDetails(
                                      devotionalDetails: devotionaItem![
                                          devotionaItem!.length - 1 - 0],
                                    ),
                                  ),
                                );
                              },
                              description:
                                  devotionaItem![devotionaItem!.length - 1 - 0]
                                      .content,
                              date:
                                  devotionaItem![devotionaItem!.length - 1 - 0]
                                      .date,
                            ),
                ),

                SizedBox(
                  height: 30,
                ),

                //DEVOTION HEADER
                HomeHeadingTile(
                  title: 'Messages',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaScreen(
                          source: 'home',
                        ),
                      ),
                    );
                  },
                  isEmpty: _HomeController.isLoadingMessage.value
                      ? true
                      : _mediaItem!.isEmpty,
                ),

                SizedBox(
                  height: 20,
                ),

                Obx(
                  () => _HomeController.isLoadingMessage.value
                      ? SizedBox(
                          child: ListView.builder(
                            itemCount: 3,
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
                                child: MessageLoader(),
                              );
                            },
                          ),
                        )
                      : _mediaItem!.isEmpty
                          ? EmptyEvent()
                          : SizedBox(
                              child: ListView.builder(
                                itemCount: _mediaItem!.length <= 3
                                    ? _mediaItem?.length
                                    : 3,
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
                                    child: MessagesTile(
                                      image:
                                          _mediaItem?[index].image?.secureUrl,
                                      message: _mediaItem?[index].title,
                                      pastor: _mediaItem?[index].name,
                                      date: _mediaItem?[index].date,
                                      progress: _mediaItem?[index].progress,
                                      isPlaying: _mediaItem?[index].isPlaying,
                                      onTapsDownload: () {
                                        final url =
                                            _mediaItem![index].audio?.secureUrl;
                                        final filename =
                                            '${_mediaItem![index].title} by ${_mediaItem![index].name}';
                                        _downloadFile(
                                          '$url',
                                          filename,
                                          index,
                                        ); // pass the index of the media item
                                      },
                                      onTaps: () {
                                        setState(() {
                                          for (int i = 0;
                                              i < _mediaItem!.length;
                                              i++) {
                                            if (i != index &&
                                                _mediaItem![i].isPlaying ==
                                                    true) {
                                              setState(() {
                                                _mediaItem![i].isPlaying =
                                                    false;
                                              });
                                            }
                                          }
                                          _mediaItem?[index].isPlaying = true;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();

                                        if (_hasPreviousSnackbar) {
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: AudioBottomPlayer(
                                                  index: index,
                                                  mediaAll: _mediaItem,
                                                  isNext: () {},
                                                  isPlaying: () {
                                                    setState(() {
                                                      _mediaItem?[index]
                                                          .isPlaying = false;
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                    });
                                                  },
                                                  source: 'home',
                                                  eachMedia:
                                                      '${_mediaItem![index].audio!.secureUrl}',
                                                ),
                                                duration:
                                                    const Duration(days: 1),
                                                backgroundColor:
                                                    Color(0xFFEBF4FF),
                                                behavior:
                                                    SnackBarBehavior.fixed,
                                              ),
                                            );
                                            _hasPreviousSnackbar = true;
                                          });
                                        } else {
                                          setState(() {
                                            for (int i = 0;
                                                i < _mediaItem!.length;
                                                i++) {
                                              if (i != index &&
                                                  _mediaItem![i].isPlaying ==
                                                      true) {
                                                setState(() {
                                                  _mediaItem![i].isPlaying =
                                                      false;
                                                });
                                              }
                                            }
                                            _mediaItem?[index].isPlaying = true;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: AudioBottomPlayer(
                                                index: index,
                                                isNext: () {},
                                                mediaAll: _mediaItem,
                                                isPlaying: () {
                                                  setState(() {
                                                    _mediaItem?[index]
                                                        .isPlaying = false;
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                  });
                                                },
                                                source: 'home',
                                                eachMedia:
                                                    '${_mediaItem![index].audio!.secureUrl}',
                                              ),
                                              duration: const Duration(days: 1),
                                              backgroundColor:
                                                  Color(0xFFEBF4FF),
                                              behavior: SnackBarBehavior.fixed,
                                            ),
                                          );
                                          _hasPreviousSnackbar = true;
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
