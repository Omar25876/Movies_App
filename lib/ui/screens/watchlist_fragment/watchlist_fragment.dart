import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/database_utils/database_utils.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/screens/search_fragment/search_widget.dart';

class WatchlistTab extends StatefulWidget {


  @override
  State<WatchlistTab> createState() => _WatchlistTabState();
}

class _WatchlistTabState extends State<WatchlistTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Movie>>(
      stream: DatabaseUtils.readMoviesFormFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<Movie> messages =
            snapshot.data?.docs.map((task) => task.data()).toList() ?? [];
        return  ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.grey,thickness: 1,),
          itemCount: messages.length,
          itemBuilder: (d, index) {
            return SearchWidget(messages[index]);
          },
        );
      },
    );
  }
}
