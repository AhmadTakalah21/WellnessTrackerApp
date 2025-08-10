// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// // 🔧 حدّد الـ baseUrl لتحويل المسارات النسبية إلى مطلقة
//
// bool _isWebUrl(String s) => s.startsWith('http://') || s.startsWith('https://');
//
// bool _isVideo(String s) {
//   final l = s.toLowerCase();
//   return l.endsWith('.mp4') || l.endsWith('.mov') || l.endsWith('.mkv') || l.endsWith('.webm');
// }
//
// bool _isImage(String s) {
//   final l = s.toLowerCase();
//   return l.endsWith('.png') || l.endsWith('.jpg') || l.endsWith('.jpeg') || l.endsWith('.gif') || l.endsWith('.webp');
// }
//
// String _absoluteLink(String link) {
//   if (link.isEmpty) return '';
//   return _isWebUrl(link) ? link : '$_baseUrl/$link';
// }
//
// Future<void> _openExternal(String url) async {
//   final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//   if (!ok && mounted) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('cannot_open_link'.tr())),
//     );
//   }
// }
//
// void _onPlayLink(String raw) {
//   final url = _absoluteLink(raw);
//   if (url.isEmpty) return;
//
//   if (_isVideo(url)) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => VideoPlayerPage(url: url)),
//     );
//   } else if (_isImage(url)) {
//     showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: InteractiveViewer(
//           minScale: 0.7,
//           maxScale: 4,
//           child: Image.network(url, fit: BoxFit.contain),
//         ),
//       ),
//     );
//   } else {
//     _openExternal(url);
//   }
// }
//
// /// صفحة مشغّل الفيديو (Chewie + VideoPlayer)
// class VideoPlayerPage extends StatefulWidget {
//   const VideoPlayerPage({super.key, required this.url});
//   final String url;
//
//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }
//
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late VideoPlayerController _videoCtrl;
//   ChewieController? _chewieCtrl;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }
//
//   Future<void> _init() async {
//     _videoCtrl = VideoPlayerController.networkUrl(Uri.parse(widget.url));
//     await _videoCtrl.initialize();
//     _chewieCtrl = ChewieController(
//       videoPlayerController: _videoCtrl,
//       autoPlay: true,
//       looping: false,
//       allowFullScreen: true,
//       allowMuting: true,
//       materialProgressColors: ChewieProgressColors(),
//     );
//     if (mounted) setState(() => _loading = false);
//   }
//
//   @override
//   void dispose() {
//     _chewieCtrl?.dispose();
//     _videoCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('video'.tr())),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : Center(
//         child: AspectRatio(
//           aspectRatio: _videoCtrl.value.aspectRatio == 0
//               ? 16 / 9
//               : _videoCtrl.value.aspectRatio,
//           child: Chewie(controller: _chewieCtrl!),
//         ),
//       ),
//     );
//   }
// }
