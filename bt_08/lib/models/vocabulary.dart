class Vocabulary{
  final  String word;
  final String mean;

  Vocabulary({required this.word,required this.mean});

  String ToFile(){
    return "$word|${mean}";

  }

  static Vocabulary fromString(String line){
    final path = line.split('|');
    return Vocabulary(word: path[0], mean: path.length > 1 ? path[1]: '');
  }



}