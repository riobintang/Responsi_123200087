import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsi_123200087/Controller.dart';
import 'package:responsi_123200087/listFood.dart';

import 'categoryModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Category"),
        centerTitle: true,
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return Container(
      child: FutureBuilder(future: Controller.instance.loadCategory(),  
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Data list = Data.fromJson(snapshot.data);
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

  Widget _buildSuccessSection(Data data) {
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemFood(data.categories![index]);
      },
    );
  }

  Widget _buildItemFood(Categories categories) {
    return InkWell(
      onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListFood(data: categories.strCategory))
        ),
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(categories.strCategoryThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Text(categories.strCategory!),
          ],
        ),
      ),
    );
  }

}
