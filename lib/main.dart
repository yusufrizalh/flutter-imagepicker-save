import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(ImageSave());

class ImageSave extends StatefulWidget {
  @override
  _ImageSaveState createState() => _ImageSaveState();
}

class _ImageSaveState extends State<ImageSave> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      title: 'ImagePicker - Save Image',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ImagePicker - Save Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: _image != null
                  ? Container(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _image,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Image found'),
                    ),
            ),
            ElevatedButton(
              child: Text('Capture and Store Image'),
              onPressed: _getImage,
            ),
          ],
        ),
      ),
    );
  }

  _getImage() async {
    PickedFile imageFile = await picker.getImage(source: ImageSource.camera);
    if (imageFile == null) return;
    File tmpFile = File(imageFile.path);

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
    print('File path is :${tmpFile.path}');
    setState(() {
      _image = tmpFile;
    });
  }
}
