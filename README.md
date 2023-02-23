## 1. Research: Flutter Share Plus Package

- Keywords:
    - flutter share plus
    - flutter share plus deprecated
    - flutter share file
    - flutter share plus example
    - flutter share file to whatsapp
    - share plus flutter
    - flutter share image
    - flutter share intent
    - flutter share link
    - flutter share plugin
    - flutter share text
    - flutter share me
    - flutter share_plus whatsapp
    - flutter share package
    - flutter share plus not working
    - flutter share plus deprecated
    - flutter share plus web
- Video Title: Flutter Share Plus Package/Plugin Example - Share text, link, image or any file in flutter


## 2. Research: Competitors

**Flutter Videos/Articles**

- 4.5K: https://www.youtube.com/watch?v=My_TAyIk1rA
- 5.5K: https://www.youtube.com/watch?v=Hn4HbTGcOYM
- 1.8K: https://www.youtube.com/watch?v=e40WRDnKXjQ
- 28K: https://www.youtube.com/watch?v=CNUBhb_cM6E
- 1K: https://www.youtube.com/watch?v=TiOsAECt1r8
- 10K: https://www.youtube.com/watch?v=ZIixCOhHQB8
- 1.7K: https://www.youtube.com/watch?v=9AUJeDSb7Fg
- 2.9K: https://www.youtube.com/watch?v=4G9zteuutTg
- https://pub.dev/packages/share_plus
- https://www.geeksforgeeks.org/flutter-share-plus-library/
- https://blog.logrocket.com/sharing-content-flutter-apps-share-plus/
- https://medium.flutterdevs.com/sharing-files-in-flutter-66aa4e115256
- https://protocoderspoint.com/flutter-share-files-images-videos-text-using-share_plus/

**Android/Swift/React Videos**

- 9.5K: https://www.youtube.com/watch?v=sP0mmMKUTYQ
- 87K: https://www.youtube.com/watch?v=NdtE_1u0cq4
- 10K: https://www.youtube.com/watch?v=ZIixCOhHQB8
- 2.1K: https://www.youtube.com/watch?v=iFN_1BYpZMs
- 4.7K: https://www.youtube.com/watch?v=TKwJXQ1ygTc
- 5K: https://www.youtube.com/watch?v=LZMnIiF-tbk
- 30K: https://www.youtube.com/watch?v=do1EF3CoO8M
- 2.2K: https://www.youtube.com/watch?v=VyUus5eIvaI
- 1.8K: https://www.youtube.com/watch?v=e40WRDnKXjQ
- 15K: https://www.youtube.com/watch?v=jxhq1_7HkJg
- https://developer.android.com/training/sharing/send
- https://stackoverflow.com/questions/13941093/how-to-share-entire-android-app-with-share-intent
- https://guides.codepath.com/android/Sharing-Content-with-Intents
- https://android-developers.googleblog.com/2012/02/share-with-intents.html
- https://www.javatpoint.com/android-share-app-data
- https://medium.com/androiddevelopers/sharing-content-between-android-apps-2e6db9d1368b
- https://stuff.mit.edu/afs/sipb/project/android/docs/training/sharing/send.html
- https://stuff.mit.edu/afs/sipb/project/android/docs/training/sharing/send.html
- https://www.codingexplorer.com/sharing-swift-app-uiactivityviewcontroller/
- https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-share-content-using-the-system-share-sheet
- https://blog.devgenius.io/how-to-share-content-from-your-app-with-uiactivityviewcontroller-in-swift-27e46438f11c
- https://www.appcoda.com/swiftui-sharelink/

**Great Features**
- Flutter plugin for sharing content via the platform share UI, using the ACTION_SEND intent on Android and UIActivityViewController on iOS.
- Gives users the ability to share content from flutter app to other applications.

