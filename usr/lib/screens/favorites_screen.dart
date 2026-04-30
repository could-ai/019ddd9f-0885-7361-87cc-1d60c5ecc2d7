import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnimeProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
        centerTitle: true,
      ),
      body: provider.favorites.isEmpty
          ? Center(child: Text(l10n.noFavoritesYet))
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final anime = provider.favorites[index];
                return AnimeCard(anime: anime);
              },
            ),
    );
  }
}
