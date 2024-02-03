import 'package:database/database%20services/database_helper.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{
            await DatabaseHelper.instance.insert({DatabaseHelper.columnName:'Saud'});
          }, child:const Text('Create')),
          ElevatedButton(onPressed: ()async{
            var dbquery=await DatabaseHelper.instance.queryDatabase();
            print(dbquery);
          }, child:const Text('Read')),
          ElevatedButton(onPressed: () async {
            await DatabaseHelper.instance.updateRecord({
              DatabaseHelper.columnId:2,
              DatabaseHelper.columnName:'Khan'
            });
          }, child:const Text('Update')),
          ElevatedButton(onPressed: ()async{
            await DatabaseHelper.instance.deleteRecord(2);
          }, child:const Text('Delete')),
        ],
      ),
    );
  }
}
