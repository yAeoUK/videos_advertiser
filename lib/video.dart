import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'main.dart';

class VideoPage extends StatefulWidget{

  final Video video;
  VideoPage(this.video);
  @override
  State<StatefulWidget> createState()=>VideoPageState();
}

class VideoPageState extends State<VideoPage> {

  Video video;
  VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    video=widget.video;
    videoController = VideoPlayerController.network(
        'https://www.youtube-nocookie.com/embed/${video.videoId}')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Column(
        children: <Widget>[
             videoController.value.initialized
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : Container(),
          ],
      ),
    );
  }
}