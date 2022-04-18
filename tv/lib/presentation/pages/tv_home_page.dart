import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvNowPlayingBloc>(context).add(TvNowPlayingEvent());
      BlocProvider.of<TvPopularBloc>(context).add(TvPopularEvent());
      BlocProvider.of<TvTopRatedBloc>(context).add(TvTopRatedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TV_SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
                builder: (context, state) {
                  if (state is TvNowPlayingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvNowPlayingHasData) {
                    final tv = state.result;
                    return TvList(tv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (context, state) {
                  if (state is TvPopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvPopularHasData) {
                    final tv = state.result;
                    return TvList(tv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (context, state) {
                  if (state is TvTopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvTopRatedHasData) {
                    final tv = state.result;
                    return TvList(tv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
