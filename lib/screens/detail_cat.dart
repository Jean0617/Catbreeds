import 'package:catbreeds/models/cat_model.dart';
import 'package:flutter/material.dart';

import '../widgets/text.dart';

class DetailCat extends StatefulWidget{
  
  final CatModel cat;
  const DetailCat({super.key,required this.cat });

  @override
  State<DetailCat> createState() => _DetailCatState();
}

class _DetailCatState extends State<DetailCat>{

  final buscarC = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(234, 39, 31, 31),
            title: TextP(title: widget.cat.name,bold: true,color: Colors.white),
            toolbarHeight: 80,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Hero(
                      tag: 'hero-${widget.cat.name}',
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/progress.gif',
                        image: widget.cat.urlImage,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) => 
                        Image.asset('assets/img_error.png'),
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 10),
            
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: card(widget.cat),
                    ),
                  ),
                ),
            
                const SizedBox(height: 30),
            
              ],
            ),
          )
        );
  }

  card(CatModel cat){
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: createText('País',cat.origin,Icons.location_on_outlined)),
            ],
          ),
                        
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: createText('Inteligencia','${cat.intelligence}',Icons.interests_outlined)),
              Expanded(child: createText('Adaptabilidad','${cat.adaptability}',Icons.screen_rotation_alt_outlined)),
            ],
          ),
                
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: createText('Temperamento',cat.temperament,Icons.screen_rotation_alt_outlined)),
            ],
          ),
                  
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: createText('Descripción',cat.description,null)),
            ],
          ),
            
        ],
      ),
    );
  }

  createText(String title, String subTitle,IconData? ico) {
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

