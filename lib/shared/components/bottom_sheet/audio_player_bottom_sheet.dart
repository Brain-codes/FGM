// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, implementation_imports, must_be_immutable, unused_field, unused_element prefer_const_constructors, unused_local_variable, unnecessary_null_comparison

import 'package:FGM/media/audio_player_singleton.dart';
import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/shared/components/buttons/small_filled_circular_button.dart';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:FGM/media/services/audio_player_service.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/src/rx.dart';
import 'package:path_provider/path_provider.dart';

class AudioBottomSheet extends StatefulWidget {
  int index;
  String? source;
  List<AllMediaModel>? mediaAll;
  String eachMedia;
  void Function()? isPlaying;
  void Function()? isNext;
  void Function(AudioPlayer value)? onStopAndClose;

  AudioBottomSheet({
    super.key,
    required this.index,
    required this.mediaAll,
    required this.eachMedia,
    this.source = 'message',
    required this.isPlaying,
    required this.isNext,
    required this.onStopAndClose,
  });

  @override
  State<AudioBottomSheet> createState() => _AudioBottomSheetState();
}

class _AudioBottomSheetState extends State<AudioBottomSheet> {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  final AudioPlayerSingleton _audioPlayerSingleton = AudioPlayerSingleton();

  stopAndCloseBottomSheet() {
    print('HERE');
    _audioPlayer.stop();
    widget.onStopAndClose!(
      _audioPlayer,
    ); // Invoke the callback function in the parent widget
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (
          position,
          bufferedPosition,
          duration,
        ) =>
            PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(
      _playlist,
      initialIndex: widget.index,
      initialPosition: Duration.zero,
    );
  }

  double? downloadProgress = 0;
  bool hasStartedDownloading = false;

  Future<void> _downloadFile(
    String? url,
    String downloadFilename,
  ) async {
    hasStartedDownloading = true;
    successSnackBar('Downloading!', downloadFilename);
    setState(() {
      downloadProgress =
          0; // set progress to 0 for the corresponding media item
    });
    FileDownloader.downloadFile(
        url: '$url',
        onProgress: (filename, progress) {
          // Update the parameter name here
          setState(() {
            downloadProgress =
                progress; // update the progress for the corresponding media item
          });
        },
        onDownloadCompleted: (value) {
          successSnackBar(
            'Download Complete.',
            'Check your Download Folder to preview',
          );
          setState(() {
            hasStartedDownloading = false;
          });

          print('path $value');
          setState(() {
            downloadProgress =
                null; // set progress to null for the corresponding media item when download is complete
          });
        });
  }

