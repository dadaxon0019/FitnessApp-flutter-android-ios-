import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants/colors.dart';
import '../navigation/navigator_widget.dart';
import '../texts/app_medium_text.dart';

class TestMusic extends StatefulWidget {
  @override
  State<TestMusic> createState() => _TestMusic();
}

class _TestMusic extends State<TestMusic> {
  List videoinfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/music.json')
        .then((value) => {
              setState((() {
                videoinfo = json.decode(value);
              }))
            });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                color: Color(0xff1C1C1E),
              )
            : BoxDecoration(
                color: Color.fromARGB(255, 173, 173, 194),
                image: DecorationImage(
                    image: NetworkImage(videoinfo[_index]["imgUrl"]),
                    fit: BoxFit.cover),
              ),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 60, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 330,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://s.yimg.com/uu/api/res/1.2/YlIjPiQa5AE1uQ5pdMTYIQ--~B/Zmk9ZmlsbDtoPTQ1MDt3PTY3NTthcHBpZD15dGFjaHlvbg--/https://s.yimg.com/os/creatr-uploaded-images/2020-10/b358d480-19cf-11eb-bfed-0dd3d8eadb2d.cf.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            NavigatorWidget()));
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(48, 158, 158, 158),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: AppMeddiumText(
                                  color: Color.fromARGB(255, 243, 240, 240),
                                  text: 'Каждый день собираем для вас',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(videoinfo[_index]["imgUrl"]),
                                fit: BoxFit.cover)),
                        height: 360,
                        child: Column(
                          children: [
                            new BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color: Colors.white.withOpacity(0.0)),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            _contCard(context),
                            _controlView(context),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1C1C1E),
                ),
                child: Container(
                  child: Column(children: [
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Интересно сейчас',
                          style: TextStyle(
                              color: Color.fromARGB(240, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_outline,
                                size: 28,
                                color: Color.fromARGB(240, 255, 255, 255),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Expanded(
                      child: _listView(),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertTwo(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value?.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 5,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.grey,
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 1.5,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
              thumbColor: Color.fromARGB(253, 255, 255, 255),
              overlayColor: Color.fromARGB(255, 117, 85, 83).withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Color.fromARGB(254, 206, 209, 196),
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Color.fromARGB(254, 206, 209, 196),
              valueIndicatorTextStyle:
                  TextStyle(color: Color.fromARGB(154, 255, 255, 255))),
          child: Container(
            height: 25,
            width: 307,
            child: Slider(
              value: max(0, min(_progress * 100, 100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position?.toString().split('.')[0],
              onChanged: (value) {
                setState(() {
                  _progress = value * 0.01;
                });
              },
              onChangeStart: (value) {
                _controller?.pause();
              },
              onChangeEnd: (value) {
                final duration = _controller?.value?.duration;
                if (duration != null) {
                  var newValue = max(0, min(value, 99)) * 0.01;
                  var millis = (duration.inMilliseconds * newValue).toInt();
                  _controller?.seekTo(Duration(milliseconds: millis));
                  _controller?.play();
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(50, 0, 0, 0),
                      )
                    ]),
                    child: Icon(
                      noMute ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  _index = index;
                  if (index >= 0 && videoinfo.length >= 0) {
                    _initializeVideo(index);
                  } else {
                    Get.snackbar("Video List", '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromARGB(131, 208, 253, 62),
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Color.fromARGB(255, 129, 121, 121),
                        ),
                        messageText: Text(
                          'No videos ahead !',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ));
                  }
                },
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.fast_rewind,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                backgroundColor: Colors.transparent,
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  final index = _isPlayingIndex + 1;
                  if (index <= videoinfo.length - 1) {
                    _initializeVideo(index);
                    _index = index;
                  } else {
                    Get.snackbar("Video List", '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromARGB(131, 208, 253, 62),
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        messageText: Text(
                          'You have finished watchin all the videos. Congrats !',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ));
                  }
                },
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.fast_forward,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                '$mins:$secs',
                style: TextStyle(color: Colors.white, shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 1.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  )
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            'Preparing...',
            style: TextStyle(fontSize: 20, color: Colors.white60),
          ),
        ),
      );
    }
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }

    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('controller can not be itialized');
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoinfo[index]["mp3Url"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
  }

  _listView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: videoinfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _index = index;
            _onTapVideo(index);
            debugPrint(index.toString());
            setState(() {
              if (_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: _buildCard(index),
        );
      },
    );
  }

  _contCard(BuildContext context) {
    return Container(
      height: 230,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          (videoinfo[_index]["imgUrl"]),
        ),
      ),
      // child: Image(image: NetworkImage(videoinfo[_index]["imgUrl"])),
    );
  }

  _buildCard(int index) {
    return Container(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                        videoinfo[index]["imgUrl"],
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoinfo[index]["singerName"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(240, 255, 255, 255),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      videoinfo[index]["nameMusic"],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text(
                videoinfo[index]["duration"],
                style: TextStyle(color: whiteColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
