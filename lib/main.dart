import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // MyAppで定義したアプリの実行をFlutterに指示する
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// アプリの状態を定義
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    // currentに新しいランダムなWordPairを再代入する
    current = WordPair.random();
    // 監視しているMyAppStateに通知する
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  // そのウィジェットを常に最新にするために、周囲の状況が変化するたびに自動的に呼び出されるbuild()メソッド
  Widget build(BuildContext context) {
    // watchメソッドを利用してアプリの現在の状態に対する変更を追跡
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    // どのbuildメソッドもかならずウィジェットかウィジェットのネストしたツリーを返却する
    return Scaffold(
      // ColumnはFlutterにおける基本的なレイアウトウィジェット
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // appSatateを取り、そのクラスのメンバーであるcurrent(WordPair)にアクセス
            BigCard(pair: pair),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
