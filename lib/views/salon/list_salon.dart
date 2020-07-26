
import 'package:beehairsalon/services/salon_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beehairsalon/config/palette.dart';
import 'package:beehairsalon/config/styles.dart';
import 'package:beehairsalon/data/data.dart';
import 'package:beehairsalon/widgets/widgets.dart';

class SalonScreen extends StatefulWidget {

  SalonScreen({Key key , this.title}) : super(key : key);
  final String title;

  @override
  _SalonScreenState createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen> {

  SalonService salonService = new SalonService();



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: new FutureBuilder<List>(
        future: salonService.getData(),
        builder: (context ,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(list: snapshot.data)
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
      drawer: CustomDrawer(),
    );
  }


  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: new FutureBuilder<List>(
          future: salonService.getData(),
          builder: (context ,snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
                : new Center(child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}


class ItemList extends StatelessWidget {

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
//                    builder: (BuildContext context) => new ShowData(list:list , index:i,)
                ),

              ) ,
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['name']),

                ),
              )
              ,
            ),
          );

        }
    );
  }

}
