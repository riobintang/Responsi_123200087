import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:responsi_123200087/foodDetailModel.dart';
import 'package:responsi_123200087/tesDetail.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:responsi_123200087/mealsModel.dart';

import 'Controller.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key, this.idFood});
  final String? idFood;
  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Detail"),
        centerTitle: true,
      ),
      body: _buildFoodDetailView(),
    );
  }

  Widget _buildFoodDetailView() {
    return Container(
      child: FutureBuilder(
          future: Controller.instance.loadFoodDetail(widget.idFood!),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              AutoGenerate data = AutoGenerate.fromJson(snapshot.data);
              //return Column(children: [Text('success')],);
              //log("data - $data");
              return _buildSuccessSection(data);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(AutoGenerate data) {
    return _BuildDetailFood(data.meals!.first);
  }

  Widget _BuildDetailFood(Meals data) {
    final Uri _url = Uri.parse(data.strYoutube);
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          data.strMeal!,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            child: Image.network(
              data.strMealThumb,
              alignment: Alignment.center,
            ),
            width: 200,
            height: 200,
          ),
        ),
        Text(
          "Category: " + data.strCategory,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Area: " + data.strArea,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          data.strInstructions,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 10,
          child: ElevatedButton(
            onPressed: _launchUrl,
            child: Text('Lihat Youtube'),
          ),
        ),
      ],
    );
    // return Column(
    //   children: [
    //     SizedBox(
    //       height: 20,
    //     ),
    //     Text(data.strMeal!),
    //     SizedBox(
    //       height: 20,
    //     ),
    //     Center(
    //       child: Container(
    //         child: Image.network(
    //           data.strMealThumb,
    //           alignment: Alignment.center,
    //         ),
    //         width: 200,
    //         height: 200,
    //       ),
    //     ),
    //     Text(
    //       "Category: " + data.strCategory,
    //       style: TextStyle(fontSize: 20),
    //     ),
    //     Text(
    //       "Area: " + data.strArea,
    //       style: TextStyle(fontSize: 20),
    //     ),
    //     Text(
    //       data.strInstructions,
    //       style: TextStyle(fontSize: 15),
    //     ),
    //     ElevatedButton(
    //       onPressed: _launchUrl,
    //       child: Text('Lihat Youtube'),
    //     ),
    //   ],
    // );
  }
}
