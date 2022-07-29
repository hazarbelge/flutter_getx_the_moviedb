import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController? _controller;
  bool _isPlaying = true;
  bool _isMuted = false;
  bool _isTapped = true;

  @override
  void initState() {
    _controller = null;
    super.initState();
    if (_controller == null)
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          _controller!.play();
          setState(() {});
        });
    else {
      _controller = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SizedBox(
        height: Get.context?.height ?? Get.height,
        width: double.infinity,
        child: Center(
          child: _controller != null
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: SizedBox(
                    width: Get.context?.width ?? Get.width,
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                _isTapped = !_isTapped;
                              });
                            }
                          },
                          child: _controller!.value.isInitialized ? VideoPlayer(_controller!) : const SizedBox(),
                        ),
                        Positioned(
                          bottom: 0,
                          child: _isTapped
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                      width: Get.context?.width ?? Get.width,
                                      child: VideoProgressIndicator(
                                        _controller!,
                                        allowScrubbing: true,
                                        colors: VideoProgressColors(
                                          playedColor: Colors.red[800]!,
                                          bufferedColor: Colors.grey,
                                          backgroundColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: Get.context?.width ?? Get.width,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Icon(
                                              _isPlaying ? Icons.pause : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _isPlaying ? _controller!.pause() : _controller!.play();
                                                _isPlaying = !_isPlaying;
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 5),
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: const Icon(
                                              Icons.skip_next_outlined,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                            onTap: () async {
                                              final Duration? pos = await _controller!.position;
                                              if (pos != null) {
                                                _controller!.seekTo(pos + const Duration(seconds: 10));
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 5),
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Icon(
                                              _isMuted ? Icons.volume_off : Icons.volume_up_outlined,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _controller!.setVolume(_isMuted ? 1.0 : 0.0);
                                                _isMuted = !_isMuted;
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          ValueListenableBuilder<VideoPlayerValue>(
                                            valueListenable: _controller!,
                                            builder: (BuildContext context, VideoPlayerValue value, Widget? widgetValue) {
                                              return Text(
                                                "${context.printDuration(value.position)} / ${context.printDuration(value.duration)}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[300],
                                                ),
                                              );
                                            },
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
