// import 'dart:async';
// import 'dart:developer';
// import 'dart:html';


// import 'package:flutter/material.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   // Location _locationController = new Location();

//   // final Completer<GoogleMapController> _mapController =
//   //     Completer<GoogleMapController>();

//   // static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
//   // static const LatLng _pApplePlex = LatLng(37.3346, -122.0090);
//   // LatLng? _currentP = null;

//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: IconButton(
//         icon: Icon(Icons.abc),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return Home_Screen();
//             },
//           ));
//         },
//       ),
//       body: FirebaseServices.currentP == null
//           ? const Center(
//               child: Text('Loading...'),
//             )
//           : GoogleMap(
//               // focus current location
//               onMapCreated: ((GoogleMapController controller) =>
//                   FirebaseServices.mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                   target: FirebaseServices.pGooglePlex, zoom: 13),
//               markers: {
//                   Marker(
//                       markerId: MarkerId("_currentLocation"),
//                       icon: BitmapDescriptor.defaultMarker,
//                       position: FirebaseServices.currentP!),
//                   Marker(
//                       markerId: MarkerId("_sourceLocation"),
//                       icon: BitmapDescriptor.defaultMarker,
//                       position: FirebaseServices.pGooglePlex),
//                   Marker(
//                       markerId: MarkerId("_destinationLocation"),
//                       icon: BitmapDescriptor.defaultMarker,
//                       position: FirebaseServices.pApplePlex),
//                 }),
//     );
//   }

//   // pointing camera on current mark location
//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller =
//         await FirebaseServices.mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
//     await controller
//         .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
//   }

//   Future getLocationUpdates() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled =
//         await FirebaseServices.locationController.serviceEnabled();
//     if (_serviceEnabled) {
//       _serviceEnabled =
//           await FirebaseServices.locationController.requestService();
//     } else {
//       return;
//     }

//     _permissionGranted =
//         await FirebaseServices.locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted =
//           await FirebaseServices.locationController.requestPermission();
//     }
//     if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//     FirebaseServices.locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.altitude != null) {
//         setState(() {
//           FirebaseServices.currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _cameraToPosition(FirebaseServices.currentP!);

//           log('$FirebaseServices.currentP!');
//         });
//       }
//     });
//   }
// }







// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:flutter/cupertino.dart';

// import 'package:food_panda/Apis/model/chat_model.dart';
// import 'package:food_panda/home_screen.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// import 'package:location/location.dart';
// import 'package:mechanic_app/homescreen.dart';

// // import 'package:http/http.dart' as http;

// class FirebaseServices {
//   // check login
//   static bool isLogin = false;
//   // updated profile message
//   static bool updated = false;

//   // Authentication
//   static FirebaseAuth auth = FirebaseAuth.instance;

//   // accessing firestore
//   // static FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // current user
//   static User get user => auth.currentUser!;

//   // Group members selection
//   static bool MemberisSelect = false;

//   // accessing firebase message (Push notificatio)
//   static FirebaseMessaging fmessaging = FirebaseMessaging.instance;
//   // FCM TOKEN
//   static String? fCMToken;

//   static final firestore = FirebaseFirestore.instance;
//   // map

//   static Location locationController = new Location();

//   static final Completer<GoogleMapController> mapController =
//       Completer<GoogleMapController>();

//   static const LatLng pGooglePlex = LatLng(37.4223, -122.0848);
//   static const LatLng pApplePlex = LatLng(37.3346, -122.0090);
//   static LatLng? currentP = null;

//   // getting Firebase Token
//   static Future<void> gettingFirebaseTokens() async {
//     await fmessaging.requestPermission();

//     fCMToken = await fmessaging.getToken();
//     log('Token $fCMToken');
//     getActiveStatus(true);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log('Got a message whilst in the foreground!');
//       log('Message data: ${message.data}');

//       if (message.notification != null) {
//         log('Message also contained a notification: ${message.notification}');
//       }
//     });
//   }

//   // update active status
//   static Future<void> getActiveStatus(bool isOnline) async {
//     firestore.collection('users').doc(user.uid).update({
//       'is_online': isOnline,
//       'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
//       'pushToken': fCMToken
//     });
//   }

//   static ChatUsers me = ChatUsers(
//       id: user.uid,
//       name: user.displayName.toString(),
//       email: user.email.toString(),
//       about: "Hey, I'm using We Chat!",
//       image: user.photoURL.toString(),
//       isOnline: false,
//       lastActive: '',
//       pushToken: '');

//   static String? accessToken1;

// //   static Future<void> gettingFirebaseToken() async {
// //   NotificationSettings settings = await messaging.requestPermission();
// //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// //     fCMToken = await messaging.getToken();
// //     print('Token: $fCMToken');
// //   } else {
// //     print('User denied permission');
// //   }
// // }

//   static signUpUser(String userName, String userEmail) async {
//     try {
//       await firestore.collection('users').doc(user.uid).set({
//         'name': userName,
//         'email': userEmail,
//         'createdDate': (DateTime.now()),
//         'userID': user.uid,
//       });
//     } on FirebaseAuthException catch (e) {
//       print("Error $e");
//     }
//   }

//   // check Login user exist or not (Google login)
//   static Future<bool> userExist() async {
//     return (await (firestore
//             .collection('users')
//             .doc(auth.currentUser!.uid)
//             .get()))
//         .exists;
//   }

//   // create Google user
//   static Future<void> createUserGoogle() async {
//     final time = DateTime.now().millisecondsSinceEpoch.toString();
//     ChatUsers gUser = ChatUsers(
//         name: user.displayName.toString(),
//         email: user.email.toString(),
//         id: user.uid.toString(),
//         about: "Available",
//         isOnline: false,
//         lastActive: time,
//         pushToken: '',
//         image: user.photoURL.toString());
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .set(gUser.toJson());
//   }

//   // Google btn handle
//   static loginWithGoogle(BuildContext context) {
//     try {
//       signInWithGoogle().then((user) async {
//         if (await userExist()) {
//           // getActiveStatus(true);

//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Home(),
//               ));

//           return isLogin = true;
//         } else {
//           await FirebaseServices.createUserGoogle().then((value) {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Home(),
//                 ));
//           });
//           return isLogin = true;
//         }
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   static Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
