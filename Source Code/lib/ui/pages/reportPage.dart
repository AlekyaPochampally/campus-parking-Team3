import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:campusparking/ui/pages/violationPage.dart';

final _firestore = Firestore.instance;

/// ignore: camel_case_types
class reportPage extends StatefulWidget {
  static const String route = '/report';

  @override
  _reportPageState createState() => _reportPageState();
}

// ignore: camel_case_types
class _reportPageState extends State<reportPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // ignore: non_constant_identifier_names
  String vehicle_no ='';
  String image;
  String description = '';

  /// Active image file
  File _imageFile;

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
            return Scaffold(
                appBar: ApplicationBar(),
                body: SafeArea(
                    child: Form(
                        key: _formKey,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Report',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 30),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Report any inconsistent data by entering the details below. Upload image from either gallery or camera',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter vehicle number',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Vehicle number cannot be empty';
                                      }
                                      _formKey.currentState.save();
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        setState(() => vehicle_no = value),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter description',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Description cannot be empty';
                                      }
                                      _formKey.currentState.save();
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        setState(() => description = value),
                                  ),
                                ),
                                Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Choose Image',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, 
                                fontFamily: 'Raleway',
                                fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_camera),
                            onPressed: () => _pickImage(ImageSource.camera),
                            color: Colors.grey[400],
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_library),
                            onPressed: () => _pickImage(ImageSource.gallery),
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    if (_imageFile != null) ...[
                      Image.file(_imageFile),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(Icons.crop),
                            onPressed: _cropImage,
                          ),
                          FlatButton(
                            child: Icon(Icons.refresh),
                            onPressed: _clear,
                          ),
                        ],
                      ),
                      Uploader(file: _imageFile)
                    ],
                                Container(
                      height: 75,
                      margin: EdgeInsets.fromLTRB(17.0, 15.0, 0, 0),
                      child: Row(
                        children: <Widget>[
                            ButtonTheme(
                            minWidth: 150.0,
                            height: 45.0,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                              _firestore.collection('Report').add({
                              'Vehicle ID': vehicle_no,
                              'Description': description,
                             });
                              Toast.show("Reported Successful", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                Navigator.of(context)
                                  .pushReplacementNamed(reportPage.route);
                              }
                              },
                              color: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.grey)),
                              splashColor: Colors.blue,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.report,
                                    size: 30.0,
                                    color: Colors.grey[300],
                                  ),
                                  Text('Report', 
                                  style: TextStyle(fontSize: 20.0, 
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 45.0,
                          ),
                            ButtonTheme(
                            minWidth: 150.0,
                            height: 45.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                              },
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.grey)),
                              splashColor: Colors.red,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.clear,
                                    size: 30.0,
                                    color: Colors.grey[300],
                                  ),
                                  Text('Clear', style: TextStyle(fontSize: 20.0)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: () async => Navigator.of(context)
                                  .pushReplacementNamed(ViolationPage.route),
                              child: Text(
                                'Click here to report a violation !',
                              )),
                        ],
                      ),
                    ),
                                ]
                                )
                                ))));
  }
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://campus-parking-e2a4b.appspot.com/');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'imagesReportPage/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('Upload Successful!'),
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      return FlatButton.icon(
        label: Text('Upload Image'),
        color: Colors.teal[500],
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
