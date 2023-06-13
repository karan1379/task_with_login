import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/helper/shared_prefrence_helper.dart';
import 'package:task_with_login/model/movie_detail_model.dart';
import 'package:task_with_login/model/movie_model.dart';
import 'package:task_with_login/utils/api_constants.dart';

class HomeScreenController extends GetxController{

  Dio dio=Dio();
  var newsPageOffset = 1.obs;

  RxList<MovieModel> moviesList = RxList();
  late SharedPreferenceHelper preferenceHelper;
  ScrollController scrollController = ScrollController();
  RxBool isSearch = false.obs;
  final movieDetailModel = Rxn<MovieDetailModel>();


  @override
  void onInit() {
    preferenceHelper=SharedPreferenceHelper();

    getList(1);
    scrollController.addListener(loadMore);
    super.onInit();
  }

  //if(response.data["page"]==1){
  //           var list = (response.data["results"] as List).map((e) => MovieModel.fromJson(e)).toList();
  //           moviesList.clear();
  //           moviesList.addAll(list);
  //           moviesList.refresh();
  //         }else{
  //           var list = (response.data["results"] as List).map((e) => MovieModel.fromJson(e)).toList();
  //           var previousFavProducts = moviesList;
  //           previousFavProducts.addAll(list);
  //           list.addAll(previousFavProducts);
  //           moviesList.clear();
  //           moviesList.addAll(list);
  //           moviesList.refresh();
  //         }


  void loadMore() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
     newsPageOffset.value++;
      if (isSearch.value) {
       // searchMovie(searchController.text.trim(), page.value);
      } else {
        // allMovies(page.value++);
        getList(newsPageOffset.value++);
      }
    }
  }

  Future<List<MovieModel>?> getList(num page) async {
    try {
      Map<String, dynamic> queries = HashMap();
      queries["page"]=page;
      queries["language"]="en-US";
      queries["api_key"]=ApiConstants.apiKey;
      print("queries===> $queries");
      final response = await dio.get(ApiConstants.popularMovies, queryParameters:queries);
      if (response.statusCode == 200) {
        if(response.data["page"]==1){
          var list = (response.data["results"] as List).map((e) => MovieModel.fromJson(e)).toList();
          moviesList.clear();
          moviesList.addAll(list);
          moviesList.refresh();
        }else{
          var list = (response.data["results"] as List).map((e) => MovieModel.fromJson(e)).toList();
          var previousFavProducts = moviesList;
          previousFavProducts.addAll(list);
          list.addAll(previousFavProducts);
          moviesList.clear();
          moviesList.addAll(list);
          moviesList.refresh();
                }
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Error",));
      }
    } catch (e) {
      print(e);
    }
    return moviesList.value;
  }

  Future<MovieDetailModel?> movieDetails(int id) async {
    try {
      Map<String, dynamic> queries = HashMap();
      // queries["page"]=1;
      // queries["language"]="en-US";
      queries["api_key"]=ApiConstants.apiKey;
      print("queries===> $queries");
      var response = await dio.get("${ApiConstants.movieDetails}/$id", queryParameters: queries,);
      if (response.statusCode == 200) {
        movieDetailModel.value=MovieDetailModel.fromJson(response.data);
      } else {
        Get.showSnackbar(const GetSnackBar(message: "Error",));
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  reset() {
    isSearch.value=false;
    newsPageOffset.value=1;
    moviesList.clear();
  }


}