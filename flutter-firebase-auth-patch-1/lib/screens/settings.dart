import 'dart:io';

import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../auth/services/firebase_auth_methods.dart';
import '../utils/select_photo.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _showSelectPhotoOptions(context);
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: _image == null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/avatar.jpg'),
                                            fit: BoxFit.cover)),
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(_image!),
                                    radius: 200.0,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 100,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Joined',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '2 month ago',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DADAXON',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Turgunboev',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: h * 0.09,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 0.2, color: Color.fromARGB(93, 255, 255, 255)),
                  bottom: BorderSide(
                      width: 0.4, color: Color.fromARGB(93, 255, 255, 255)),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(213, 255, 255, 255)),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 19,
                      color: Color.fromARGB(213, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: h * 0.09,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 0.2, color: Color.fromARGB(93, 255, 255, 255)),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(213, 255, 255, 255)),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 19,
                      color: Color.fromARGB(213, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: w,
              height: h * 0.09,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromARGB(93, 255, 255, 255)),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(213, 255, 255, 255)),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 19,
                      color: Color.fromARGB(213, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: w,
                height: h * 0.11,
                decoration: BoxDecoration(
                    color: Color.fromARGB(32, 158, 158, 158),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 37,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 28, 15),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'PRO',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade to Premium',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            Text(
                              'This subscription is auto-renewable',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(167, 255, 255, 255)),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 19,
                          color: Color.fromARGB(213, 255, 255, 255),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: w,
              height: h * 0.07,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 0.2, color: Color.fromARGB(93, 255, 255, 255)),
                  bottom: BorderSide(
                      width: 0.6, color: Color.fromARGB(93, 255, 255, 255)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<FirebaseAuthMethods>().signOut(context);
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(211, 229, 16, 16),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomButton(
//             onTap: () {
//               context.read<FirebaseAuthMethods>().deleteAccount(context);
//             },
//             text: 'Delete Account',
//           ),
//           CustomButton(
//             onTap: () {
//               context.read<FirebaseAuthMethods>().signOut(context);
//             },
//             text: 'Sign Out',
//           ),
