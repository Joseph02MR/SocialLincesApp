import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/popular.dart';
import 'package:flutter_application_1/models/popular_cast.dart';
import 'package:flutter_application_1/models/popular_trailer.dart';
import 'package:flutter_application_1/network/api_popular.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/widgets/popular_cast_item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({super.key});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  DatabaseHelper? database;
  YoutubePlayerController? _controller;
  late Popular movie;
  ApiPopular? apiPopular;
  List<PopularTrailer>? results;
  List<PopularCast>? aux;
  late PopularTrailer video;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
  }

  // ignore: non_constant_identifier_names
  Future select_video(int id) async {
    results = await apiPopular?.getTrailer(id);
    if (results != null) {
      for (var element in results!) {
        if (element.type == 'Trailer' && element.site == 'YouTube') {
          _controller = YoutubePlayerController(
            initialVideoId: element.key,
            flags: const YoutubePlayerFlags(
                autoPlay: true, mute: true, loop: true),
          );
          return;
        }
      }
    } else {
      return null;
    }
  }

  Future<List<PopularCast>?> getCast(int id) async {
    aux = await apiPopular?.getCast(id);
    return aux;
  }

  // ignore: non_constant_identifier_names
  void update_isFav(id) async {
    isFav = (await database?.IS_FAV(id))!;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    if (ModalRoute.of(context)!.settings.arguments != null) {
      movie = ModalRoute.of(context)!.settings.arguments as Popular;
      select_video(movie.id!);
      update_isFav(movie.id!);
    }

    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: 'video_${movie.id}',
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.5,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                    fit: BoxFit.cover)),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: Image(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${movie.posterPath}')),
                ),
                Expanded(
                    child: Text(
                  movie.title!,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  movie.overview!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Calificación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: movie.voteAverage! / 2,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  '${movie.voteAverage!}',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            isFav
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          database?.DEL_FAV(movie.id!).then((value) {
                            var msg =
                                value > 0 ? 'Removida de favoritos' : 'Error';
                            var snackBar = SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            flag.setFlag_movieList();
                            update_isFav(movie.id!);
                          });
                        },
                        child: const Text('Remover de favoritos')),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          database?.INSERT('tblFavorites',
                              {'idMovie': movie.id}).then((value) {
                            var msg =
                                value > 0 ? 'Agregada a favoritos' : 'Error';
                            var snackBar = SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            flag.setFlag_movieList();
                            update_isFav(movie.id!);
                          });
                        },
                        child: const Text('Agregar a favoritos')),
                  ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Trailer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            FutureBuilder(
              future: select_video(movie.id!),
              builder: (context, snapshot) {
                if (_controller != null) {
                  return YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  );
                } else {
                  return Container();
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                'Reparto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 300.0,
              child: FutureBuilder(
                  future: getCast(movie.id!),
                  builder:
                      (context, AsyncSnapshot<List<PopularCast>?> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            snapshot.data != null ? snapshot.data!.length : 0,
                        itemBuilder: (context, index) {
                          return //null;
                              PopularCastItem(model: snapshot.data![index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Ocurrio un error'),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            )
          ],
        ),
      ],
    ));
  }
}
