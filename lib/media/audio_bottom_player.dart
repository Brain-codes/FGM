// ignore_for_file: prefer_const_constructors

import 'package:FGM/media/model/all_media_model.dart';
import 'package:FGM/media/services/audio_player_service.dart';
import 'package:FGM/shared/constants/app_color.dart';
import 'package:FGM/shared/constants/app_icon.dart';
import 'package:FGM/shared/themes/text_theme.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class AudioBottomPlayer extends StatefulWidget {
  int index;
  String? source;
  List<AllMediaModel>? mediaAll;
  String eachMedia;
  void Function()? isPlaying;
  void Function()? isNext;
  AudioBottomPlayer({
    super.key,
    required this.index,
    required this.mediaAll,
    required this.eachMedia,
    this.source = 'message',
    required this.isPlaying,
    required this.isNext,
  });

  @override
  State<AudioBottomPlayer> createState() => _AudioBottomPlayerState();
}

class _AudioBottomPlayerState extends State<AudioBottomPlayer> {
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  final AudioPlayerSingleton _audioPlayerSingleton = AudioPlayerSingleton();

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

  // @override
  // void initState() {
  //   super.initState();
  //   _audioPlayer = _audioPlayerSingleton.audioPlayer;
  //   if (widget.source == 'home') {
  //     _audioPlayer
  //       ..setAudioSource(
  //         AudioSource.uri(
  //           Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
  //           tag: MediaItem(
  //             id: '1',
  //             title:
  //                 '${widget.mediaAll?[widget.index].title} - ${widget.mediaAll?[widget.index].name}',
  //             artist: widget.mediaAll?[widget.index].name,
  //             artUri: Uri.parse(
  //                 '${widget.mediaAll?[widget.index].image?.secureUrl}'),
  //           ),
  //         ),
  //       );
  //   } else {
  //     Future.delayed(Duration(seconds: 2), () {
  //       _init();
  //     });
  //   }
  // }

  // Future<void> _init() async {
  //   await _audioPlayer.setLoopMode(LoopMode.all);
  //   await _audioPlayer.setAudioSource(
  //     AudioSource.uri(
  //       Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
  //       tag: MediaItem(
  //         id: '1',
  //         title:
  //             '${widget.mediaAll?[widget.index].title} - ${widget.mediaAll?[widget.index].name}',
  //         artist: widget.mediaAll?[widget.index].name,
  //         artUri:
  //             Uri.parse('${widget.mediaAll?[widget.index].image?.secureUrl}'),
  //       ),
  //     ),
  //     initialIndex: widget.index,
  //     initialPosition: Duration.zero,
  //   );
  // }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(
      _playlist,
      initialIndex: widget.index,
      initialPosition: Duration.zero,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.source == 'home') {
      _audioPlayer = AudioPlayer()
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
            tag: MediaItem(
              id: '1',
              title:
                  '${widget.mediaAll?[widget.index].title} - ${widget.mediaAll?[widget.index].name}',
              artist: widget.mediaAll?[widget.index].name,
              artUri: Uri.parse(
                  '${widget.mediaAll?[widget.index].image?.secureUrl}'),
            ),
          ),
        );
    } else {
      _audioPlayer = AudioPlayer()
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse('${widget.mediaAll?[widget.index].audio?.secureUrl}'),
            tag: MediaItem(
              id: '1',
              title:
                  '${widget.mediaAll?[widget.index].title} - ${widget.mediaAll?[widget.index].name}',
              artist: widget.mediaAll?[widget.index].name,
              artUri: Uri.parse(
                  '${widget.mediaAll?[widget.index].image?.secureUrl}'),
            ),
          ),
        );
      // _audioPlayer = AudioPlayer()..setUrl(widget.eachMedia);

      //INIT PLAYLIST
      _playlist = ConcatenatingAudioSource(
        children: widget.mediaAll?.where((media) => media != null).map((media) {
              final audioSource = AudioSource.uri(
                Uri.parse('${media.audio?.secureUrl}'),
              );
              return AudioSource.uri(
                Uri.parse('${media.audio?.secureUrl}'),
                tag: MediaItem(
                  id: media.id.toString(),
                  title: '${media.title} - ${media.name}',
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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<SequenceState?>(
            stream: _audioPlayer.sequenceStateStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state?.sequence.isEmpty ?? true) {
                return SizedBox();
              }
              final currentSource = state!.currentSource;
              if (currentSource == null || currentSource.tag == null) {
                return SizedBox();
              }
              if (currentSource.tag is! MediaItem) {
                return SizedBox();
              }
              final metadata = currentSource.tag as MediaItem;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    metadata.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextThemes(context).getTextStyle(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                  InkWell(
                    onTap: widget.isPlaying,
                    child: SvgPicture.asset(
                      AppIcons.close,
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Controls(
                audioPlayer: _audioPlayer,
                isNext: widget.isNext,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    final duration =
                        positionData?.duration?.inMilliseconds?.toDouble() ?? 0;
                    double value =
                        positionData?.position?.inMilliseconds?.toDouble() ?? 0;
                    if (value < 0) {
                      value = 0;
                    } else if (value > duration) {
                      value = duration;
                    }
                    final formattedPosition = positionData?.position != null
                        ? '${positionData!.position.inMinutes}:${(positionData.position.inSeconds % 60).toString().padLeft(2, '0')}'
                        : '0:00';
                    final formattedDuration = positionData?.duration != null
                        ? '${positionData!.duration.inMinutes}:${(positionData.duration.inSeconds % 60).toString().padLeft(2, '0')}'
                        : '0:00';

                    return Row(
                      children: [
                        Text(
                          '$formattedPosition',
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
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
                                inactiveColor: AppColors.placeHolderTextColor,
                                min: 0,
                                max: duration,
                                value: value,
                                onChanged: (value) {
                                  _audioPlayer.seek(
                                      Duration(milliseconds: value.toInt()));
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '$formattedPosition',
                          style: TextThemes(context).getTextStyle(
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                AppIcons.download,
              ),
            ],
          ),
        ],
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

class Controls extends StatelessWidget {
  Controls({
    super.key,
    required this.audioPlayer,
    required this.isNext,
  });
  final AudioPlayer audioPlayer;
  void Function()? isNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: audioPlayer.seekToPrevious,
          child: SvgPicture.asset(
            AppIcons.prev,
          ),
        ),
        SizedBox(
          width: 10,
        ),
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
                  AppIcons.play,
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return InkWell(
                onTap: audioPlayer.pause,
                child: SvgPicture.asset(
                  AppIcons.pause,
                ),
              );
            } else if (processingState == ProcessingState.completed) {
              return InkWell(
                onTap: () {
                  audioPlayer.seek(Duration.zero);
                  audioPlayer.play;
                },
                child: SvgPicture.asset(
                  AppIcons.download,
                ),
              );
            } else if (processingState == ProcessingState.buffering) {
              return SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
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
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            isNext!();
            audioPlayer.seekToNext();
          },
          child: SvgPicture.asset(
            AppIcons.next,
          ),
        ),
      ],
    );
  }
}
