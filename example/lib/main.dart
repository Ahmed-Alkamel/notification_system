import 'package:flutter/material.dart';
import 'package:notification_system/notification_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize the Notification System
  await NotificationSystem.instance.initialize(
    style: const NotificationStyle(
      successColor: Colors.greenAccent,
      infoColor: Colors.blueAccent,
      permissionDialogTitle: 'Notifications',
      permissionDialogBody: 'We need permissions to show you updates.',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification System Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notification System Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _permissionService = NotificationSystem.instance.permissionService;
  final _generalService =
      NotificationSystem.instance.generalNotificationService;
  final _localService = NotificationSystem.instance.localNotificationService;

  String _status = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Permission Status: $_status'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final granted = await _permissionService
                    .requestNotificationPermission(context);
                setState(() {
                  _status = granted ? 'Granted' : 'Denied/Not Requested';
                });
              },
              child: const Text('Request Permission'),
            ),
            const Divider(height: 40),
            const Text('In-App Notifications:'),
            Wrap(
              spacing: 10,
              children: [
                FilledButton(
                  onPressed: () =>
                      _generalService.showSuccess('Operation Successful!'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Success'),
                ),
                FilledButton(
                  onPressed: () =>
                      _generalService.showError('Something went wrong.'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Error'),
                ),
                FilledButton(
                  onPressed: () =>
                      _generalService.showInfo('Just so you know...'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Info'),
                ),
                FilledButton(
                  onPressed: () => _generalService.showWarning('Watch out!'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Warning'),
                ),
              ],
            ),
            const Divider(height: 40),
            const Text('Local Notifications:'),
            ElevatedButton(
              onPressed: () {
                _localService.showNotification(
                  id: 1,
                  title: 'Hello',
                  body:
                      'This is a local notification triggered from the button.',
                );
              },
              child: const Text('Show Local Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
