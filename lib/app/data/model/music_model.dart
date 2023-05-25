class Music {
  final String title;
  final String artist;
  final String image;
  final String musicMP3;
  final String lyrics;

  Music({
    required this.title,
    required this.artist,
    required this.image,
    required this.musicMP3,
    required this.lyrics,
  });
}

class PlaylistMusic {
  final String title;
  final List<Music> songs;
  final String image;

  PlaylistMusic({
    required this.title,
    required this.songs,
    required this.image,
  });
}
