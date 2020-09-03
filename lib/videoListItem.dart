import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'video.dart';

class VideoListItem extends StatefulWidget{

  final Video video;
  final context;
  VideoListItem({this.video,this.context});
  @override
  State<StatefulWidget> createState()=>VideoListItemState();
}

class VideoListItemState extends State<VideoListItem>{

  Video video;var context;
  @override
  void initState() {
    super.initState();
    video=widget.video;
    context=widget.context;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: ListTile(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => VideoPage(video)));
          },
          leading: Image.network(video.thumbnailUrl),
          title: Text(video.title),
          trailing: GestureDetector(
            child: Icon(Icons.star,
                      color: (video.favorite?Colors.yellow:Theme.of(context).iconTheme),
                      ),
            onTap: (){
              setState(() {
                video.favorite=!video.favorite;
              });
            },
          )
        ),
      ),
    );
  }
}