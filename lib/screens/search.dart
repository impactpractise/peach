import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/activity_feed.dart';
import 'package:peach/widgets/loading.dart';

import 'home.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>
    with AutomaticKeepAliveClientMixin<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleUserSearch(String query) {
    clearSearch();
    Future<QuerySnapshot> users = usersRef
        .where('displayName', isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: TextFormField(
        controller: searchController,
        cursorColor: Color(0xFFFF2660),
        decoration: InputDecoration(
          hintText: "Search for a user...",
          prefixIcon: Icon(
            Icons.account_box,
            size: 25,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                //TODO remove focus when cleared
                Icons.clear,
              ),
              onPressed: () => clearSearch()),
        ),
        onFieldSubmitted: handleUserSearch,
      ),
    );
  }

  buildNoContent() {
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 400 : 250,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    //TODO Dynamic search: refactor into StreamBuilder
    return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress(context);
          }
          List<UserResult> searchResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocument(doc);
            UserResult searchResult = UserResult(user);
            searchResults.add(searchResult);
          });
          return ListView(children: searchResults);
        });
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => showUserProfile(context, profileId: user.id),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(
                user.name,
                style: TextStyle(
                  color: Color(0xFFFF2660),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle:
                  Text(user.username, style: TextStyle(color: Colors.black38)),
            ),
          ),
          Divider(height: 2.0, color: Colors.black12),
        ],
      ),
    );
  }
}
