import 'dart:io';
import 'package:file_selector/file_selector.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'
    hide XFile; // hides to test if share_plus exports XFile
import 'package:share_plus/share_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Share Plus Plugin Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0x9f4376f8),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 30),
            backgroundColor: Colors.orange,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 30.0),
            titleMedium: TextStyle(fontSize: 30.0),
            labelLarge: TextStyle(fontSize: 30.0),
          ),
        ),
        home: const SharePlusPage(),
      );
}

class SharePlusPage extends StatefulWidget {
  const SharePlusPage({Key? key}) : super(key: key);

  @override
  SharePlusPageState createState() => SharePlusPageState();
}

class SharePlusPageState extends State<SharePlusPage> {
  String text = '';
  String subject = '';
  List<String> names = [];
  List<String> paths = [];
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
                        paths.add(file.path);
                        names.add(file.name);
                      });
                    }
                  } else {
                    // Using `package:image_picker` to get image from gallery.
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        paths.add(pickedFile.path);
                        names.add(pickedFile.name);
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                label: const Text('Add video'),
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final video = await imagePicker.pickVideo(
                    source: ImageSource.gallery,
                  );
                  if (video != null) {
                    setState(() {
                      paths.add(video.path);
                      names.add(video.name);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: text.isEmpty && paths.isEmpty
                    ? null
                    : () => onShare(context),
                child: const Text('Share'),
              ),
            ],
          ),
        ),
      );

  void onDeleteImage(int position) {
    setState(() {
      paths.removeAt(position);
      names.removeAt(position);
    });
  }

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    if (paths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < paths.length; i++) {
        files.add(
          XFile(
            paths[i],
            name: names[i],
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
}
