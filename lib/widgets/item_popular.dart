import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/popular.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/screens/video_details_screen.dart';
import 'package:provider/provider.dart';

class ItemPopular extends StatefulWidget {
  const ItemPopular({super.key, required this.model, required this.show});

  final Popular model;
  final bool show;

  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  DatabaseHelper? database;
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper();
    update_isFav(widget.model.id);
  }

  void update_isFav(id) async {
    isFav = await database!.IS_FAV(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    if (!widget.show || (widget.show && isFav)) {
      return Stack(
        children: [
          InkWell(
              onTap: () {
                // Navigator.of(context, rootNavigator: true)
                //    .pushNamed('/popular_details', arguments: widget.model);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoDetailsScreen(
                        movie: widget.model,
                      ),
                    )).then((value) => {
                      flag.setFlag_movieList(),
                      setState(() {
                        update_isFav(widget.model.id!);
                        flag.setFlag_movieList();
                      }),
                    });
              },
              child: Hero(
                tag: 'video_${widget.model.id}',
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: const AssetImage('assets/images/loading__.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${widget.model.posterPath}'),
                ),
              )),
          isFav
              ? IconButton(
                  alignment: Alignment.topRight,
                  onPressed: () {
                    database?.DEL_FAV(widget.model.id!).then((value) {
                      var msg = value > 0 ? 'Removida de favoritos' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlag_movieList();
                      update_isFav(widget.model.id!);
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
              : IconButton(
                  alignment: Alignment.topRight,
                  onPressed: () {
                    database?.INSERT('tblFavorites',
                        {'idMovie': widget.model.id}).then((value) {
                      var msg = value > 0 ? 'Agregada a favoritos' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlag_movieList();
                      update_isFav(widget.model.id!);
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ))
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
