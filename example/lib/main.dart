import 'package:flexible_toast/flexible_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,
                  title: 'Success!',
                  message: 'Your operation was completed successfully.',
                  type: NotifyType.success,
                  position: NotifyPosition.top,
                  duration: 3000, // 3 seconds
                );
              },
              child: const Text('Show Success (Top)'),
            ),
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,
                  title: 'Heads Up!',
                  message: 'Something needs your attention. Please review.',
                  type: NotifyType.warning,
                  position: NotifyPosition.center,
                  duration: 5000, // 5 seconds
                );
              },
              child: const Text('Show Warning (Center)'),
            ),
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,
                  title: 'Error Occurred!',
                  message: 'Failed to save data. Please try again.',
                  type: NotifyType.error,
                  position: NotifyPosition.bottom,
                  dismissDirection:
                      DismissDirection.horizontal, // Can dismiss left/right
                  closeCallBack: () {
                    print('Error notification was dismissed!');
                  },
                );
              },
              child: const Text('Show Error (Bottom) with callback'),
            ),
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,

                  title: 'Custom Alert!',
                  message: 'This is a notification with a custom look.',
                  type: NotifyType
                      .warning, // Can still use a type for defaults not overridden
                  position: NotifyPosition.top,
                  backgroundColor:
                      Colors.deepPurple, // Overrides type-specific color
                  successIcon: const Icon(
                    Icons.star_rounded,
                    color: Colors.amberAccent,
                  ), // Custom icon for success
                  titleColor: Colors.amberAccent,
                  messageColor: Colors.white70,
                  closeIcon: const Icon(Icons.close, color: Colors.white),
                  elevation: 8.0,
                  padding: const EdgeInsets.all(
                    20.0,
                  ).copyWith(top: kToolbarHeight), // More padding
                );
              },
              child: const Text('Show Custom Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,
                  titleWidget: Row(
                    children: [
                      Icon(Icons.thumb_up, color: Colors.lightGreenAccent),
                      SizedBox(width: 8),
                      Text(
                        'Operation Complete!',
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  messageWidget: Text(
                    'All files have been successfully synchronized to the cloud.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  backgroundColor: Colors.green.shade800,
                  position: NotifyPosition.top,
                  duration: 4000,
                );
              },
              child: const Text('Show Widget-Based Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                CNotify.show(
                  context: context,

                  title: 'Fixed Size',
                  message:
                      'This notification has a predefined height and width.',
                  type: NotifyType
                      .warning, // Assuming you add an info type or use default
                  backgroundColor: Colors.blueGrey,
                  height: 80.0,
                  width: 300.0,
                  position: NotifyPosition.center,
                );
              },
              child: const Text('Show Fixed Size Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
