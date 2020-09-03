import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loadMore.dart';
import 'main.dart';
import 'post.dart';
import 'videoListItem.dart';

// ignore: must_be_immutable
class VideoListPage extends StatefulWidget{
  var favorite=false;
  Channel channel;
  VideoListPage({this.channel});
  @override
  State<StatefulWidget> createState()=>VideoListPageState();
  }

  class VideoListPageState extends State<VideoListPage>{
    var favorite;
    Channel channel;
    List<Video> videos=List<Video>();
    @override
  void initState() {
    super.initState();
    favorite=widget.favorite;
    channel=widget.channel;
  }

  void loadData(BuildContext context)async{
    var map=Map();
                  map['channelId']=channel.url;
                  map['skip']=videos.length;
                  Post p=Post(context,'getVideos.php',map);
                  await p.fetchPost();
                  if(!p.connectionSucceed)return;
                  var dataString=p.result;
                  var dataJSON= json.decode(dataString);
                  for(var c=0;c<dataJSON.length;c++){
                    var videoJSON=dataJSON[c];
                    var video=Video(
                        title: videoJSON['title'],
                        thumbnailUrl: videoJSON['thumbnailUrl'],
                        videoId: videoJSON['videoId']
                      );
                    videos.add(video);
                  }
                  setState(() {
                    
                  });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channel.name),
      ),
      body: Column(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index)=>VideoListItem(context:context,video:videos[index])
              ),
              (!favorite)?LoadMore(
                loading: true,
                onClick: ()async{
                  loadData(context);
                }
              ):Container()
            ],
          )
        ],
      ),
    );
  }
}