import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:catbreeds/blocs/home/home_bloc.dart';
import 'package:catbreeds/models/cat_model.dart';
import 'package:catbreeds/screens/detail_cat.dart';
import 'package:catbreeds/widgets/textfield.dart';
import '../widgets/text.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  final buscarC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add((SearchCatsEvent('',1))); 
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(234, 39, 31, 31),
              title: const TextP(title:'CatBreeds',bold: true,color: Colors.white),
              bottom: PreferredSize(
                preferredSize: const Size(100, 80), 
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFieldP(
                    title: 'Buscar',
                    controller: buscarC,
                    onChanged: (value){
      
                      if (!state.isLoading) {
                        if (value.isEmpty) {
                          context.read<HomeBloc>().add((SearchCatsEvent('',1)));
                        }else{
                          context.read<HomeBloc>().add((SearchCatsByRaceEvent(value.toLowerCase())));
                        }
                      }
      
                    },
                    onPressed: (){
                      if (buscarC.text.isEmpty) {
                        context.read<HomeBloc>().add((SearchCatsEvent('',1)));
                      }else{
                        context.read<HomeBloc>().add((SearchCatsByRaceEvent(buscarC.text.toLowerCase())));
                      }
                    },
                  ),
                )
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              toolbarHeight: 80,
            ),
            body: (state.data.isEmpty || state.data.length < 10) && state.isLoading? 
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/progress.gif',scale: 5),
                      const TextP(title: 'Cargando...')
                    ],
                  ),
                )
             :
             state.data.isEmpty && !state.isLoading?
             noData()
             :
             ListView(
                children: List.generate(state.data.length, (i) => 
                state.data.length > 9 && i == (state.data.length - 1)? 
                  Column(
                    children: [
                      card(state.data[i]),
                      state.isLoading?
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextP(title: 'Cargando...',color: Color.fromARGB(234, 39, 31, 31)),
                        )
                      :
                      TextButton(
                        onPressed: (){
                          int page = state.page + 1 ;
                          context.read<HomeBloc>().add((ChangePageEvent(page)));
                          context.read<HomeBloc>().add((SearchCatsEvent('',page)));
                        }, 
                        child: const TextP(title: 'Ver mas...',color: Color.fromARGB(234, 39, 31, 31))
                      )
                    ]
                  )
                  
                : 
                  card(state.data[i]),
              )
            ),
          );
        },
      ),
    );
  }

  noData(){
    return const ListTile(
      leading: Icon(Icons.error_outline,color: Colors.orange),
      title: TextP(title: 'Información',bold: true),
      subtitle: TextP(title: 'No se encontro información. intente presionando el boton de busqueda.'),
    );
  }

  card(CatModel cat){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Hero(
                tag: 'hero-${cat.name}',
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/progress.gif',
                  image: cat.urlImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) => 
                  Image.asset('assets/img_error.png')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: createText('Nombre - raza',cat.name,Icons.text_fields_rounded)),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: createText('País',cat.origin,Icons.location_on_outlined)),
                      Expanded(child: createText('Inteligencia','${cat.intelligence}',Icons.interests_outlined)),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(234, 39, 31, 31)),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                          ),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailCat(cat: cat)),
                            );

                          },
                          child: const TextP(title: 'Ver más',color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  createText(String title, String subTitle,IconData ico) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Icon(ico),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$title ',style: const TextStyle(fontWeight: FontWeight.bold)),
          ]
        )
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: subTitle)
          ]
        )
      )
    );
  }

}

