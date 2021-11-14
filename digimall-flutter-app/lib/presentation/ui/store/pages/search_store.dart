import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/ui/store/widgets/store_tile.dart';
import 'package:prachar/constants/constants.dart';
import 'package:prachar/presentation/core/styles/colors.dart';

enum SearchStoreType {
  name,
  area,
}

class SearchStorePage extends StatefulWidget {
  final SearchStoreType searchStoreType;
  final bool searchSavedStore;
  const SearchStorePage({
    Key key,
    @required this.searchStoreType,
    @required this.searchSavedStore,
  }) : super(key: key);

  @override
  _SearchStorePageState createState() => _SearchStorePageState();
}

class _SearchStorePageState extends State<SearchStorePage> {
  String searchQuery = "";
  bool _isSearching = true;
  final _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : const Text(
                SEARCH_STORE,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: _buildActions(),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff252733)),
      ),
      body: Column(children: [
        const Divider(
          thickness: 1,
          color: Kolors.primaryBackgroundColor,
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Kolors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: storesList(),
              )),
        ),
      ]),
    );
  }

  Widget storesList() {
    final auth = FirebaseAuth.instance;
    Query query = FirebaseFirestore.instance.storesCollection
        .orderBy(
      widget.searchStoreType == SearchStoreType.area
          ? 'searchAreaKey'
          : 'searchKey',
    )
        .startAt([searchQuery]).endAt(['$searchQuery\uf8ff']);
    if (widget.searchSavedStore) {
      query = query.where('savedBy', arrayContains: auth.currentUser.uid);
    }

    return StreamBuilder(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length as int,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  final DocumentSnapshot doc =
                      snapshot.data.docs[index] as DocumentSnapshot;
                  final Store store = Store.fromJson(doc.data());
                  return SearchStoreTile(
                    store: store,
                  );
                })
            : Container();
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search stores...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      style: const TextStyle(color: Colors.black38, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(_searchQueryController.text),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
