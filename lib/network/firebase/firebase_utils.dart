import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirebaseRef {
  FirebaseRef._();
  static final FirebaseRef instance = FirebaseRef._();
  factory FirebaseRef() => instance;



  //todo this for hide/show wallet and plan manually
  Future<bool> isHideSocial()async{
    var documentReference = FirebaseFirestore.instance.collection("condition").doc("condition");
    var documentSnapshot = await documentReference.get();
    var data = documentSnapshot.data();
    Logger().d(data);
    return data?["hide_social"]??false;
  }

  Future<Map<String , dynamic>?> adminList()async{
    var documentReference = FirebaseFirestore.instance.collection("condition").doc("condition");
    var documentSnapshot = await documentReference.get();
    var data = documentSnapshot.data();
    return data;
  }

}