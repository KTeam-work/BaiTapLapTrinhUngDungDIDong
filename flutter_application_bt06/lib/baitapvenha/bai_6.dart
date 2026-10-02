import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  // đối tượng dùng để phát và điều khiển nhạc
  final AudioPlayer _audioPlayer = AudioPlayer();

  // lưu vị trí bài hát đang được chọn
  int _currentSongIndex = 0;

  // kiểm tra bài hát đang phát hay không
  bool _isPlaying = false;

  // tổng thời gian và thời gian đã phát
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // danh sách đường dẫn các file nhạc
  final List<String> _songs = [
    'assets/audios/sample1.mp3',
    'assets/audios/sample2.mp3',
    'assets/audios/sample3.mp3',
  ];

  final List<String> _songTitles = [
    'Sample Song 1',
    'Sample Song 2',
    'Sample Song 3',
  ];

  final List<String> _artists = [
    'Artist 1',
    'Artist 2',
    'Artist 3',
  ];

  @override
  void initState() {
    super.initState();

    // lấy tổng thời gian của bài hát
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    // cập nhật vị trí phát hiện tại
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    // tự động chuyển bài khi bài hiện tại kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });

    // cập nhật trạng thái phát hoặc tạm dừng
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  // phát bài hát hiện tại
  Future<void> _playSong() async {
    await _audioPlayer.stop();

    await _audioPlayer.play(
      AssetSource(
        _songs[_currentSongIndex].replaceFirst('assets/', ''),
      ),
    );

    setState(() {
      _isPlaying = true;
    });
  }

  // tạm dừng bài hát
  Future<void> _pauseSong() async {
    await _audioPlayer.pause();

    setState(() {
      _isPlaying = false;
    });
  }

  // chuyển sang bài tiếp theo
  Future<void> _nextSong() async {
    setState(() {
      if (_currentSongIndex < _songs.length - 1) {
        _currentSongIndex++;
      } else {
        _currentSongIndex = 0;
      }

      _position = Duration.zero;
      _duration = Duration.zero;
    });

    await _playSong();
  }

  // chuyển về bài trước
  Future<void> _previousSong() async {
    setState(() {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex = _songs.length - 1;
      }

      _position = Duration.zero;
      _duration = Duration.zero;
    });

    await _playSong();
  }

  // chọn bài hát trực tiếp từ danh sách
  Future<void> _selectSong(int index) async {
    setState(() {
      _currentSongIndex = index;
      _position = Duration.zero;
      _duration = Duration.zero;
    });

    await _playSong();
  }

  // đổi thời gian sang dạng phút:giây
  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    String seconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    // giải phóng tài nguyên của trình phát khi thoát màn hình
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffb90075),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _buildPlayer(),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildPlaylist(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff15151c),
            Color(0xff26152e),
            Color(0xff18181d),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),

          const Text(
            'ALBUM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 25),

          _buildAlbum(),

          const SizedBox(height: 25),

          Text(
            _songTitles[_currentSongIndex],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            _artists[_currentSongIndex],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),

          const Spacer(),

          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: _previousSong,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Color(0xffa9006c),
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Color(0xffa9006c),
                        size: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.queue_music,
                        color: Color(0xffa9006c),
                        size: 27,
                      ),
                    ),
                    IconButton(
                      onPressed: _nextSong,
                      icon: const Icon(
                        Icons.skip_next,
                        color: Color(0xffa9006c),
                        size: 28,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),

                    Expanded(
                      child: Slider(
                        value: _position.inSeconds
                            .toDouble()
                            .clamp(
                          0,
                          _duration.inSeconds.toDouble(),
                        ),
                        max: _duration.inSeconds > 0
                            ? _duration.inSeconds.toDouble()
                            : 1,
                        activeColor: const Color(0xffa9006c),
                        inactiveColor: Colors.grey,
                        onChanged: (value) {
                          _audioPlayer.seek(
                            Duration(
                              seconds: value.toInt(),
                            ),
                          );
                        },
                      ),
                    ),

                    Text(
                      _formatDuration(_duration),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            color: const Color(0xff202024),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _previousSong,
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 20),

                GestureDetector(
                  onTap: () {
                    if (_isPlaying) {
                      _pauseSong();
                    } else {
                      _playSong();
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffa9006c),
                    ),
                    child: Icon(
                      _isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                IconButton(
                  onPressed: _nextSong,
                  icon: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xffa9006c),
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildAlbum() {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 7,
        ),
      ),
      child: Center(
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Color(0xffa9006c),
            size: 35,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaylist() {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff17151c),
            Color(0xff242126),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            child: Column(
              children: [
                Text(
                  _songTitles[_currentSongIndex].toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  _artists[_currentSongIndex].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    index == _currentSongIndex;

                return GestureDetector(
                  onTap: () {
                    _selectSong(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffa9006c),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            '${index + 1}.',
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xffff39b2)
                                  : Colors.white70,
                            ),
                          ),
                        ),

                        Container(
                          width: 18,
                          height: 18,
                          color: const Color(0xffff39b2),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                _songTitles[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xffff39b2)
                                      : Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),

                              Text(
                                _artists[index],
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Text(
                          '3:00',
                          style: TextStyle(
                            color: Color(0xffff39b2),
                            fontSize: 12,
                          ),
                        ),

                        const Icon(
                          Icons.more_vert,
                          color: Color(0xffff39b2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}