import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:video_player/video_player.dart';

import 'home.dart';

class WatchDemoScreen extends StatefulWidget {
  const WatchDemoScreen({super.key});

  @override
  State<WatchDemoScreen> createState() => _WatchDemoScreenState();
}

class _WatchDemoScreenState extends State<WatchDemoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  @override
  void initState() {
    final String videoToken = dotenv.env['VIDEO_TOKEN'] ?? '';
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/landlisting-d88df.appspot.com/o/buddy.MP4?alt=media&token=$videoToken'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _videoPlayerController.play();
        });
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      showControls: true,
      showControlsOnInitialize: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: SvgPicture.asset(
            'assets/arrow_left.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Watch Demo',
          style: GoogleFonts.inter(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0),
          // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primaryColor,
                    ),
                    width: double.infinity,
                    height: 356,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                  const YGap(value: 32.0),
                  Text(
                    'Welcome to Translate Buddy!',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const YGap(value: 8.0),
                  Text(
                    'In this short demo, you will learn how to scan NFC tags to read information, translate the scanned text into multiple languages in real-time, customize your language settings, and access your translation history. Tap "Get Started" to begin using the app when you’re ready!',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // const YGap(value: 10.0),
              PrimaryButton(
                onTap: () {
                  _videoPlayerController.pause();
                  _chewieController.pause();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (txt) => const HomeScreen()));
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
