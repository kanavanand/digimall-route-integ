import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prachar/domain/auth/store.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/search_widget.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/store/pages/discovery.dart';
import 'package:prachar/presentation/ui/store/pages/search_store.dart';
import 'package:prachar/presentation/ui/store/widgets/store_tile.dart';
import 'package:prachar/infrastructure/core/firebase_helpers.dart';
import 'package:prachar/presentation/core/widgets/button.dart';

class SavedStoresPage extends StatelessWidget {
  final Function changeTabFunction;
  const SavedStoresPage({Key key, this.changeTabFunction}) : super(key: key);

  Widget storesList() {
    final auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.storesCollection
          .where('savedBy', arrayContains: auth.currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? snapshot.data.docs.length as int > 0
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
                : SizedBox(
                    height: MediaQuery.of(context).size.height + 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('No store added'),
                        Text('Click on the link shared to add store'),
                        Image.asset(
                          'assets/images/shop.png',
                          height: 200,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            changeTabFunction();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Kolors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Explore Stores",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchTEC = TextEditingController();
    var _card = Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 70,
            height: 50,
            child: Center(
              child: Text(
                'Discount',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));

    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Saved Stores",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Kolors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      Image.asset("assets/images/delivery_boy.png")
                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child:Row(
                  //         children: [
                  //           _card,_card,_card,_card,_card,_card,_card,_card,_card
                  //         ],
                  //       )),
                  // ),
                  SearchWidget(
                    hint: "Store name",
                    text: "",
                    onPressed: () {
                      ExtendedNavigator.of(context).push(Routes.searchStorePage,
                          arguments: SearchStorePageArguments(
                              searchStoreType: SearchStoreType.name,
                              searchSavedStore: true));
                    },
                  ),
                ],
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
