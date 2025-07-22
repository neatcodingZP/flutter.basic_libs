![Cover - Neat push button](https://raw.githubusercontent.com/neatcodingZP/flutter.basic_libs/master/packages/neat_push_button/doc/buttons_impression.jpg "Neat push button")  
Photo by <a href="https://unsplash.com/@kitkat93?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Ekaterina Grosheva</a> on <a href="https://unsplash.com/photos/white-and-black-round-beads-8B7pypIjrqY?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>    

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![pub package](https://img.shields.io/pub/v/neat_push_button.svg)](https://pub.dev/packages/neat_push_button) 

Pushable button, ot tap goes down, on release goes up.
With styling, theming, and theme extension.  
![Push buttons example](https://raw.githubusercontent.com/neatcodingZP/flutter.basic_libs/master/packages/neat_ui/doc/push_buttons.gif "Push buttons")  

## Table of Contents
- [🚀 Getting started](#🚀-getting-started)
- [🌟 Styling](#🌟-styling)
    - [PushButtonStyle](#pushbuttonstyle)
    - [PushButtonThemeExtension](#pushbuttonthemeextension)
    - [PushButtonTheme](#pushbuttontheme)

## 🚀 Getting started

**Step 1: Add dependencies**

```yaml
dependencies:
  neat_push_button: <version>
```

**Step 2: Use push button**

```dart
import 'package:neat_push_button/neat_push_button.dart';

final pushButtonWidget = PushButton(
  // Style button if needed  
  //style: PushButtonStyle(...),  
  onTap: () {
    print('onTap');
  },
  child: Text('PUSH ME'),
);
```
All styling parameters will be used if not-null in following order(priority): widget style, theme style, default style. 

And that is all!

## 🌟 Styling

### PushButtonStyle

Object to style `PushButton`. Main supported parameters:
- text and icon styles;
- shape;
- colors (fore/back-ground, bottom);
- offset on tap;
- animation duration;
- tap throttle duration.

Can be used directly with `PushButton`:
```dart
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

final pushButtonWidget = PushButton(
  style: pushButtonStyle,  
  onTap: () {
    print('onTap');
  },
  child: Text('PUSH ME'),
);
```

### PushButtonThemeExtension

Extension to use with `Theme`. If provided `PushButton` can take missing style parameters from `Theme`:

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      PushButtonThemeExtension(
        data: PushButtonThemeData(
          style: pushButtonStyle,
        ),
      ),
    ],
  ),

);

// Style parameters will be taken from `Theme`
final pushButtonWidget = PushButton(
  onTap: () {
    print('onTap');
  },
  child: Text('PUSH ME'),
);
```

### PushButtonTheme
Widget wrapper which provides `PushButtonStyle` to it's descendants (children):

```dart

// The same style parameters will be used 
// from `pushButtonStyle` with both buttons
// if the parameters not-null
// if null - will use `Theme` parameters
// with fallback to default parameters.
final pushButtonWidget = PushButtonTheme(
  data: PushButtonThemeData(
    style: pushButtonStyle,
  ),
  child: Row(
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
);
```

