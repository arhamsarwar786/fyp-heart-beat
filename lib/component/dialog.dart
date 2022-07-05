import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/chat/view_image.dart';

ImagePicker picker = ImagePicker();
dialoge(context,uid) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            'Select the file',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  picker.pickImage(source: ImageSource.camera,imageQuality: 10).then((value) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ViewImage(value,uid)));
                  });

                  // .then((value) =>
                  // print("%%%%%%%%%%%%%%%%%%%%%%%%% $value")
                  // // Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewImage(value)))

                  // );
                  // // Navigator.pop(context);
                },
                icon: Icon(Icons.camera),
                color: Colors.white),
            IconButton(
              onPressed: () {
                picker.pickImage(source: ImageSource.gallery,imageQuality: 10).then((value) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ViewImage(value, uid)));
                });
                // .then((value) =>

                // //  Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewImage(value)))
                //  print(value)
                //  );
                // Navigator.pop(context);
              },
              icon: Icon(Icons.photo),
              color: Colors.white,
            )
          ],
        );
      },
    );
  }