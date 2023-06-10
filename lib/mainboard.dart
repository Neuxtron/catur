import 'package:flutter/material.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  final int kotakPerBaris = 8;
  final int jumlahKotak = 64;

  String warnaSaya = 'white';
  bool giliranSaya = true;

  // listKotak --> [posisi, jenis_bidak, warna, status_kotak]
  var listKotak = <List>[
    // status_kotak --> (terpilih, tersedia, bunuh)
    [0, 'rook', 'black', ''],
    [1, 'knight', 'black', ''],
    [2, 'bishop', 'black', ''],
    [3, 'queen', 'black', ''],
    [4, 'king', 'black', ''],
    [5, 'bishop', 'black', ''],
    [6, 'knight', 'black', ''],
    [7, 'rook', 'black', ''],
    [8, 'pawn', 'black', ''],
    [9, 'pawn', 'black', ''],
    [10, 'pawn', 'black', ''],
    [11, 'pawn', 'black', ''],
    [12, 'pawn', 'black', ''],
    [13, 'pawn', 'black', ''],
    [14, 'pawn', 'black', ''],
    [15, 'pawn', 'black', ''],
    [48, 'pawn', 'white', ''],
    [49, 'pawn', 'white', ''],
    [50, 'pawn', 'white', ''],
    [51, 'pawn', 'white', ''],
    [52, 'pawn', 'white', ''],
    [53, 'pawn', 'white', ''],
    [54, 'pawn', 'white', ''],
    [55, 'pawn', 'white', ''],
    [56, 'rook', 'white', ''],
    [57, 'knight', 'white', ''],
    [58, 'bishop', 'white', ''],
    [59, 'queen', 'white', ''],
    [60, 'king', 'white', ''],
    [61, 'bishop', 'white', ''],
    [62, 'knight', 'white', ''],
    [63, 'rook', 'white', ''],
  ];

  //--- Putar papan jika warna saya hitam ---//
  @override
  void initState() {
    if (warnaSaya == "black") {
      for (var element in listKotak) {
        element[0] = jumlahKotak - element[0] - 1;
      }
    }
    super.initState();
  }

  void dipencet(int index) {
    String bidak = "";
    //--- Jika pencet tempat kosong ---//
    if (!listKotak.any((element) => element[0] == index)) {
      var terpilih = listKotak.where((element) => element[3] == "terpilih");
      terpilih.isNotEmpty ? terpilih.first[3] = "" : {};
    }
    for (var element in listKotak) {
      if (giliranSaya) {
        if (element[0] == index) {
          //--- Jika pencet bidak ---//
          if (element[2] == warnaSaya) {
            var terpilih =
                listKotak.where((element) => element[3] == "terpilih");
            terpilih.isNotEmpty ? terpilih.first[3] = "" : {};
            element[3] = "terpilih";
            bidak = element[1];
            break;
          }

          //--- Jika pencet tempat tersedia ---//
          if (element[3] == "tersedia") {
            var terpilih =
                listKotak.where((element) => element[3] == "terpilih");
            terpilih.first[0] = index;
            terpilih.first[3] = "";
            break;
          }

          //--- Jika pencet tempat bunuh ---//
          if (element[3] == "bunuh") {
            var posKuburan = jumlahKotak + 16;
            for (var elementt in listKotak) {
              if (elementt[0] >= posKuburan) {
                posKuburan = elementt[0] + 1;
              }
            }
            for (var elementt in listKotak) {
              if (elementt[0] == index) {
                elementt[0] = posKuburan;
              }
            }
            var terpilih =
                listKotak.where((element) => element[3] == "terpilih");
            terpilih.first[0] = index;
            terpilih.first[3] = "";
            break;
          }
        }
      }
    }

    //--- Reset ---//
    setState(() {
      listKotak.removeWhere((element) => element[2] == '');
      for (var element in listKotak) {
        if (element[3] == "bunuh") {
          element[3] = "";
        }
      }
    });

    switch (bidak) {
      case "pawn":
        pion(index);
        break;
      case "rook":
        benteng(index);
        break;
      case "bishop":
        peluncur(index);
        break;
      case "knight":
        kuda(index);
        break;
      case "queen":
        ratu(index);
        break;
      case "king":
        raja(index);
        break;
      default:
    }
  }

  void pion(int index) {
    // Atas
    if (index - 8 >= 0 &&
        !listKotak.any((element) => (element[0] == index - 8))) {
      listKotak.add([index - 8, '', '', 'tersedia']);
    }

    // Atas kanan
    if (listKotak.any((element) => (element[0] == index - 7 &&
        element[2] != "" &&
        element[2] != warnaSaya))) {
      var row = listKotak.indexWhere((element) => element[0] == index - 7);
      listKotak[row][3] = "bunuh";
    }

    // Atas kiri
    if (listKotak.any((element) => (element[0] == index - 9 &&
        element[2] != "" &&
        element[2] != warnaSaya))) {
      var row = listKotak.indexWhere((element) => element[0] == index - 9);
      listKotak[row][3] = "bunuh";
    }
  }

  void benteng(int index) {
    // Atas
    for (var i = index - 8; i >= 0; i -= 8) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Bawah
    for (var i = index + 8; i < jumlahKotak; i += 8) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Kanan
    for (var i = index + 1; i % 8 > 0; i++) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Kiri
    for (var i = index - 1; i % 8 < 7; i--) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }
  }

  void peluncur(int index) {
    // Atas kiri
    for (var i = index - 9; i >= 0 && i % 8 < 7; i -= 9) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Atas kanan
    for (var i = index - 7; i >= 0 && i % 8 > 0; i -= 7) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Bawah kiri
    for (var i = index + 7; i >= 0 && i % 8 < 7; i += 7) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }

    // Bawah kanan
    for (var i = index + 9; i >= 0 && i % 8 > 0; i += 9) {
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] == warnaSaya)) {
        break;
      }
      if (listKotak.any((element) =>
          element[0] == i && element[2] != "" && element[2] != warnaSaya)) {
        var row = listKotak.indexWhere((element) => element[0] == i);
        listKotak[row][3] = "bunuh";
        break;
      }
      if (!listKotak.any((element) => element[0] == i)) {
        listKotak.add([i, '', '', 'tersedia']);
      }
    }
  }

  void kuda(int index) {
    List posTersediaKiri = [-17, -10, 6, 15];
    List posTersediaKanan = [-15, -6, 10, 17];

    // Kiri
    for (var pos in posTersediaKiri) {
      if ((index + pos) % 8 < index % 8) {
        if (listKotak.any((element) =>
            element[0] == index + pos &&
            element[2] != "" &&
            element[2] != warnaSaya)) {
          var row =
              listKotak.indexWhere((element) => element[0] == index + pos);
          listKotak[row][3] = "bunuh";
        }
        if (index + pos < jumlahKotak &&
            index + pos >= 0 &&
            !listKotak.any((element) => element[0] == index + pos)) {
          listKotak.add([index + pos, '', '', 'tersedia']);
        }
      }
    }

    // Kanan
    for (var pos in posTersediaKanan) {
      if ((index + pos) % 8 > index % 8) {
        if (listKotak.any((element) =>
            element[0] == index + pos &&
            element[2] != "" &&
            element[2] != warnaSaya)) {
          var row =
              listKotak.indexWhere((element) => element[0] == index + pos);
          listKotak[row][3] = "bunuh";
        }
        if (!listKotak.any((element) => element[0] == index + pos)) {
          listKotak.add([index + pos, '', '', 'tersedia']);
        }
      }
    }
  }

  void ratu(int index) {
    benteng(index);
    peluncur(index);
  }

  void raja(int index) {
    final bidak = listKotak.where((element) => element[0] == index).first;
    print(index);

    List posTersedia = [-8, 8];
    List posTersediaKiri = [-9, -1, 7];
    List posTersediaKanan = [-7, 1, 9];

    // Atas dan bawah
    for (var pos in posTersedia) {
      if (bidak[2] != "" && bidak[2] != warnaSaya) {
        bidak[3] = "bunuh";
      }
      if (index + pos >= 0 &&
          index + pos < jumlahKotak &&
          !listKotak.any((element) => element[0] == index + pos)) {
        listKotak.add([index + pos, '', '', 'tersedia']);
      }
    }

    // Kiri
    for (var pos in posTersediaKiri) {
      if ((index + pos) % 8 < index % 8) {
        if (bidak[2] != "" && bidak[2] != warnaSaya) {
          bidak[3] = "bunuh";
        }
        if (index + pos >= 0 &&
            index + pos < jumlahKotak &&
            !listKotak.any((element) => element[0] == index + pos)) {
          listKotak.add([index + pos, '', '', 'tersedia']);
        }
      }
    }

    // Kanan
    for (var pos in posTersediaKanan) {
      if ((index + pos) % 8 > index % 8) {
        if (bidak[2] != "" && bidak[2] != warnaSaya) {
          bidak[3] = "bunuh";
        }
        if (index + pos >= 0 &&
            index + pos < jumlahKotak &&
            !listKotak.any((element) => element[0] == index + pos)) {
          listKotak.add([index + pos, '', '', 'tersedia']);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
        child: Column(
          children: [
            // --- Kuburan Dia ---/
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: 16,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kotakPerBaris + 1),
                    itemBuilder: ((context, index) {
                      var gambar;

                      var kotak = listKotak.where(
                          (element) => element[0] == index + jumlahKotak);

                      if (kotak.isNotEmpty && kotak.first[1] != "") {
                        gambar = Image.asset(
                            "images/${kotak.first[1]}${kotak.first[2]}.png");
                      }

                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: gambar,
                      );
                    }),
                  )
                ],
              ),
            ),

            //--- Papan Catur ---/
            GridView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: jumlahKotak,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kotakPerBaris),
              itemBuilder: ((context, index) {
                //--- Deklarasi Variabel ---//
                int i = index;
                String gambar = "";
                Color warna;
                var anak;

                if (index % 16 > 7) {
                  i++;
                }

                warna = (i % 2 == 0)
                    ? Colors.white
                    : Theme.of(context).backgroundColor;

                //--- Penentuan Gambar ---//
                listKotak.forEach(((element) {
                  if (element[0] == index) {
                    if (element[1] != "") {
                      gambar = "images/${element[1]}${element[2]}.png";
                      anak = Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.asset(gambar),
                      );
                    }

                    //--- Penentuan Warna ---//
                    if (element[3] == "terpilih") {
                      warna = Colors.green.shade300;
                    }
                    if (element[3] == "tersedia") {
                      anak = Container(
                        color: Colors.green.shade300,
                      );
                    }
                    if (element[3] == "bunuh") {
                      anak = Container(
                        width: double.infinity,
                        color: Colors.red.shade300,
                        padding: const EdgeInsets.all(4),
                        child: Image.asset(gambar),
                      );
                    }
                  }
                }));

                //--- Ketika dipencet ---//
                return GestureDetector(
                  onTap: () => dipencet(index),

                  //--- Penampilan Gambar ---//
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: warna,
                    child: Center(
                      child: anak,
                    ),
                  ),
                );
              }),
            ),

            //--- Kuburan Saya ---/
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: 16,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kotakPerBaris + 1),
                    itemBuilder: ((context, index) {
                      var gambar;

                      var kotak = listKotak.where(
                          (element) => element[0] == index + jumlahKotak + 16);

                      if (kotak.isNotEmpty && kotak.first[1] != "") {
                        gambar = Image.asset(
                            "images/${kotak.first[1]}${kotak.first[2]}.png");
                      }

                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: gambar,
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
