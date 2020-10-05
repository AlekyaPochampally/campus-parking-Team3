import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:testing/shared/loading.dart';
import 'package:testing/ui/widgets/app_bar.dart';
import 'package:testing/ui/pages/user_home_page.dart';
import 'package:testing/models/user.dart';
import 'package:testing/services/database.dart';

class ViolationPage extends StatefulWidget {
  static const String route = '/violation_page';

  @override
  ViolationPageState createState() => ViolationPageState();
}

class ViolationPageState extends State<ViolationPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // ignore: non_constant_identifier_names
  String vehicle_no = '';
  // ignore: non_constant_identifier_names
  String parking_lot_id = '';
  // ignore: non_constant_identifier_names
  String slot_id = '';
  String time = '';
  String date = '';
  String formatted;
  String timer;

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
        toolbarColor: Colors.deepPurpleAccent[400],
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
    final user = Provider.of<User>(context);

    return StreamBuilder<UserViolationData>(
        stream: DatabaseService(uid: user.uid).userViolationData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserViolationData userViolationData = snapshot.data;

            return loading ? Loading() : Scaffold(
                    appBar: ApplicationBar(),
                    body: Form(
                      key: _formKey,
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Report Violation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Report unauthorized parking here',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
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
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter parking lot ID',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Parking lot ID cannot be empty';
                                    }
                                    _formKey.currentState.save();
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      setState(() => parking_lot_id = value),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter slot ID',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Slot ID cannot be empty';
                                    }
                                    _formKey.currentState.save();
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      setState(() => slot_id = value),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () async {
                                        final selectedDate =
                                            await _selectDateTime(context);
                                        if (selectedDate == null) return;

                                        // Formatting the date
                                        var formatter =
                                            new DateFormat('yyyy-MMM-dd');
                                        formatted =
                                            formatter.format(selectedDate);
                                        final selectedTime =
                                            await _selectTime(context);

                                        if (selectedTime == null) return;

                                        // Formatting the time
                                        final dt = DateTime(
                                            1969,
                                            1,
                                            1,
                                            selectedTime.hour,
                                            selectedTime.minute);
                                        var timerfor = new DateFormat('HH:mm');
                                        timer = timerfor.format(dt);
                                        print(timer);

                                        setState(() {
                                          this.selectedDate = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedTime.hour,
                                            selectedTime.minute,
                                          );
                                        });
                                      },
                                      child: Text(
                                        'Choose Date and Time',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      dateFormat.format(selectedDate),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Choose Image',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.photo_camera),
                                      onPressed: () =>
                                          _pickImage(ImageSource.camera),
                                      color: Colors.grey[400],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.photo_library),
                                      onPressed: () =>
                                          _pickImage(ImageSource.gallery),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      height: 45.0,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() => loading = true);
                                            await DatabaseService(uid: user.uid)
                                                .updateUserViolationData(
                                              vehicle_no ??
                                                  userViolationData.vehicle_no,
                                              parking_lot_id ??
                                                  userViolationData
                                                      .parking_lot_id,
                                              slot_id ??
                                                  userViolationData.slot_id,
                                              timer ?? userViolationData.time,
                                              formatted ??
                                                  userViolationData.date,
                                            );
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    UserHomePage.route);
                                          }
                                        },
                                        color: Colors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.grey)),
                                        splashColor: Colors.blue,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.report,
                                              size: 30.0,
                                              color: Colors.grey[300],
                                            ),
                                            Text(
                                              'Report',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 150.0,
                                      height: 45.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ViolationPage.route);
                                        },
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.grey)),
                                        splashColor: Colors.red,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.clear,
                                              size: 30.0,
                                              color: Colors.grey[300],
                                            ),
                                            Text('Clear',
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          } else {
            return Loading();
          }
        });
  }
}

Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime(2020),
    lastDate: DateTime(2023));

Future<TimeOfDay> _selectTime(BuildContext context) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
  );
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://campus-parking-28bb8.appspot.com/');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'imagesViolationPage/${DateTime.now()}.png';

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
