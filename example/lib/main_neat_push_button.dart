// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:neat_push_button/neat_push_button.dart';

void main() {
  runApp(const MyApp());
}

/// Base style for [PushButton]
final pushButtonStyle = PushButtonStyle(
  backgroundColor: WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.grey;
    }
    return Colors.green;
  }),
  bottomColor: WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return _darken(Colors.grey, 0.4);
    }
    return _darken(Colors.green, 0.4);
  }),
  bottomOffset: Offset(0, 5.0),
  minimumSize: WidgetStatePropertyAll(Size(50, 50)),
  textStyle: WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(color: Color(0xAAFFFFFF), fontWeight: FontWeight.bold,);
    }
    return const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }),
  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
  shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
    return StadiumBorder();
  }),
  enableFeedback: true,
  ignoreTapDuration: const Duration(milliseconds: 1000),
);

/// Material app implementation
class MyApp extends StatelessWidget {
  /// Creates material app widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'push_button demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        extensions: [
          PushButtonThemeExtension(
            data: PushButtonThemeData(
              style: pushButtonStyle,
            ),
          ),
        ],
      ),
      home: const HomePage(title: 'push_button demo'),
    );
  }
}

/// Home page widget 
class HomePage extends StatelessWidget {
  /// Creates [HomePage] widget
  const HomePage({super.key, required this.title});

  /// App bar title
  final String title;

  @override
  Widget build(BuildContext context) {

    final rectButtonStyle = pushButtonStyle.copyWith(
      backgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        }
        return Colors.blue;
      }),
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        );
      }),
      bottomColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _darken(Colors.grey, 0.4);
        }
        return _darken(Colors.blue, 0.4);
      }),
      bottomOffset: Offset(0, 10.0),
      animationDuration: Durations.medium1,
      ignoreTapDuration: const Duration(milliseconds: 250),
    );

    final circleButtonStyle = pushButtonStyle.copyWith(
      minimumSize: WidgetStatePropertyAll(Size.square(75)),
      backgroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        }
        return Colors.red.shade400;
      }),
      bottomColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _darken(_darken(Colors.grey));
        }
        return _darken(_darken(Colors.red));
        
      }),
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
        return CircleBorder();
      }),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: Column(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Style with PushButtonThemeExtension
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 24.0,
                children: [
                  PushButton(
                    onTap: () => print('onTap'),
                    child: Text('Push me', textAlign: TextAlign.center,),
                  ),
                  PushButton(
                    onTap: null,
                    child: Text('Push me', textAlign: TextAlign.center,),
                  ),
                ],
              ),
          
              // Style with PushButtonTheme
              PushButtonTheme(
                data: PushButtonThemeData(
                  style: rectButtonStyle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 24.0,
                  children: [
                    PushButton(
                      onTap: () {
                        print('onTap');
                      },
                      child: Text('Push me'),
                    ),
                    PushButton(
                      onTap: null,
                      child: Text('Push me'),
                    ),
                  ],
                ),
              ),

              // Style with widget style
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 24.0,
                children: [
                  PushButton(
                    style: circleButtonStyle,
                    onTap: () {
                      print('onTap');
                    },
                    child: Text('Push \n me'),
                  ),
                  PushButton(
                    onTap: null,
                    style: circleButtonStyle,
                    child: Text('Push \n me'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Darken the color
Color _darken(Color color, [double factor = 0.1]) {
  assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

  // Reduce RGB components by the factor
  double r = color.r * (1 - factor);
  double g = color.g * (1 - factor);
  double b = color.b * (1 - factor);

  r = r.clamp(0, 1.0);
  g = g.clamp(0, 1.0);
  b = b.clamp(0, 1.0);

  return Color.from(alpha: color.a, red: r, green: g, blue: b);
}
