class HighScoreHolder {
  String name;
  int score;
  HighScoreHolder( String n, int s){
    name = n != "" ? n : "NAN";
    score = s;
  }
}
