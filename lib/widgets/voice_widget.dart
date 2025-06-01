import 'package:flutter/material.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/helpers/sound_helper.dart';
import 'package:base_project/widgets/app_text.dart';

class GeneralVoiceWidget extends StatefulWidget {
  final String voice;
  final bool isMe;
  final SoundHelper messagesSoundHelper;
  final SoundHelper? recordSoundHelper;
  final Function()? onRecording;
  final double? width;
  const GeneralVoiceWidget({
    super.key,
    required this.voice,
    required this.isMe,
    required this.messagesSoundHelper,
    this.recordSoundHelper,
    this.onRecording,
    this.width,
  });

  @override
  State<GeneralVoiceWidget> createState() => _GeneralVoiceWidgetState();
}

class _GeneralVoiceWidgetState extends State<GeneralVoiceWidget> {
  bool get isThisWidgetPlaying =>
      widget.messagesSoundHelper.recordingPath == widget.voice;

  double get currentDuration =>
      sliderValue ??
      (widget.messagesSoundHelper.recordingPath == widget.voice
          ? widget.messagesSoundHelper.player?.position.inMilliseconds
                  .toDouble() ??
              0
          : 0.0);
  double? maxDuration;
  double? sliderValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: widget.width,
      child: Row(
        children: [
          InkWell(
            child: Icon(
              widget.messagesSoundHelper.isPlaying && isThisWidgetPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: widget.isMe ? Colors.white : AppColors.primary,
            ),
            onTap: () async {
              if (widget.recordSoundHelper?.isRecording ?? false) {
                await widget.recordSoundHelper?.stopRecording();
              }
              if (widget.recordSoundHelper?.isPlaying ?? false) {
                await widget.recordSoundHelper?.stopPlaying();
              }
              if (widget.messagesSoundHelper.isPlaying && isThisWidgetPlaying) {
                sliderValue = widget
                    .messagesSoundHelper.player?.position.inMilliseconds
                    .toDouble();
                await widget.messagesSoundHelper.stopPlaying();
              } else {
                if (widget.messagesSoundHelper.recordingPath != widget.voice) {
                  await widget.messagesSoundHelper.stopPlaying();
                  await widget.messagesSoundHelper
                      .setUrl(widget.voice, widget.voice.contains("http"));
                  await widget.messagesSoundHelper.player?.seek(Duration.zero);
                }
                sliderValue = null;
                await widget.messagesSoundHelper
                    .playRecording(isUrl: widget.voice.contains("http"));
              }
              setState(() {});
              widget.onRecording?.call();
            },
          ),
          Expanded(
            child: Row(
              children: [
                StreamBuilder<Duration>(
                  stream: widget.messagesSoundHelper.player?.positionStream,
                  builder: (context, snapshot) {
                    if (!isThisWidgetPlaying) sliderValue = null;
                    if (widget.messagesSoundHelper.player?.duration != null &&
                        snapshot.data != null &&
                        snapshot.data! != Duration.zero &&
                        widget.messagesSoundHelper.player!.duration !=
                            Duration.zero &&
                        snapshot.data! >=
                            (widget.messagesSoundHelper.player!.duration! -
                                Duration(milliseconds: 20))) {
                      widget.messagesSoundHelper.stopPlaying();
                      widget.messagesSoundHelper.player?.seek(Duration.zero);
                      widget.onRecording?.call();
                    }
                    if (widget.messagesSoundHelper.player?.duration != null &&
                        widget.messagesSoundHelper.player!.duration !=
                            Duration.zero)
                      maxDuration = (widget.messagesSoundHelper.player?.duration
                                  ?.inMilliseconds
                                  .toDouble() ??
                              0) +
                          100;
                    return Slider(
                      value: currentDuration,
                      activeColor:
                          widget.isMe ? Colors.white : AppColors.primary,
                      inactiveColor: widget.isMe
                          ? Colors.white.withOpacity(0.5)
                          : AppColors.primary.withOpacity(0.5),
                      onChangeStart: (value) async {
                        if (widget.messagesSoundHelper.isPlaying) {
                          await widget.messagesSoundHelper.stopPlaying();
                        }
                        if (!isThisWidgetPlaying) {
                          await widget.messagesSoundHelper.setUrl(
                              widget.voice, widget.voice.contains("http"));
                        }
                        setState(() {
                          sliderValue = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                      onChangeEnd: (v) async {
                        if (!isThisWidgetPlaying) {
                          await widget.messagesSoundHelper.setUrl(
                              widget.voice, widget.voice.contains("http"));
                          return;
                        }
                        await widget.messagesSoundHelper.playRecording();
                        await widget.messagesSoundHelper.player
                            ?.seek(Duration(milliseconds: v.toInt()));
                        sliderValue = null;
                        setState(() {});
                      },
                      min: 0,
                      max: maxDuration ?? 0,
                    );
                  },
                ),
                //timer indicator
                StreamBuilder<Duration>(
                  stream: widget.messagesSoundHelper.player?.positionStream,
                  builder: (context, snapshot) {
                    final position = isThisWidgetPlaying
                        ? widget.messagesSoundHelper.player?.position ??
                            Duration.zero
                        : Duration.zero;
                    return AppText(
                      title:
                          "${(position.inMinutes % 60).toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                      color: widget.isMe ? Colors.white : AppColors.primary,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
