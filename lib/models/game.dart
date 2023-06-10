class Game {
  final int idGame;
  final bool status;

  Game({required this.idGame, required this.status});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      idGame: json['idGame'],
      status: json['status'],
    );
  }
}
