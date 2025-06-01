import 'package:flutter/material.dart';

class PaginationHandler {
  int limit;
  ScrollController scrollController = ScrollController();
  int currentPage = 0;
  int totalPages = 1;
  bool isLoading = false;
  bool isDisable = false;
  int? totalDocs;
  Future<void> Function()? fetchData;
  PaginationHandler({this.limit = 10});
  int get nextPage {
    return currentPage + 1;
  }

  bool get hasMorePages {
    return currentPage < totalPages;
  }

  String get parameters {
    return "?page=$nextPage&limit=$limit";
  }

  String get parametersWithAndSymbol {
    return "&page=$nextPage&limit=$limit";
  }

  void handlingPaginationFromJson(Map<String, dynamic> json) {
    totalDocs = json["totalDocs"];
    totalPages = json["lastPage"];
    currentPage++;
    isLoading = false;
  }

  void resetHandler() {
    currentPage = 0;
    totalPages = 1;
    isLoading = false;
  }

  void addListenerToController({bool scrollToEnd = true}) {
    scrollController.addListener(
      () {
        if (!isDisable && hasMorePages && !isLoading) {
          if ((scrollToEnd &&
                  scrollController.position.pixels >=
                      (scrollController.position.maxScrollExtent * 0.5)) ||
              (!scrollToEnd &&
                  scrollController.position.pixels ==
                      scrollController.position.minScrollExtent)) {
            isLoading = true;
            fetchData!();
          }
        }
      },
    );
  }

  disable() {
    isDisable = true;
  }

  enable() {
    isDisable = false;
  }

  dispose() {
    scrollController.dispose();
  }
}
