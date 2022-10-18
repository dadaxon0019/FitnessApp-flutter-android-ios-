import 'dart:ui';

import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../navigation/navigator_widget.dart';
import '../utils/texts/app_medium_text.dart';

class StorageMusic extends StatefulWidget {
  @override
  State<StorageMusic> createState() => _StorageMusicState();
}

class _StorageMusicState extends State<StorageMusic> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Container(
          child: Column(
            children: [
              _isPlaying == false
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              StorageMusic()));
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
                    )
                  : Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // image: DecorationImage(
                              //     image:
                              //         NetworkImage(videoinfo[_index]["imgUrl"]),
                              //     fit: BoxFit.cover),
                              ),
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
                            ],
                          ),
                        ),
                      ],
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
                            await _player.setAudioSource(AudioSource.uri(
                                Uri.parse(item.data![index].uri!)));
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
          ),
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
}
