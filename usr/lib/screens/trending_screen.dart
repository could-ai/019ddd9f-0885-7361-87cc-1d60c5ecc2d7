import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnimeProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        centerTitle: true,
      ),
      body: provider.isLoading && provider.topAnime.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.error.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.errorFetchingData),
                      ElevatedButton(
                        onPressed: () => context.read<AnimeProvider>().fetchTopAnime(),
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: provider.topAnime.length,
                  itemBuilder: (context, index) {
                    final anime = provider.topAnime[index];
                    return AnimeCard(anime: anime);
                  },
                ),
    );
  }
}
