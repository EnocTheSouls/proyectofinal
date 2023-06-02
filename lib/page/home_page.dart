import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal2/page/rickandmortyhome.dart';
import 'package:proyectofinal2/page/favorite_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.star_outlined)),
                Tab(icon: Icon(Icons.person_2_outlined)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //poder utilizar un padding o un container
              //Icon(Icons.directions_car),
              const Cocktail_Home(),
              const FavoriteScreen(),
              //Icon(Icons.directions_bike),

              Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SignIn',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        user.email!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 32,
                      ),
                      label: const Text(
                        'SignOut',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
