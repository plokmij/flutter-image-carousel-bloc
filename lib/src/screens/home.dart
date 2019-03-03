import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import '../blocs/imageprovider.dart';

class Home extends StatelessWidget {
  int photoIndex = 0;

  List<String> photos = [
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2018/12/25/15457730278274.jpg",
    "http://outsideoftheboot.com/wp-content/uploads/2015/07/Jose-Gimenez-2015-Atletico.png",
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2017/12/03/15122952947600.jpg",
    "http://as01.epimg.net/futbol/imagenes/2017/06/04/primera/1496570307_204106_1496570423_noticia_normal.jpg",
    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201805/Diego-Costa.png",
    "https://shakarasquare.com/wp-content/uploads/2017/07/Saul-Niguez.jpg",
    "https://cdn-s3.si.com/s3fs-public/styles/marquee_large_2x/public/2018/09/28/koke-atletico-madrid-spain.jpg"
  ];

  void _previousImage(ImageBloc bloc) {
    photoIndex = (photoIndex - 1) % photos.length;
    bloc.changeImage(photoIndex);
  }

  void _nextImage(ImageBloc bloc) {
    photoIndex = (photoIndex + 1) % photos.length;
    bloc.changeImage(photoIndex);
  }

  Widget build(BuildContext context) {
    final bloc = ImageBloc();

    return Scaffold(
      appBar: AppBar(
        title: Text("Atleti Players"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: StreamBuilder(
              stream: bloc.image,
              builder: (context, snapshot) {
                return Stack(
                  children: <Widget>[
                    SwipeDetector(
                      onSwipeLeft: () {
                        _nextImage(bloc);
                      },
                      onSwipeRight: () {
                        _previousImage(bloc);
                      },
                      swipeConfiguration: SwipeConfiguration(
                          horizontalSwipeMinDisplacement: 10.0,
                          horizontalSwipeMinVelocity: 150.0,
                          horizontalSwipeMaxHeightThreshold: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                            image: NetworkImage(photos[snapshot.hasData?snapshot.data:photoIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 400.0,
                        width: 300.0,
                      ),
                    ),
                    Positioned(
                      top: 375.0,
                      left: 25.0,
                      right: 25.0,
                      child: SelectedPhoto(
                        numberOfDots: photos.length,
                        photoIndex: snapshot.hasData?snapshot.data:photoIndex,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
class Home extends StatefulWidget {
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int photoIndex = 0;

  List<String> photos = [
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2018/12/25/15457730278274.jpg",
    "http://outsideoftheboot.com/wp-content/uploads/2015/07/Jose-Gimenez-2015-Atletico.png",
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2017/12/03/15122952947600.jpg",
    "http://as01.epimg.net/futbol/imagenes/2017/06/04/primera/1496570307_204106_1496570423_noticia_normal.jpg",
    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201805/Diego-Costa.png",
    "https://shakarasquare.com/wp-content/uploads/2017/07/Saul-Niguez.jpg",
    "https://cdn-s3.si.com/s3fs-public/styles/marquee_large_2x/public/2018/09/28/koke-atletico-madrid-spain.jpg"
  ];

  void _previousImage() {
    setState(() {
      photoIndex = (photoIndex - 1) % photos.length;
      print(photoIndex);
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = (photoIndex + 1 )% photos.length;
      print(photoIndex);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atleti Players"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                SwipeDetector(
                  onSwipeLeft: (){
                    _nextImage();
                  },
                  onSwipeRight: (){
                    _previousImage();
                  },
                  swipeConfiguration: SwipeConfiguration(
                    horizontalSwipeMinDisplacement: 10.0,
                    horizontalSwipeMinVelocity: 150.0,
                    horizontalSwipeMaxHeightThreshold: 50.0
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      image: DecorationImage(
                        image: NetworkImage(photos[photoIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 400.0,
                    width: 300.0,
                  ),
                ),
                Positioned(
                  top: 375.0,
                  left: 25.0,
                  right: 25.0,
                  child: SelectedPhoto(
                    numberOfDots: photos.length,
                    photoIndex: photoIndex,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 2.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.0,
                  blurRadius: 2.0,
                )
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
