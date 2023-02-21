import 'dart:io';
import 'package:file_selector/file_selector.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:share_plus/share_plus.dart';

import '../utils/image_previews.dart';

class SharePlusPage extends StatefulWidget {
  const SharePlusPage({Key? key}) : super(key: key);

  @override
  SharePlusPageState createState() => SharePlusPageState();
}

class SharePlusPageState extends State<SharePlusPage> {
  String text = '';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];
  List<String> videoNames = [];
  List<String> videoPaths = [];
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Share Plus Plugin Demo'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share text',
                  hintText: 'Enter some text and/or link to share',
                ),
                maxLines: null,
                onChanged: (value) => setState(() {
                  text = value;
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Share subject',
                  hintText: 'Enter subject to share (optional)',
                ),
                maxLines: null,
                onChanged: (String value) => setState(() {
                  subject = value;
                }),
              ),
              const SizedBox(height: 16),
              ImagePreviews(
                imagePaths,
                onDelete: onDeleteImage,
              ),
              ElevatedButton.icon(
                label: const Text('Add image'),
                icon: const Icon(Icons.add),
                onPressed: () async {
                  // Using `package:file_selector` on windows, macos & Linux, since `package:image_picker` is not supported.
                  if (!kIsWeb &&
                      (Platform.isMacOS ||
                          Platform.isLinux ||
                          Platform.isWindows)) {
                    const typeGroup = XTypeGroup(
                      label: 'images',
                      extensions: <String>['jpg', 'jpeg', 'png', 'gif'],
                    );
                    final file = await openFile(
                      acceptedTypeGroups: <XTypeGroup>[typeGroup],
                    );
                    if (file != null) {
                      setState(() {
                        imagePaths.add(file.path);
                        imageNames.add(file.name);
                      });
                    }
                  } else {
                    // Using `package:image_picker` to get image from gallery.
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                        imageNames.add(pickedFile.name);
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: text.isEmpty && imagePaths.isEmpty
                    ? null
                    : () => onShareImages(context),
                child: const Text('Share Images/Text/Subject'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                label: const Text('Add videos'),
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final pickedFile = await imagePicker.pickVideo(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      videoPaths.add(pickedFile.path);
                      videoNames.add(pickedFile.name);
                    });
                  }
                },
              ),
              ElevatedButton(
                onPressed: videoPaths.isEmpty
                    ? null
                    : () {
                        onShareVideos(context);
                      },
                child: const Text('Share Videos'),
              ),
            ],
          ),
        ),
      );

  void onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  void onShareImages(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(
          XFile(
            imagePaths[i],
            name: imageNames[i],
          ),
        );
      }
      await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  void onShareVideos(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (videoPaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < videoPaths.length; i++) {
        files.add(
          XFile(
            videoPaths[i],
            name: videoNames[i],
          ),
        );
      }
      await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
    // else {
    //   await Share.share(
    //     text,
    //     subject: subject,
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    //   );
    // }
  }
}
