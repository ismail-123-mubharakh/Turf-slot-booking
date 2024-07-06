import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slot_booking_app/Home/model/venue_list_model.dart';
import 'package:slot_booking_app/Home/view_model/venue_list_view_model.dart';

class VenueListScreen extends StatefulWidget {
  const VenueListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return VenueListScreenState();
  }
}

class VenueListScreenState extends State<VenueListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    context.read<VenueListViewModel>().getVenueList(context);
    _tabController = TabController(
        length: context.read<VenueListViewModel>().sportList!.length,
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VenueListViewModel>(builder: (context, snapshot, _) {
      return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text("Venue List")),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs:
                  snapshot.sportList!.map((sport) => Tab(text: sport)).toList(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            snapshot.isSearchEnabled(true);
                            snapshot.setSearchList(
                                snapshot.searchController, context);
                          },
                          controller: snapshot.searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: Icon(Icons.clear)),
                              ),
                              onPressed: () {
                                snapshot.searchController.clear();
                                snapshot.isSearchEnabled(false);
                              },
                            ),
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search By Venue Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sorted by :'),
                      Text("Distance"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                      controller: _tabController,
                      children: snapshot.sportList!.map((sport) {
                        List<VenueListModel>? filteredVenues = snapshot.isSearch
                            ? snapshot.filteredVenues
                            : snapshot.filterVenuesBySport(sport);
                        return filteredVenues != null && !snapshot.inProgress
                            ? ListView.builder(
                                itemCount: filteredVenues.length,
                                itemBuilder: (context, index) {
                                  var venue = filteredVenues[index];
                                  return VenueListData(
                                    name: venue.name!,
                                    address: venue.address!,
                                    kilometer: venue.kilometres.toString(),
                                    rating: venue.rating.toString(),
                                    id: venue.id.toString(),
                                  );
                                },
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                    child: CupertinoActivityIndicator()));
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class VenueListData extends StatelessWidget {
  final String name;
  final String address;
  final String kilometer;
  final String rating;
  final String id;

  const VenueListData({
    super.key,
    required this.name,
    required this.address,
    required this.kilometer,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.all( 62.0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(address),
            const SizedBox(height: 4),
            Text("Distance :$kilometer"),
            const SizedBox(height: 8),
            Text("Rating :$rating"),
            const SizedBox(height: 8),
            Text("Id :$id"),
          ],
        ),
      ),
    );
  }
}