**Problems from Videos**
- Question: Does share plus plugin works with iPad ? In iphone it works fine but getting error in iPad. Any solution? Thanks 🙏🏻
- Question: Would you know if there is a way of sharing text to Facebook with this package? On the docs they said that Facebook imposed some restrictions that don't allow sharing text. Is the solution using the "Share" package you presented on a previous video?
- Question: Hi! how can I share a video that I have in my assets folder?
<br />Answer: Follow this link: https://medium.flutterdevs.com/sharing-files-in-flutter-66aa4e115256

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/74197283/why-is-the-flutter-share-plus-package-giving-this-illegalargumentexception
- https://stackoverflow.com/questions/71621033/execution-failed-for-task-share-pluscompiledebugkotlin-getting-this-compili
- https://stackoverflow.com/questions/72397144/unable-to-build-app-bundle-in-flutter-due-to-share-plus-package
- https://stackoverflow.com/questions/71671151/flutter-share-plus-file-does-not-get-shared-on-android
- https://stackoverflow.com/questions/75198558/i-accured-to-error-in-using-share-plus-from-gradle-in-flutter

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. Share Plus package is used to share text, links, images, videos, and files etc.
2. Main Points
    - Learn to share text and links
    - Learn to share images and videos
3. It is very useful for sharing of text, links, images, and videos.

**The Structured Main Content**
1. Run `dart pub get share_plus` to add share plus package in `pubspec.yaml` file. Also add `image_picker` and `file_selector` for selecting and sharing images and files.
2. There is no need to setup for android and iOS. Also compatible with Windows and Linux by using "mailto" to share text via Email. Sharing files is not supported on Windows and Linux.
3. 
- In `share_plus_page.dart` file,
  - Declare `text` and `subject` variables to share them with images, `imageNames` and `imagePaths` lists for images, and `videoNames` and `videoPaths` lists for videos. Initialize imagePicker.
```dart
  String text = '';
  String subject = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];
  List<String> videoNames = [];
  List<String> videoPaths = [];
  final imagePicker = ImagePicker();
```
  - After two `TextField`s, there are four buttons:
  - First button is `ElevatedButton.icon` with child text `Add image` button to add the images. `file_selector` package for windows, macos & Linux and `image_picker` for other platforms to pick an image from device files.
```dart
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
```
  - Second button is `Share Images/Text/Subject`, it shares text, subject, and images together. It calls `onShareImages()` method.
<br />`onShareImages()` method: It first create an empty list of `XFile` and then adds `XFiles` with loop including `imagePaths` and `imageNames`. First it tries to share `XFiles` using `await Share.shareXFiles()`. If there is any error or no `XFile` then it uses `await Share.share()` to share text and subject of first two TextFields.
```dart
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
```
`Share Image/Text/Subject` button code:
```dart
ElevatedButton(
onPressed: text.isEmpty && imagePaths.isEmpty
? null
: () => onShareImages(context),
child: const Text('Share Images/Text/Subject'),
),
```
  - Third button is `ElevatedButton.icon` with child text `Add video` button to add the videos. It uses `imagePicker.pickVideo()` to pick video from gallery.
```dart
              ElevatedButton.icon(
                label: const Text('Add video'),
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
```
  - Fourth button is `Share Videos`, it shares videos only. It calls `onShareVideos()` method.
<br />`onShareVideos()` method:  It first create an empty list of `XFile` and then adds `XFiles` with loop including `videoPaths` and `videoNames`. It shares `XFiles` using `await Share.shareXFiles()` and shares the videos.
```dart
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
  }
```
`Share Videos` button code:
```dart
              ElevatedButton(
                onPressed: videoPaths.isEmpty
                    ? null
                    : () {
                        onShareVideos(context);
                      },
                child: const Text('Share Videos'),
              ),
```















asldkjfa;lskdfjf












- Third button is `Add Videos`, it shares videos only. It calls `onShareVideos()` method.
  <br />`onShareVideos()` method: It first create an empty list of `XFile` and then adds `XFiles` with loop including `videoPaths` and `videoNames`. It shares `XFiles` using `await Share.shareXFiles()` and shares the videos.
```dart
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
```
`Share Videos` button code:
```dart
              ElevatedButton(
                onPressed: videoPaths.isEmpty
                    ? null
                    : () {
                        onShareVideos(context);
                      },
                child: const Text('Share Videos'),
              ),
```