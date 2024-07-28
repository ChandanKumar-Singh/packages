import 'package:flutter/material.dart';

import '../../../widgets/index.dart';
import 'location_history.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: widget.initialIndex ?? 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location History')),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Location List'),
              Tab(text: 'Map'),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                LocationHistory(),
                MapSample(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
