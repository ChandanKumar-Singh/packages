import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/business_logics/blocs/index.dart';
import 'package:tracker/data/models/index.dart';

class LocationHistory extends StatefulWidget {
  const LocationHistory({super.key});

  @override
  State<LocationHistory> createState() => _LocationHistoryState();
}

class _LocationHistoryState extends State<LocationHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CupertinoScrollbar(
          thickness: 20,
          thumbVisibility: true,
          radius: const Radius.circular(10),
          scrollbarOrientation: ScrollbarOrientation.right,
          child: ListView.builder(
            // controller: _scrollController,
            itemCount: state.locations.reversed.length,
            itemBuilder: (context, index) {
              LocationModel location = state.locations.reversed.toList()[index];
              return ListTile(
                title: Text(location.latitude.toString()),
                subtitle: Text(location.longitude.toString()),
                trailing: Text(
                  location.time
                      .toDate()
                      .toString()
                      .formatDate(format: 'hh:mm:ss a'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
