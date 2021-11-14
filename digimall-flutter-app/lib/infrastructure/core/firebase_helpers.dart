import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

extension FirestoreX on FirebaseFirestore {
  CollectionReference get userCollection => collection('Users');
  CollectionReference get storesCollection => collection('Stores');
  CollectionReference get allOrdersCollection => collection('Orders');
  CollectionReference get assetsCollection => collection('Assets');
}

extension StorageReferenceX on Reference {
  Reference get storageRef => FirebaseStorage.instance.ref();
  Reference get storeImages => storageRef.child('Stores Images');
}

extension DocumentReferenceX on DocumentReference {
  //in chatRoom collection
  CollectionReference get chatsCollection => collection('Chats');
  CollectionReference get productsCollection => collection('Products');
  CollectionReference get ordersCollection => collection('Orders');
  CollectionReference get userOrdersCollection => collection('UserOrders');
}
