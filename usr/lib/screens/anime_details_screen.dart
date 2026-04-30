import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/anime.dart';
import '../providers/anime_provider.dart';

class AnimeDetailsScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailsScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnimeProvider>();
    final l10n = AppLocalizations.of(context)!;
    final isFav = provider.isFavorite(anime);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () {
                  context.read<AnimeProvider>().toggleFavorite(anime);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav ? l10n.removedFromFavorites : l10n.addedToFavorites,
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: anime.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: anime.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  : Container(color: Colors.grey),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn(context, Icons.star, l10n.rating, anime.score?.toString() ?? '-'),
                      _buildInfoColumn(context, Icons.ondemand_video, l10n.episodes, anime.episodes?.toString() ?? '-'),
                      _buildInfoColumn(context, Icons.info_outline, l10n.status, anime.status ?? l10n.unknown),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (anime.genres.isNotEmpty) ...[
                    Text(
                      l10n.genres,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: anime.genres.map((genre) {
                        return Chip(
                          label: Text(genre),
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (anime.airedString != null) ...[
                    Text(
                      l10n.releaseDate,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(anime.airedString!),
                    const SizedBox(height: 24),
                  ],
                  if (anime.synopsis != null) ...[
                    Text(
                      l10n.synopsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      anime.synopsis!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 32),
                  ],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
