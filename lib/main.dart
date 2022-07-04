import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main () {
  runApp(const ProviderScope(child: MyApp()));
}

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  ThemeMode get current => themeMode;

  void toggle () {
    themeMode = current.name == ThemeMode.dark.name ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

}

final themeModeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Center(child: Consumer(
          builder: (__,WidgetRef ref, ___) {
            return Text(ref.watch(themeModeProvider).current.name);
          }
      )),
      floatingActionButton: Consumer(
        builder: (__,WidgetRef ref,___) {
          return FloatingActionButton(
              onPressed: () {
                ref.read(themeModeProvider).toggle();
              },
              child: Icon(ref
                  .watch(themeModeProvider)
                  .current
                  .name == ThemeMode.dark.name ? Icons.dark_mode : Icons
                  .light_mode)
          );
        }),
      ),
    );
  }
}