  @override
  void initState() {
    super.initState();
    if (widget.source == 'home') {
      _audioPlayer = AudioPlayerSingletonE.instance; // Use the same instance

      _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
          tag: MediaItem(
            id: '1',
            title: '${widget.mediaAll?[widget.index].title}',
            artist: widget.mediaAll?[widget.index].name,
            artUri:
                Uri.parse('${widget.mediaAll?[widget.index].image?.secureUrl}'),
          ),
        ),
      );
    } else {
      _audioPlayer = AudioPlayerSingletonE.instance; // Use the same instance
      _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
          tag: MediaItem(
            id: '1',
            title: '${widget.mediaAll?[widget.index].title}',
            artist: widget.mediaAll?[widget.index].name,
            artUri:
                Uri.parse('${widget.mediaAll?[widget.index].image?.secureUrl}'),
          ),
        ),
      );

      // INIT PLAYLIST
      _playlist = ConcatenatingAudioSource(
        children: widget.mediaAll?.where((media) => media != null).map((media) {
              final audioSource = AudioSource.uri(
                Uri.parse('${media.audio?.secureUrl}'),
              );
              return AudioSource.uri(
                Uri.parse('${media.audio?.secureUrl}'),
                tag: MediaItem(
                  id: media.id.toString(),
                  title: '${media.title}',
                  artist: '${media.name}',
                  artUri: Uri.parse('${media.image?.secureUrl}'),
                ),
              );
            }).toList() ??
            [],
      );
      _init();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 20,
              child: SvgPicture.asset(
                AppIcons.topDash,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<SequenceState?>(
                        stream: _audioPlayer.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state?.sequence.isEmpty ?? true) {
                            return SizedBox();
                          }
                          final currentSource = state!.currentSource;
                          if (currentSource == null ||
                              currentSource.tag == null) {
                            return SizedBox();
                          }
                          if (currentSource.tag is! MediaItem) {
                            return SizedBox();
                          }
                          final metadata = currentSource.tag as MediaItem;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                metadata.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextThemes(context).getTextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${metadata.artist}',
                                overflow: TextOverflow.ellipsis,
                                style: TextThemes(context).getTextStyle(
                                  color: AppColors.secondaryTextColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          // widget.isPlaying;
                          _audioPlayer.stop();
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          AppIcons.close,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AudioControls(
                    audioPlayer: _audioPlayer,
                    isNext: widget.isNext,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //TIMELAPSE FRAME
                  Column(
                    children: [
                      StreamBuilder(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          final duration = positionData?.duration.inMilliseconds
                                  .toDouble() ??
                              0;
                          double value = positionData?.position.inMilliseconds
                                  .toDouble() ??
                              0;
                          if (value < 0) {
                            value = 0;
                          } else if (value > duration) {
                            value = duration;
                          }
                          final formattedPosition = positionData?.position !=
                                  null
                              ? '${positionData!.position.inMinutes}:${(positionData.position.inSeconds % 60).toString().padLeft(2, '0')}'
                              : '0:00';
                          final formattedDuration = positionData?.duration !=
                                  null
                              ? '${positionData!.duration.inMinutes}:${(positionData.duration.inSeconds % 60).toString().padLeft(2, '0')}'
                              : '0:00';

                          return Row(
                            children: [
                              Text(
                                '$formattedPosition',
                                style: TextThemes(context).getTextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 20.0,
                                  width: double.infinity,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 5.0,
                                      ),
                                      trackHeight: 1.5,
                                    ),
                                    child: Slider(
                                      activeColor: AppColors.primaryColor,
                                      inactiveColor:
                                          AppColors.placeHolderTextColor,
                                      min: 0,
                                      max: duration,
                                      value: value,
                                      onChanged: (value) {
                                        _audioPlayer.seek(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '$formattedDuration',
                                style: TextThemes(context).getTextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),

                  //END TIMELAPS
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder<SequenceState?>(
                          stream: _audioPlayer.sequenceStateStream,
                          builder: (context, snapshot) {
                            final state = snapshot.data;
                            if (state?.sequence.isEmpty ?? true) {
                              return SizedBox();
                            }
                            final currentSource = state!.currentSource;
                            if (currentSource == null ||
                                currentSource.tag == null) {
                              return SizedBox();
                            }
                            if (currentSource.tag is! MediaItem) {
                              return SizedBox();
                            }
                            final metadata = currentSource.tag as MediaItem;
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  hasStartedDownloading == true
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(200),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 0, 147, 76),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(300),
                                              ),
                                            ),
                                            child: Text(
                                              '${downloadProgress?.round()}%',
                                              style: TextThemes(context)
                                                  .getTextStyle(
                                                fontSize: 8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SmallFilledCircularButton(
                                          title: 'Download',
                                          onTaps: () {
                                            // final eachLinkAudio = widget.mediaAll
                                            //     ?.where((media) => media != null)
                                            //     .map((media) {
                                            //   return media;
                                            // }).toList() ??
                                            // [];
                                            // print('object');
                                            // successSnackBar(
                                            //   'Download Complete.',
                                            //   'Check your Download Folder to preview',
                                            // );

                                            _downloadFile(
                                              widget.mediaAll?[widget.index]
                                                      .audio?.secureUrl ??
                                                  '',
                                              '${metadata.title} by ${metadata.artist}',
                                            );
                                          },
                                        ),
                                ]);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferingPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferingPosition;
  final Duration duration;
}

class AudioControls extends StatelessWidget {
  AudioControls({
    Key? key,
    required this.audioPlayer,
    required this.isNext,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final void Function()? isNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: audioPlayer.seekToPrevious,
          child: SvgPicture.asset(
            AppIcons.prevTwo,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        InkWell(
          onTap: () {
            final currentPosition = audioPlayer.position;
            if (currentPosition != null && currentPosition.inSeconds >= 10) {
              audioPlayer.seek(Duration(seconds: -10));
            }
          },
          child: SvgPicture.asset(
            AppIcons.back,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (!(playing ?? false)) {
                  return InkWell(
                    onTap: audioPlayer.play,
                    child: SvgPicture.asset(
                      AppIcons.playTwo,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return InkWell(
                    onTap: audioPlayer.pause,
                    child: SvgPicture.asset(
                      AppIcons.pauseTwo,
                    ),
                  );
                } else if (processingState == ProcessingState.completed) {
                  return InkWell(
                    onTap: () {
                      audioPlayer.seek(Duration.zero);
                      audioPlayer.play();
                    },
                    child: SvgPicture.asset(
                      AppIcons.download,
                    ),
                  );
                } else if (processingState == ProcessingState.buffering) {
                  return SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                }
                return InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.pause,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          width: 25,
        ),
        InkWell(
          onTap: () {
            final totalDuration = audioPlayer.duration;
            final currentPosition = audioPlayer.position;
            if (totalDuration != null &&
                currentPosition != null &&
                currentPosition.inSeconds + 10 <= totalDuration.inSeconds) {
              audioPlayer.seek(Duration(seconds: 10));
            }
            isNext?.call();
          },
          child: SvgPicture.asset(
            AppIcons.forward,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        InkWell(
          onTap: () {
            audioPlayer.seekToNext();
            isNext?.call();
          },
          child: SvgPicture.asset(
            AppIcons.next,
          ),
        ),
      ],
    );
  }
}
