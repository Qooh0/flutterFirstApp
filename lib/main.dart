import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator2',
      home: RandomWords(),
    );
  }
}

// Stateful Widget は State クラスの作成が主な作業
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

// State<RandomWords> は RandomWords で使うことを指定している
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override                                  // Add from this line ...
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator3'),
      ),
      body: _buildSuggestions(),
    );
  }                                          // ... to this line.

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          // 奇数行は「仕切りウィジェット」
          // 高さは1pxの仕切り
          if (i.isOdd) {
            return Divider();
          }
          // i ~/ 2 : 2 で除算した商
          // 例) 1, 2, 3, 4, 5 => 0, 1, 1, 2, 2
          // 実際の単語のペアリングを表している
          // ListView の仕切りウィジェットを差し引いている
          final int index = i ~/ 2;
          // もし最後の index まで到達したら
          if (index >= _suggestions.length) {
            // 候補を追加する
            _suggestions.addAll(prefix0.generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(prefix0.WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}