import 'dart:io';

import 'package:file_selector/file_selector.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:share_plus/share_plus.dart';

import 'image_previews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Plus Plugin Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const SharePlusPage(),
    );
  }
}

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
                onChanged: (String value) => setState(() {
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
                onDelete: _onDeleteImage,
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
                  }
                  else {
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
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: text.isEmpty && imagePaths.isEmpty
                    ? null
                    : () => _onShare(context),
                child: const Text('Share'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: text.isEmpty && imagePaths.isEmpty
                    ? null
                    : () => _onShareWithResult(context),
                child: const Text('Share With Result'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  final video = await imagePicker.pickVideo(
                    source: ImageSource.gallery,
                  );
                  if (video == null) return;
                  // await Share.share([video.path], subject: 'This is the subject.');
                  if(!mounted) return;
                  _onShare(context);
                },
                child: const Text('Share  File'),
              ),
            ],
          ),
        ),
      );

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
      imageNames.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async {
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

  void _onShareWithResult(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ShareResult shareResult;
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
      shareResult = await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      shareResult = await Share.shareWithResult(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
    scaffoldMessenger.showSnackBar(
      getResultSnackBar(shareResult),
    );
  }

  SnackBar getResultSnackBar(ShareResult result) => SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Share result: ${result.status}"),
            if (result.status == ShareResultStatus.success)
              Text("Shared to: ${result.raw}")
          ],
        ),
      );
}
