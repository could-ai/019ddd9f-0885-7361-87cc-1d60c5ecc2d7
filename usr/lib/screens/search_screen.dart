import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    context.read<AnimeProvider>().searchAnime(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnimeProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: '${l10n.search}...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: _onSearch,
            ),
          ),
          onSubmitted: (_) => _onSearch(),
        ),
      ),
      body: provider.isLoading && provider.searchData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.searchData.isEmpty && _controller.text.isNotEmpty && !provider.isLoading
              ? const Center(child: Text('No results found'))
              : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: provider.searchData.length,
                  itemBuilder: (context, index) {
                    final anime = provider.searchData[index];
                    return AnimeCard(anime: anime);
                  },
                ),
    );
  }
}
