import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/database_utils/database_utils.dart';
import 'package:movies_app/models/movie_model.dart';

class WatchListItem extends StatefulWidget {
  Movie movie;

  WatchListItem(this.movie);

  @override
  State<WatchListItem> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<WatchListItem> {
  String img = 'https://image.tmdb.org/t/p/w500';
  int isSelected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMovieInFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "$img${widget.movie.posterPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 42,
                        )),
                  ),
                  Positioned(
                    child: InkWell(
                        onTap: () {
                          if (isSelected == 0) {
                            DatabaseUtils.DeletTask('${widget.movie.DataBaseId}');
                          }
                          setState(() {});
                        },
                        child: Image.asset('assets/bookmarkSelected.png')),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.movie.title}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.movie.releaseDate!.substring(0, 4)} ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.movie.overview} ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> checkMovieInFireStore() async {
    QuerySnapshot<Movie> temp =
    await DatabaseUtils.readMovieFormFirebase(widget.movie.id!);
    if (temp.docs.isEmpty) {
    } else {
      widget.movie.DataBaseId = temp.docs[0].data().DataBaseId;
      isSelected = 0;
      setState(() {});
    }
  }
}
