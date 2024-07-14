import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mechanic_app/addnote.dart';
import 'package:mechanic_app/imagepicker.dart';
import 'package:mechanic_app/taskmodel.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddTasks extends StatefulWidget {
  AddTasks({Key? key}) : super(key: key);

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  bool photo = true;
  bool barcode = false;

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];

    for (File image in images) {
      String id = const Uuid().v4();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images').child('$id.png');

      try {
        // Upload image to Firebase Storage
        await ref.putFile(image);

        // Get download URL of uploaded image
        String imageUrl = await ref.getDownloadURL();
        downloadUrls.add(imageUrl);
      } catch (e) {
        print('Error uploading image: $e');
        // Handle error as per your application's requirement
      }
    }

    return downloadUrls;
  }

  String barcodeScanRes = '';

  Future<void> scanBarcode() async {
    String barcodeScanResult;
    try {
      barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color for Android toolbar (Android only)
        'Cancel', // Button text for Android toolbar (Android only)
        true, // Show flash icon (Android only)
        ScanMode.DEFAULT, // Scan mode (Android only)
      );

      setState(() {
        barcodeScanRes = barcodeScanResult;
      });
      if (barcodeScanRes.isNotEmpty) {
        // Barcode scanned successfully, handle the result
        // Example: Navigate to a screen or perform an action with the scanned barcode
        print('Barcode scanned: $barcodeScanRes');
      } else {
        // Handle case where barcode scan was unsuccessful
        print('Barcode scan failed');
      }
    } catch (e) {
      // Handle errors from barcode scanner plugin
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: media.size.height * 0.04,
                width: media.size.height * 0.04,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 19, 18, 18),
                    width: media.size.height * 0.0002,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(media.size.height * 0.03),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: media.size.height * 0.1 * 1.2,
            ),
            Text(
              photo ? 'Take a Photo' : 'Barcode Scan',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: media.size.height * 0.07,
            ),
            Consumer<ImagePickerProvider>(builder: (context, pro, _) {
              return InkWell(
                onTap: () async {
                  if (pro.photo!.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Addnote(
                                  image: pro.photo!,
                                )));
                    // List url = await uploadImages(pro.photo!);
                    // Taskmodel model = Taskmodel(photo: url);
                    // String id = Uuid().v4();
                    // await FirebaseFirestore.instance
                    //     .collection('tasks')
                    //     .doc(id)
                    //     .set(model.tomap());
                  }
                },
                child: Container(
                  height: media.size.height * 0.04,
                  width: media.size.height * 0.04,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 19, 18, 18),
                      width: media.size.height * 0.0002,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(media.size.height * 0.03),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      body: Column(
        children: [
          barcode
              ? Expanded(
                  child: Container(
                  child: Text(
                    barcodeScanRes,
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              : Expanded(
                  child: Consumer<ImagePickerProvider>(
                    builder: (context, provider, _) {
                      if (provider.photo != null &&
                          provider.photo!.isNotEmpty) {
                        return Container(
                          child: Image.file(
                            provider.photo!.last,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'No image selected',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    },
                  ),
                ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(),
                  fixedSize: Size(
                    media.size.height * 0.2 * 1.2,
                    media.size.height * 0.1,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    photo = false;
                    barcode = true;
                    scanBarcode();
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: media.size.height * 0.02,
                    ),
                    Icon(
                      Icons.qr_code_scanner_sharp,
                      color: barcode
                          ? Colors.blue[600]
                          : Color.fromARGB(255, 188, 181, 181),
                      size: media.size.height * 0.04,
                    ),
                    Text(
                      'Barcode Scan',
                      style: TextStyle(
                        color: barcode
                            ? Colors.blue[600]
                            : Color.fromARGB(255, 188, 181, 181),
                        fontSize: media.size.height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(),
                  fixedSize: Size(
                    media.size.height * 0.2 * 1.1,
                    media.size.height * 0.1,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    barcode = false;
                    photo = true;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: media.size.height * 0.02),
                              height: media.size.height * 0.2 * 1.2,
                              width: media.size.height * 0.2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: media.size.height * 0.02,
                                  ),
                                  Text(
                                    'Are you want to pick image?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            media.size.height * 0.02 * 1.3),
                                  ),
                                  SizedBox(
                                    height: media.size.height * 0.03,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(),
                                          fixedSize: Size(
                                              media.size.height * 0.1 * 1.8,
                                              media.size.height * 0.03),
                                          backgroundColor: Colors.blue[600]),
                                      onPressed: () {
                                        Provider.of<ImagePickerProvider>(
                                                context,
                                                listen: false)
                                            .Imagepickerbycamera();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(),
                                          fixedSize: Size(
                                              media.size.height * 0.1 * 1.8,
                                              media.size.height * 0.03),
                                          backgroundColor: Colors.blue[600]),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ),
                          );
                        });
                  });

                  // Trigger method to pick image by camera
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: media.size.height * 0.02,
                    ),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: photo
                          ? Colors.blue[600]
                          : Color.fromARGB(255, 188, 181, 181),
                      size: media.size.height * 0.04,
                    ),
                    Text(
                      'Take a Photo',
                      style: TextStyle(
                        color: photo
                            ? Colors.blue[600]
                            : Color.fromARGB(255, 188, 181, 181),
                        fontSize: media.size.height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
