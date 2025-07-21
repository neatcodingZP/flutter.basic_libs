import 'package:flutter/material.dart';

import 'package:neat_ui/neat_ui.dart';

void main() {
  runApp(const MyApp());
}

/// Root application widget.
class MyApp extends StatelessWidget {
  /// Create root widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter neat_ui demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title :'neat_ui example'),
        '/center_content_scroll_view': (context) => const CenteredContentScrollPage(),
        '/color_utils': (context) => const ColorUtilsPage(),
      },
    );
  }
}

/// Home page.
class HomePage extends StatelessWidget {
  /// Create home page.
  const HomePage({super.key, required this.title});

  /// Page title.
  final String title;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Widgets', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/center_content_scroll_view'), 
            child: const Text('CenterContentScrollView'),
          ),
          const Divider(),
          const Text('Utils', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/color_utils'), 
            child: const Text('Color utils'),
          ),
        ],
      ),
    );
  }
}

/// Page with [CenteringScrollView] widget.
/// 
/// Short list wil be centered.
class CenteredContentScrollPage extends StatefulWidget {
  /// Create page.
  const CenteredContentScrollPage({super.key});

  @override
  State<CenteredContentScrollPage> createState() => _CenteredContentScrollPageState();
}

class _CenteredContentScrollPageState extends State<CenteredContentScrollPage> {
  bool _isShortList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CenteredContentListView'),
      ),
      body: CenteringScrollView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(_isShortList ? 'Small list' : 'Large list', textAlign: TextAlign.center,),
          if (_isShortList) Container(
            height: 400,
            width: double.infinity,
            color: Colors.green,
          ),
          TextField(key: null),
          if (!_isShortList) ...List.generate(50, (index) => Center(
            child: Container(
              height: 100,
              width: 100,
              color: index % 2 == 0 ? Colors.green : Colors.amber,
            ),
          )),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: () {
          setState(() {
            _isShortList = !_isShortList;
          });
        },
        label: Text('Toggle\nto ${_isShortList ? 'large' : 'small'}\nlist', textAlign: TextAlign.center,),
      ),
    );
  }
}

/// Color utils page.
class ColorUtilsPage extends StatefulWidget {
  /// Create page.
  const ColorUtilsPage({super.key});

  @override
  State<ColorUtilsPage> createState() => _ColorUtilsPageState();
}

class _ColorUtilsPageState extends State<ColorUtilsPage> {
  final _currentColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color utils'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        children: [
          const Text('Color extension', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          ColorExampleWithOneValue(label: 'greyscale()', originalColor: _currentColor, resultColor: _currentColor.greyscale()),
          ColorExampleWithOneValue(label: 'greyscale\nAverage()', originalColor: _currentColor, resultColor: _currentColor.greyscaleAverage()),
          ColorExampleWithOneValue(label: 'greyscale\nSaturation()', originalColor: _currentColor, resultColor: _currentColor.greyscaleSaturation()),
          ColorExampleWithPalette(label: 'darken\n(0.2 .. 1.0)', originalColor: _currentColor, resultColors: List.generate(5, (index) => _currentColor.darken(index*0.2 +0.2))),
          ColorExampleWithPalette(label: 'darkenHsl\n(0.2 .. 1.0)', originalColor: _currentColor, resultColors: List.generate(5, (index) => _currentColor.darkenHsl(index*0.2 +0.2))),
          ColorExampleWithPalette(label: 'lighten\n(0.2 .. 1.0)', originalColor: _currentColor, resultColors: List.generate(5, (index) => _currentColor.lighten(index*0.2 +0.2))),
          ColorExampleWithPalette(label: 'lightenHsl\n(0.2 .. 1.0)', originalColor: _currentColor, resultColors: List.generate(5, (index) => _currentColor.lightenHsl(index*0.2 +0.2))),
        ],
      ),
    );
  }
}

/// Widget with color operation presentation.
/// 
/// Contains lable, base color, and result colors.
/// width distribution 3(label)-1(base color)-[resultColors]
class ColorExampleWithPalette extends StatelessWidget {
  /// Create widget.
  const ColorExampleWithPalette({
    super.key,
    required this.label,
    required this.originalColor,
    required this.resultColors,
    this.rowHeight = 50.0,
  });

  /// Text label of the row.
  final String label;

  /// Original color.
  final Color originalColor;

  /// Result color.
  final List<Color> resultColors;

  /// Row height.
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: rowHeight, width: 100, child: Align(alignment: Alignment.centerRight, child: Text(label, textAlign: TextAlign.end,))),
        SizedBox(width: 12,),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 1, child: ColoredBox(color: originalColor, child: SizedBox(height: rowHeight,))),
              ...(resultColors.map((color) => Expanded(flex: 1, child: ColoredBox(color: color, child: SizedBox(height: rowHeight,)))).toList()),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget with color operation presentation.
/// 
/// Contains lable, base color, and result color.
/// width distribution 3(label)-1(base color)-1(result color)-4(empty spacing)
class ColorExampleWithOneValue extends StatelessWidget {
  /// Create widget.
  const ColorExampleWithOneValue({
    super.key,
    required this.label,
    required this.originalColor,
    required this.resultColor,
    this.rowHeight = 50.0,
  });

  /// Text label of the row.
  final String label;

  /// Original color.
  final Color originalColor;

  /// Result color.
  final Color resultColor;

  /// Row height.
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: rowHeight, width: 100, child: Align(alignment: Alignment.centerRight, child: Text(label, textAlign: TextAlign.end,))),
        SizedBox(width: 12,),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 1, child: ColoredBox(color: originalColor, child: SizedBox(height: rowHeight,))),
              Expanded(flex: 1, child: ColoredBox(color: resultColor, child: SizedBox(height: rowHeight,))),
              Expanded(flex: 4, child: SizedBox()),
            ],
          ),
        )
        
      ],
    );
  }
}