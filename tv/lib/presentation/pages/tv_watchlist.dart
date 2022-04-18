import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';

class WatchlistTvpage extends StatefulWidget {
  @override
  State<WatchlistTvpage> createState() => _WatchlistTvpageState();
}

class _WatchlistTvpageState extends State<WatchlistTvpage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvWatchlistPageBloc>(context, listen: false)
        ..add(TvWatchlistpageEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<TvWatchlistPageBloc>(context, listen: false)
      ..add(TvWatchlistpageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistPageBloc, TvWatchlistPageState>(
          builder: (context, state) {
            if (state is TvWatchlistPageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchlistPageHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return Text('');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
