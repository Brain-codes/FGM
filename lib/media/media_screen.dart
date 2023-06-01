// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, non_constant_identifier_names, avoid_init_to_null, must_be_immutable

import 'package:FGM/media/audio_bottom_player.dart';
import 'package:FGM/media/controller/media_controller.dart';
import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/media/services/audio_player_service.dart';
import 'package:FGM/shared/components/loading/message_loading.dart';
import 'package:FGM/shared/components/searchbar/base_searchbar.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/components/tiles/messages_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:FGM/shared/ui/appbar.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class MediaScreen extends StatefulWidget {
  List<AllMediaModel>? mediaItem;
  String? source;

  MediaScreen({super.key, this.mediaItem = null, this.source = 'none'});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final MediaController _MediaController = Get.put(MediaController());
  List<AllMediaModel>? _mediaItem;
  final _searchController = TextEditingController();
  List<AllMediaModel>? _filteredMediaItem;
  bool isPlaying = false;

  getAllMedia() async {
    await _MediaController.getAllMedia(context);
    setState(() {
      _mediaItem = _MediaController.mediaItem;
      // initialize your _mediaItem list here
      _filteredMediaItem = _mediaItem; //
      // _init(0);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.mediaItem == null) {
      getAllMedia();
    } else {
      widget.mediaItem = _mediaItem;
    }
  }

  final AudioPlayerSingleton _audioPlayerSingleton = AudioPlayerSingleton();
  late AudioPlayer _audioPlayer;

  // Future<void> _init(index) async {
  //   final audioPlayer = _audioPlayerSingleton.audioPlayer;
  //   await audioPlayer.setLoopMode(LoopMode.all);
  //   await audioPlayer.setAudioSource(
  //     AudioSource.uri(
  //       Uri.parse('${_mediaItem?[index].audio?.secureUrl}'),
  //       tag: MediaItem(
  //         id: '1',
  //         title: '${_mediaItem?[index].title} - ${_mediaItem?[index].name}',
  //         artist: _mediaItem?[index].name,
  //         artUri: Uri.parse('${_mediaItem?[index].image?.secureUrl}'),
  //       ),
  //     ),
  //     initialIndex: index,
  //     initialPosition: Duration.zero,
  //   );
  //   _audioPlayer = audioPlayer;
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   _filteredMediaItem?.forEach((item) {
  //     item.isPlaying = false;
  //   });
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   _searchController.dispose();

  //   super.dispose();
  // }

  void _filterList(String query) {
    setState(() {
      _filteredMediaItem = _mediaItem
          ?.where((item) =>
              item.title?.toLowerCase()?.contains(query.toLowerCase()) ==
                  true ||
              item.name?.toLowerCase()?.contains(query.toLowerCase()) == true)
          .toList();
    });
  }

  Future<void> _downloadFile(String url, String filename, int index) async {
    successSnackBar('Downloading!', filename);
    setState(() {
      _mediaItem![index].progress =
          0; // set progress to 0 for the corresponding media item
    });
    FileDownloader.downloadFile(
        url: url,
        onProgress: (fileName, progress) {
          setState(() {
            _mediaItem![index].progress =
                progress; // update the progress for the corresponding media item
          });
        },
        onDownloadCompleted: (value) {
          successSnackBar(
            'Download Complete.',
            'Check your Download Folder to preview',
          );

          print('path $value');
          setState(() {
            _mediaItem![index].progress =
                null; // set progress to null for the corresponding media item when download is complete
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.source == 'home' ? CustomAppBar() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: BaseSearchField(
                    hintText: 'Search for message title',
                    onTyping: (value) {
                      _filterList(value!);
                    },
                    controller: _searchController,
                    enabled: !_MediaController.isLoading.value,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: widget.source == 'home'
                      ? Text(
                          'Messages',
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Text(
                          'Media',
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => _MediaController.isLoading.value
                      ? SizedBox(
                          child: ListView.builder(
                            itemCount: 7,
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
                      : SizedBox(
                          child: ListView.builder(
                            itemCount: _filteredMediaItem?.length,
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
                                  image: _filteredMediaItem?[index]
                                      .image
                                      ?.secureUrl,
                                  message: _filteredMediaItem?[index].title,
                                  pastor: _filteredMediaItem?[index].name,
                                  date: _filteredMediaItem?[index].date,
                                  progress: _filteredMediaItem?[index].progress,
                                  isPlaying:
                                      _filteredMediaItem?[index].isPlaying,
                                  onTapsDownload: () {
                                    final url = _filteredMediaItem![index]
                                        .audio
                                        ?.secureUrl;
                                    final filename =
                                        '${_filteredMediaItem![index].title} by ${_mediaItem![index].name}';
                                    _downloadFile('$url', filename,
                                        index); // pass the index of the media item
                                  },
                                  onTaps: () {
                                    setState(() {
                                      for (int i = 0;
                                          i < _filteredMediaItem!.length;
                                          i++) {
                                        if (i != index &&
                                            _filteredMediaItem![i].isPlaying ==
                                                true) {
                                          setState(() {
                                            _filteredMediaItem![i].isPlaying =
                                                false;
                                          });
                                        }
                                      }
                                      _mediaItem?[index].isPlaying = true;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    Future.delayed(Duration(seconds: 2), () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: AudioBottomPlayer(
                                            index: index,
                                            mediaAll: _filteredMediaItem,
                                            isNext: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i <
                                                        _filteredMediaItem!
                                                            .length;
                                                    i++) {
                                                  if (i != index &&
                                                      _filteredMediaItem![i]
                                                              .isPlaying ==
                                                          true) {
                                                    setState(() {
                                                      _filteredMediaItem![i]
                                                          .isPlaying = false;
                                                    });
                                                  }
                                                }
                                                _mediaItem?[index].isPlaying =
                                                    true;
                                              });
                                            },
                                            isPlaying: () {
                                              setState(() {
                                                _filteredMediaItem?[index]
                                                    .isPlaying = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                            eachMedia:
                                                '${_filteredMediaItem![index].audio!.secureUrl}',
                                          ),
                                          duration: const Duration(days: 1),
                                          backgroundColor: Color(0xFFEBF4FF),
                                          behavior: SnackBarBehavior.fixed,
                                        ),
                                      );
                                    });
                                  },
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
      ),
    );
  }
}
