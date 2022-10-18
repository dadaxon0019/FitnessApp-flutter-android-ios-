import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class StorageMusic extends StatefulWidget {
  @override
  State<StorageMusic> createState() => _StorageMusicState();
}

class _StorageMusicState extends State<StorageMusic> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
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
                title: Text(item.data![index].title),
                subtitle: Text(item.data![index].displayName),
                trailing: const Icon(Icons.more_vert),
                leading: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                ),
                onTap: () async {
                  await _player.setAudioSource(
                      AudioSource.uri(Uri.parse(item.data![index].uri!)));
                  await _player.play();
                },
                onLongPress: () async {
                  await _player.setAudioSource(
                      AudioSource.uri(Uri.parse(item.data![index].uri!)));
                  await _player.pause();
                },
              );
            },
          );
        },
      ),
    );
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
