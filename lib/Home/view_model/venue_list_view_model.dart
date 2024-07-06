import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slot_booking_app/Home/model/venue_list_model.dart';
import 'package:slot_booking_app/Home/screen/venue_list_screen.dart';
import 'package:slot_booking_app/Home/service/venue_list_service.dart';

class VenueListViewModel extends ChangeNotifier {
  List<VenueListModel>? venueList;
  List<VenueListModel>? sortedList;
  List<VenueListModel>? searchList;
  List<VenueListModel>? filteredVenues;

  bool inProgress = false;
  bool isSorted = false;
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();

  List<String>? sportList = [
    "Cricket",
    "Football",
    "Badminton",
    "Tennis",
    "Basketball",
    "Volleyball",
    "Table Tennis",
    "Swimming",
    "Golf",
    "Adventure Sports",
    "Rock Climbing",
    "Ultimate Frisbee",
    "Hockey",
    "Squash",
    "Boxing",
    "Archery"
  ];
  isLoading(bool value) {
    inProgress = value;
  }

  getVenueList(BuildContext context) async {
    isLoading(true);
    await VenueListService.fetchVenueList().then((value) {
      venueList = [];
      if (value != null) {
        for (var data in value) {
          venueList!.add(data);
          sortedList = List.from(venueList!);
          getSortedData(sortedList!, 0, sortedList!.length - 1);
          venueList = sortedList!.toSet().toList();
          filterVenuesBySport(sportList.toString());
        }
        debugPrint("list data ${venueList!.first.name!}");
        isLoading(false);
      }
    });
    notifyListeners();
  }

  navigateToLoginScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VenueListScreen()));
    });
  }

  venueListSort() {
    sortedList = [];
    if (isSorted) {
      venueList!.sort((a, b) => a.kilometres!.compareTo(b.kilometres!));
      for (var sortedData in venueList!) {
        sortedList!.add(sortedData);
        sortedList!.toSet();
      }
    }
    notifyListeners();
  }

  isSortedEnabled(bool value) {
    isSorted = value;
  }

  setSearchList(TextEditingController searchController, BuildContext context) {
    searchList = [];
    if (isSearch) {
      if (searchController.text.isNotEmpty) {
        filteredVenues = venueList!
            .where((venue) => venue.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      } else {
        notifyListeners();
        venueList;
      }
    } else {
      venueList;
    }
    notifyListeners();
  }

  isSearchEnabled(bool value) {
    isSearch = value;
    notifyListeners();
  }

  List<VenueListModel>? filterVenuesBySport(String sport) {
    return venueList != null
        ? venueList!.where((venue) => venue.sports!.contains(sport)).toList()
        : null;
  }

  void getSortedData(List<VenueListModel> list, int min, int max) {
    if (min < max) {
      int pivotIndex = getPartitionedData(list, min, max);
      getSortedData(list, min, pivotIndex - 1);
      getSortedData(list, pivotIndex + 1, max);
    }
  }

  int getPartitionedData(List<VenueListModel> list, int min, int max) {
    VenueListModel pivot = list[max];
    int i = min - 1;
    for (int j = min; j < max; j++) {
      if (list[j].kilometres! <= pivot.kilometres!.toDouble()) {
        i++;
        VenueListModel temp = list[i];
        list[i] = list[j];
        list[j] = temp;
      }
    }
    VenueListModel temp = list[i + 1];
    list[i + 1] = list[max];
    list[max] = temp;
    return i + 1;
  }
}
