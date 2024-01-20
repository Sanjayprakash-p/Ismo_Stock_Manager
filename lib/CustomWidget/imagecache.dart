// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// catchimage(String imageurl) {
//   final cachemanager = CacheManager(Config('customCacheKey',
//       stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 100));
//   return CachedNetworkImage(
//     cacheManager: cachemanager,
//     imageUrl: imageurl,
//     imageBuilder: (context, imageProvider) => Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//           // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//         ),
//       ),
//     ),
//     placeholder: (context, url) => const CircularProgressIndicator(),
//     errorWidget: (context, url, error) => const Icon(Icons.error),
//   );
// }
