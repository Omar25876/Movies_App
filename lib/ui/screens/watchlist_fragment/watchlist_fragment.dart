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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(18, 19, 18, 1.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('WatchList',style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Movie>>(
                stream: DatabaseUtils.readMoviesFormFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(
                      color: Color.fromRGBO(255, 187, 59, 1.0),
                    ));
                  }
                  List<Movie> messages =
                      snapshot.data?.docs.map((task) => task.data()).toList() ?? [];
                  return  ListView.separated(
                    separatorBuilder: (context, index) => Divider(color: Colors.grey,thickness: 1,),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {

                      return SearchWidget(messages[index]);

                    },

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
