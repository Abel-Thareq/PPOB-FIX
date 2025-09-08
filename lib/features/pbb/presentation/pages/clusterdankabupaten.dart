import 'package:flutter/material.dart';

// Kelas data yang berisi daftar provinsi, kota, dan tahun.
class PBBData {
  static const List<String> allProvinces = [
    'Aceh', 'Sumatera Utara', 'Sumatera Barat', 'Riau', 'Jambi', 'Sumatera Selatan', 'Bengkulu', 'Lampung',
    'Kepulauan Bangka Belitung', 'Kepulauan Riau', 'DKI Jakarta', 'Jawa Barat', 'Jawa Tengah', 'DI Yogyakarta',
    'Jawa Timur', 'Banten', 'Bali', 'Nusa Tenggara Barat', 'Nusa Tenggara Timur', 'Kalimantan Barat',
    'Kalimantan Tengah', 'Kalimantan Selatan', 'Kalimantan Timur', 'Kalimantan Utara', 'Sulawesi Utara',
    'Sulawesi Tengah', 'Sulawesi Selatan', 'Sulawesi Tenggara', 'Gorontalo', 'Sulawesi Barat',
    'Maluku', 'Maluku Utara', 'Papua Barat', 'Papua'
  ];

  static const Map<String, List<String>> allCities = {
    "Aceh": [
      "Kabupaten Aceh Barat",
      "Kabupaten Aceh Barat Daya",
      "Kabupaten Aceh Besar",
      "Kabupaten Aceh Jaya",
      "Kabupaten Aceh Selatan",
      "Kabupaten Aceh Singkil",
      "Kabupaten Aceh Tamiang",
      "Kabupaten Aceh Tengah",
      "Kabupaten Aceh Tenggara",
      "Kabupaten Aceh Timur",
      "Kabupaten Aceh Utara",
      "Kabupaten Bener Meriah",
      "Kabupaten Bireuen",
      "Kabupaten Gayo Lues",
      "Kabupaten Nagan Raya",
      "Kabupaten Pidie",
      "Kabupaten Pidie Jaya",
      "Kabupaten Simeulue",
      "Kota Banda Aceh",
      "Kota Langsa",
      "Kota Lhokseumawe",
      "Kota Sabang",
      "Kota Subulussalam",
    ],

    "Sumatera Utara": [
      "Kabupaten Asahan",
      "Kabupaten Batu Bara",
      "Kabupaten Dairi",
      "Kabupaten Deli Serdang",
      "Kabupaten Humbang Hasundutan",
      "Kabupaten Karo",
      "Kabupaten Labuhanbatu",
      "Kabupaten Labuhanbatu Selatan",
      "Kabupaten Labuhanbatu Utara",
      "Kabupaten Langkat",
      "Kabupaten Mandailing Natal",
      "Kabupaten Nias",
      "Kabupaten Nias Barat",
      "Kabupaten Nias Selatan",
      "Kabupaten Nias Utara",
      "Kabupaten Padang Lawas",
      "Kabupaten Padang Lawas Utara",
      "Kabupaten Pakpak Bharat",
      "Kabupaten Samosir",
      "Kabupaten Serdang Bedagai",
      "Kabupaten Simalungun",
      "Kabupaten Tapanuli Selatan",
      "Kabupaten Tapanuli Tengah",
      "Kabupaten Tapanuli Utara",
      "Kabupaten Toba",
      "Kota Binjai",
      "Kota Gunungsitoli",
      "Kota Medan",
      "Kota Padangsidimpuan",
      "Kota Pematangsiantar",
      "Kota Sibolga",
      "Kota Tanjungbalai",
      "Kota Tebing Tinggi",
    ],

    "Sumatera Barat": [
      "Kabupaten Agam",
      "Kabupaten Dharmasraya",
      "Kabupaten Kepulauan Mentawai",
      "Kabupaten Lima Puluh Kota",
      "Kabupaten Padang Pariaman",
      "Kabupaten Pasaman",
      "Kabupaten Pasaman Barat",
      "Kabupaten Pesisir Selatan",
      "Kabupaten Sijunjung",
      "Kabupaten Solok",
      "Kabupaten Solok Selatan",
      "Kabupaten Tanah Datar",
      "Kota Bukittinggi",
      "Kota Padang",
      "Kota Padang Panjang",
      "Kota Pariaman",
      "Kota Payakumbuh",
      "Kota Sawahlunto",
      "Kota Solok",
    ],

    "Riau": [
      "Kabupaten Bengkalis",
      "Kabupaten Indragiri Hilir",
      "Kabupaten Indragiri Hulu",
      "Kabupaten Kampar",
      "Kabupaten Kepulauan Meranti",
      "Kabupaten Kuantan Singingi",
      "Kabupaten Pelalawan",
      "Kabupaten Rokan Hilir",
      "Kabupaten Rokan Hulu",
      "Kabupaten Siak",
      "Kota Dumai",
      "Kota Pekanbaru",
    ],

    "Kepulauan Riau": [
      "Kabupaten Bintan",
      "Kabupaten Karimun",
      "Kabupaten Kepulauan Anambas",
      "Kabupaten Lingga",
      "Kabupaten Natuna",
      "Kota Batam",
      "Kota Tanjungpinang",
    ],

    "DKI Jakarta": [
      "Jakarta Pusat",
      "Jakarta Utara",
      "Jakarta Selatan",
      "Jakarta Barat",
      "Jakarta Timur",
      "Kepulauan Seribu"
    ],

    "Jawa Barat": [
      "Kabupaten Bandung",
      "Kabupaten Bandung Barat",
      "Kabupaten Bekasi",
      "Kabupaten Bogor",
      "Kabupaten Ciamis",
      "Kabupaten Cianjur",
      "Kabupaten Cirebon",
      "Kabupaten Garut",
      "Kabupaten Indramayu",
      "Kabupaten Karawang",
      "Kabupaten Kuningan",
      "Kabupaten Majalengka",
      "Kabupaten Pangandaran",
      "Kabupaten Purwakarta",
      "Kabupaten Subang",
      "Kabupaten Sukabumi",
      "Kabupaten Sumedang",
      "Kabupaten Tasikmalaya",
      "Kota Bandung",
      "Kota Banjar",
      "Kota Bekasi",
      "Kota Bogor",
      "Kota Cimahi",
      "Kota Cirebon",
      "Kota Depok",
      "Kota Sukabumi",
      "Kota Tasikmalaya",
    ],

    "Jawa Tengah": [
      "Kabupaten Banjarnegara",
      "Kabupaten Banyumas",
      "Kabupaten Batang",
      "Kabupaten Blora",
      "Kabupaten Boyolali",
      "Kabupaten Brebes",
      "Kabupaten Cilacap",
      "Kabupaten Demak",
      "Kabupaten Grobogan",
      "Kabupaten Jepara",
      "Kabupaten Karanganyar",
      "Kabupaten Kebumen",
      "Kabupaten Kendal",
      "Kabupaten Klaten",
      "Kabupaten Kudus",
      "Kabupaten Magelang",
      "Kabupaten Pati",
      "Kabupaten Pekalongan",
      "Kabupaten Pemalang",
      "Kabupaten Purbalingga",
      "Kabupaten Purworejo",
      "Kabupaten Rembang",
      "Kabupaten Semarang",
      "Kabupaten Sragen",
      "Kabupaten Sukoharjo",
      "Kabupaten Tegal",
      "Kabupaten Temanggung",
      "Kabupaten Wonogiri",
      "Kabupaten Wonosobo",
      "Kota Magelang",
      "Kota Pekalongan",
      "Kota Salatiga",
      "Kota Semarang",
      "Kota Surakarta",
      "Kota Tegal",
    ],

    "Jawa Timur": [
      "Kabupaten Bangkalan",
      "Kabupaten Banyuwangi",
      "Kabupaten Blitar",
      "Kabupaten Bojonegoro",
      "Kabupaten Bondowoso",
      "Kabupaten Gresik",
      "Kabupaten Jember",
      "Kabupaten Jombang",
      "Kabupaten Kediri",
      "Kabupaten Lamongan",
      "Kabupaten Lumajang",
      "Kabupaten Madiun",
      "Kabupaten Magetan",
      "Kabupaten Malang",
      "Kabupaten Mojokerto",
      "Kabupaten Nganjuk",
      "Kabupaten Ngawi",
      "Kabupaten Pacitan",
      "Kabupaten Pamekasan",
      "Kabupaten Pasuruan",
      "Kabupaten Ponorogo",
      "Kabupaten Probolinggo",
      "Kabupaten Sampang",
      "Kabupaten Sidoarjo",
      "Kabupaten Situbondo",
      "Kabupaten Sumenep",
      "Kabupaten Trenggalek",
      "Kabupaten Tuban",
      "Kabupaten Tulungagung",
      "Kota Batu",
      "Kota Blitar",
      "Kota Kediri",
      "Kota Madiun",
      "Kota Malang",
      "Kota Mojokerto",
      "Kota Pasuruan",
      "Kota Probolinggo",
      "Kota Surabaya",
    ],

    "Bali": [
      "Kabupaten Badung",
      "Kabupaten Bangli",
      "Kabupaten Buleleng",
      "Kabupaten Gianyar",
      "Kabupaten Jembrana",
      "Kabupaten Karangasem",
      "Kabupaten Klungkung",
      "Kabupaten Tabanan",
      "Kota Denpasar",
    ],

    "Sulawesi Selatan": [
      "Kabupaten Bantaeng",
      "Kabupaten Barru",
      "Kabupaten Bone",
      "Kabupaten Bulukumba",
      "Kabupaten Enrekang",
      "Kabupaten Gowa",
      "Kabupaten Jeneponto",
      "Kabupaten Kepulauan Selayar",
      "Kabupaten Luwu",
      "Kabupaten Luwu Timur",
      "Kabupaten Luwu Utara",
      "Kabupaten Maros",
      "Kabupaten Pangkajene dan Kepulauan (Pangkep)",
      "Kabupaten Pinrang",
      "Kabupaten Sidenreng Rappang (Sidrap)",
      "Kabupaten Sinjai",
      "Kabupaten Soppeng",
      "Kabupaten Takalar",
      "Kabupaten Tana Toraja",
      "Kabupaten Toraja Utara",
      "Kabupaten Wajo",
      "Kota Makassar",
      "Kota Palopo",
      "Kota Parepare",
    ],

    "Sulawesi Utara": [
      "Kabupaten Bolaang Mongondow",
      "Kabupaten Bolaang Mongondow Selatan",
      "Kabupaten Bolaang Mongondow Timur",
      "Kabupaten Bolaang Mongondow Utara",
      "Kabupaten Kepulauan Sangihe",
      "Kabupaten Kepulauan Siau Tagulandang Biaro (Sitaro)",
      "Kabupaten Kepulauan Talaud",
      "Kabupaten Minahasa",
      "Kabupaten Minahasa Selatan",
      "Kabupaten Minahasa Tenggara",
      "Kabupaten Minahasa Utara",
      "Kota Bitung",
      "Kota Kotamobagu",
      "Kota Manado",
      "Kota Tomohon",
    ],

    "Kalimantan Timur": [
      "Kabupaten Berau",
      "Kabupaten Kutai Barat",
      "Kabupaten Kutai Kartanegara",
      "Kabupaten Kutai Timur",
      "Kabupaten Mahakam Ulu",
      "Kabupaten Paser",
      "Kabupaten Penajam Paser Utara",
      "Kota Balikpapan",
      "Kota Bontang",
      "Kota Samarinda",
    ],

    "Papua": [
      "Kabupaten Asmat",
      "Kabupaten Biak Numfor",
      "Kabupaten Boven Digoel",
      "Kabupaten Deiyai",
      "Kabupaten Dogiyai",
      "Kabupaten Intan Jaya",
      "Kabupaten Jayapura",
      "Kabupaten Jayawijaya",
      "Kabupaten Keerom",
      "Kabupaten Lanny Jaya",
      "Kabupaten Mamberamo Raya",
      "Kabupaten Mamberamo Tengah",
      "Kabupaten Mappi",
      "Kabupaten Merauke",
      "Kabupaten Mimika",
      "Kabupaten Nabire",
      "Kabupaten Nduga",
      "Kabupaten Paniai",
      "Kabupaten Pegunungan Bintang",
      "Kabupaten Puncak",
      "Kabupaten Puncak Jaya",
      "Kabupaten Sarmi",
      "Kabupaten Supiori",
      "Kabupaten Tolikara",
      "Kabupaten Waropen",
      "Kabupaten Yahukimo",
      "Kabupaten Yalimo",
      "Kota Jayapura",
    ],

    "Papua Barat": [
      "Kabupaten Fakfak",
      "Kabupaten Kaimana",
      "Kabupaten Manokwari",
      "Kabupaten Manokwari Selatan",
      "Kabupaten Maybrat",
      "Kabupaten Pegunungan Arfak",
      "Kabupaten Raja Ampat",
      "Kabupaten Sorong",
      "Kabupaten Sorong Selatan",
      "Kabupaten Tambrauw",
      "Kabupaten Teluk Bintuni",
      "Kabupaten Teluk Wondama",
      "Kota Sorong",
    ],

    "Nusa Tenggara Barat": [
      "Kabupaten Bima",
      "Kabupaten Dompu",
      "Kabupaten Lombok Barat",
      "Kabupaten Lombok Tengah",
      "Kabupaten Lombok Timur",
      "Kabupaten Lombok Utara",
      "Kabupaten Sumbawa",
      "Kabupaten Sumbawa Barat",
      "Kota Bima",
      "Kota Mataram",
    ],

    "Nusa Tenggara Timur": [
      "Kabupaten Alor",
      "Kabupaten Belu",
      "Kabupaten Ende",
      "Kabupaten Flores Timur",
      "Kabupaten Kupang",
      "Kabupaten Lembata",
      "Kabupaten Malaka",
      "Kabupaten Manggarai",
      "Kabupaten Manggarai Barat",
      "Kabupaten Manggarai Timur",
      "Kabupaten Ngada",
      "Kabupaten Nagekeo",
      "Kabupaten Rote Ndao",
      "Kabupaten Sabu Raijua",
      "Kabupaten Sikka",
      "Kabupaten Sumba Barat",
      "Kabupaten Sumba Barat Daya",
      "Kabupaten Sumba Tengah",
      "Kabupaten Sumba Timur",
      "Kabupaten Timor Tengah Selatan",
      "Kabupaten Timor Tengah Utara",
      "Kota Kupang",
    ],
  };



  static List<String> getYears() {
    final currentYear = DateTime.now().year;
    return List<String>.generate(currentYear - 1950 + 1, (index) => (currentYear - index).toString());
  }
}

class ClusterDanKabupatenPage extends StatefulWidget {
  final String title;
  final List<String> items;

  const ClusterDanKabupatenPage({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<ClusterDanKabupatenPage> createState() => _ClusterDanKabupatenPageState();
}

class _ClusterDanKabupatenPageState extends State<ClusterDanKabupatenPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items.where((item) {
      return item.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item),
            onTap: () {
              Navigator.pop(context, item);
            },
          );
        },
      ),
    );
  }
}
