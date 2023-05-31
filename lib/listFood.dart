import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi_123200087/foodDetail.dart';
import 'package:responsi_123200087/mealsModel.dart';

import 'Controller.dart';

class ListFood extends StatefulWidget {
  const ListFood({super.key, this.data});
  final String? data;
  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data! + "Meal"),
        centerTitle: true,
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return Container(
      child: FutureBuilder(future: Controller.instance.loadMeals(widget.data!),  
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Food list = Food.fromJson(snapshot.data);
              return _buildSuccessSection(list);
            }
            return _buildLoadingSection();
          }),);
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(Food data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemFood(data.meals![index]);
      },
    );
  }

  Widget _buildItemFood(Meals meals) {
    return InkWell(
      onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetail(idFood: meals.idMeal))
        ),
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(meals.strMealThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Text(meals.strMeal!),
          ],
        ),
      ),
    );
  }

}
