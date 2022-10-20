import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_auth_demo/main.dart';
import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

import '../navigation/navigator_widget.dart';
import '../utils/texts/app_medium_text.dart';

class StorageMusic extends StatefulWidget {
  @override
  State<StorageMusic> createState() => _StorageMusicState();
}

class _StorageMusicState extends State<StorageMusic> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();
  bool isPlayerControlsWidgetVisible = false;
  bool _isPlaying = false;

  List<SongModel> songs = [];
  String currentSongTitle = '';
  int currentIndex = 0;

  bool isPlayerViewVisible = false;

  void _changePlayerViewVisibility() {
    setState(() {
      isPlayerViewVisible = !isPlayerViewVisible;
    });
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          _player.positionStream,
          _player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    requestStoragePermission();

    _player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPlayerViewVisible) {
      return Scaffold(
        backgroundColor: mainColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 420,
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(0),
                  id: songs[currentIndex].id,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.fill,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 12.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: _changePlayerViewVisibility,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white70,
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Сейчас играет',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                          flex: 5,
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _changePlayerViewVisibility();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.list_alt,
                                color: Colors.white70,
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      margin: const EdgeInsets.only(top: 20, bottom: 120),
                      child: ClipRRect(
                        child: QueryArtworkWidget(
                          id: songs[currentIndex].id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentSongTitle,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        StreamBuilder<DurationState>(
                          stream: _durationStateStream,
                          builder: (context, snapshot) {
                            final durationState = snapshot.data;
                            final progress =
                                durationState?.position ?? Duration.zero;
                            final total = durationState?.total ?? Duration.zero;

                            return SizedBox(
                              width: 320,
                              child: ProgressBar(
                                progress: progress,
                                total: total,
                                barHeight: 2.5,
                                baseBarColor: Colors.grey,
                                bufferedBarColor:
                                    Colors.white.withOpacity(0.24),
                                progressBarColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                thumbColor: Color.fromARGB(255, 255, 255, 255),
                                thumbRadius: 5.0,
                                timeLabelTextStyle: TextStyle(
                                  fontSize: 0,
                                ),
                                onSeek: (duration) {
                                  _player.seek(duration);
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<DurationState>(
                          stream: _durationStateStream,
                          builder: (context, snapshot) {
                            final durationState = snapshot.data;

                            final progress =
                                durationState?.position ?? Duration.zero;
                            final total = durationState?.total ?? Duration.zero;
                            return SizedBox(
                              width: 320,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Text(
                                      progress.toString().split('.')[0],
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 13),
                                    ),
                                  ),
                                  Flexible(
                                      child: Text(
                                    total.toString().split('.')[0],
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 13),
                                  ))
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                _player.loopMode == LoopMode.one
                                    ? _player.setLoopMode(LoopMode.all)
                                    : _player.setLoopMode(LoopMode.one);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: StreamBuilder<LoopMode>(
                                  stream: _player.loopModeStream,
                                  builder: (context, snapshot) {
                                    final loopMode = snapshot.data;
                                    if (LoopMode.one == loopMode) {
                                      return Icon(
                                        Icons.repeat_one,
                                        color: whiteColor,
                                        size: 27,
                                      );
                                    }
                                    return Icon(
                                      Icons.repeat,
                                      color: whiteColor,
                                      size: 27,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.hasPrevious) {
                                  _player.seekToPrevious();
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.skip_previous,
                                  color: whiteColor,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.playing) {
                                  _player.pause();
                                } else {
                                  if (_player.currentIndex != null) {
                                    _player.play();
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: StreamBuilder<bool>(
                                  stream: _player.playingStream,
                                  builder: (context, snapshot) {
                                    bool? playingState = snapshot.data;
                                    if (playingState != null && playingState) {
                                      return Icon(
                                        Icons.pause,
                                        size: 50,
                                        color:
                                            Color.fromARGB(255, 111, 111, 111),
                                      );
                                    }
                                    return Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Color.fromARGB(255, 111, 111, 111),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.hasNext) {
                                  _player.seekToNext();
                                } else {
                                  if (_player.currentIndex != null) {
                                    _player.play();
                                  }
                                }
                              },
                              child: Container(
                                  child: Icon(
                                Icons.skip_next,
                                color: whiteColor,
                                size: 50,
                              )),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                _player.setShuffleModeEnabled(true);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.shuffle_outlined,
                                  color: whiteColor,
                                  size: 27,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
                                  builder: (context) => NavigatorWidget()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => StorageMusic()));
                        },
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
                  ),
                ],
              ),
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
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (item.data!.isEmpty) {
                    return const Center(
                      child: Text('No Songs Found'),
                    );
                  }
                  songs.clear();
                  songs = item.data!;
                  return ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          item.data![index].title,
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        subtitle: Text(
                          item.data![index].displayName,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                        ),
                        onTap: () async {
                          _changePlayerViewVisibility();
                          //await _player.setAudioSource(AudioSource.uri(
                          //  Uri.parse(item.data![index].uri!)));
                          await _player.setAudioSource(
                              createPlaylist(item.data),
                              initialIndex: index);
                          await _player.play();
                          _isPlaying = true;
                          print(_isPlaying);
                        },
                        onLongPress: () async {
                          await _player.setAudioSource(AudioSource.uri(
                              Uri.parse(item.data![index].uri!)));
                          await _player.pause();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel>? songs) {
    List<AudioSource> sources = [];

    for (var song in songs!) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
      }
    });
  }

  getDecoration(BoxShape shape, Offset offset, double blurRadius,
      double spreadRadius, Colors colors) {
    return BoxDecoration(color: mainColor, shape: shape, boxShadow: [
      BoxShadow(
          offset: offset,
          color: whiteColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius)
    ]);
  }

  getRectDecoration(BorderRadius borderRadius, Offset offset, double blurRadius,
      double spreadRadius) {
    return BoxDecoration(
        borderRadius: borderRadius,
        color: mainColor,
        boxShadow: [
          BoxShadow(
              offset: -offset,
              color: Colors.white24,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
          BoxShadow(
              offset: offset,
              color: Colors.black,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
        ]);
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
