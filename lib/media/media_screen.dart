// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, non_constant_identifier_names, avoid_init_to_null, must_be_immutable

import 'package:FGM/media/controller/media_controller.dart';
import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/shared/components/loading/message_loading.dart';
import 'package:FGM/shared/components/searchbar/base_searchbar.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/components/tiles/messages_tile.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class MediaScreen extends StatefulWidget {
  List<AllMediaModel>? mediaItem;

  MediaScreen({
    super.key,
    this.mediaItem = null,
  });

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final MediaController _MediaController = Get.put(MediaController());
  List<AllMediaModel>? _mediaItem;
  final _searchController = TextEditingController();
  List<AllMediaModel>? _filteredMediaItem;

  getAllMedia() async {
    await _MediaController.getAllMedia(context);
    setState(() {
      _mediaItem = _MediaController.mediaItem;
      // initialize your _mediaItem list here
      _filteredMediaItem = _mediaItem; //
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      // appBar: CustomAppBar(),
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
                Text(
                  'Messages',
                  style: TextThemes(context).getTextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
                              final reversedIndex =
                                  _filteredMediaItem!.length - 1 - index;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: MessagesTile(
                                  image: _filteredMediaItem?[reversedIndex]
                                      .image
                                      ?.secureUrl,
                                  message:
                                      _filteredMediaItem?[reversedIndex].title,
                                  pastor:
                                      _filteredMediaItem?[reversedIndex].name,
                                  date: _filteredMediaItem?[reversedIndex].date,
                                  progress: _filteredMediaItem?[reversedIndex]
                                      .progress,
                                  onTapsDownload: () {
                                    final url =
                                        _filteredMediaItem![reversedIndex]
                                            .audio
                                            ?.secureUrl;
                                    final filename =
                                        '${_filteredMediaItem![reversedIndex].title} by ${_mediaItem![reversedIndex].name}';
                                    _downloadFile('$url', filename,
                                        reversedIndex); // pass the index of the media item
                                  },
                                  onTaps: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: SizedBox(
                                            height: 40,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pst. Chijioke Okonkwo- Sure Mercies of David',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextThemes(context)
                                                      .getTextStyle(
                                                    color: AppColors
                                                        .primaryTextColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.asset(
                                                    'images/player.png'),
                                              ],
                                            )),
                                        duration: const Duration(
                                          days: 365,
                                        ), // Set the duration to a long time to prevent it from being automatically dismissed
                                        backgroundColor: Color(0xFFEBF4FF),
                                        behavior: SnackBarBehavior.fixed,
                                      ),
                                    );
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
