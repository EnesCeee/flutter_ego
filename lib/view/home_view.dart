import 'package:flutter/material.dart';


import '../viewModel/home_view_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [isLoading ? const CircularProgressIndicator() : const SizedBox()],
        title: const Text("Hat List"),
      ),
      body: items == null
          ? const Placeholder()
          : Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by Hat Numarasi or Hat Türü",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items?[index].adi ?? ""),
                        subtitle: Text(items?[index].numarasi ?? ""),
                        trailing: Text(items?[index].turu ?? ""),
                        leading: Text(items?[index].uzunlugu ?? ""),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
