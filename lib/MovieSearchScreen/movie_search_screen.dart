import 'package:flutter/material.dart';
import 'package:myapp/MovieSearchScreen/search_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context, listen: false).fetchTrendingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // search box
            SizedBox(
              child: TextField(
                // controller: _textController,
                onChanged: (value) => searchProvider.setSearchText(value),
                onSubmitted: (_) => searchProvider.searchMovies(),
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => searchProvider.searchMovies(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Loading Indicator or Movie Cards

            searchProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        itemCount: searchProvider.movies.length,
                        itemBuilder: (context, index) {
                          final movie = searchProvider.movies[index];
                          return SizedBox(
                            height: 200,
                            child: Stack(
                              clipBehavior: Clip
                                  .none, // Allows overflow outside the stack
                              children: [
                                // Card at the bottom
                                Positioned(
                                  bottom:
                                      0, // Aligns the card to the bottom of the stack
                                  left: 0, // Adjust left margin
                                  right: 0, // Adjust right margin
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation:
                                        10, // Adds shadow for a raised effect
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Reserve space for the image
                                          const SizedBox(height: 60),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 125,
                                              ),
                                              Column(children: [
                                                Text(
                                                  movie['Title'] ?? 'N/A',
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  movie['Year'] ?? 'N/A',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ])
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Image on top of the card
                                Positioned(
                                  top:
                                      35, // Allows the image to overflow above the stack
                                  left: 13, // Adjust to align with the card
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        movie['Poster'] ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
