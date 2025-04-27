Kathleen Daniella Wijaya | 2106637366 

# TUGAS 3 PBP

Link menuju aplikasi Heroku yang sudah dideploy: https://tugasduapebepe.herokuapp.com/

HTML mywatchlist: https://tugasduapebepe.herokuapp.com/mywatchlist/html/

XML mywatchlist: https://tugasduapebepe.herokuapp.com/mywatchlist/xml/

JSON mywatchlist: https://tugasduapebepe.herokuapp.com/mywatchlist/json/

Screenshot Postman: https://ristek.link/ScreenshotPostman 

# Perbedaan JSON, XML, dan HTML
XML (eXtensible Markup Language) adalah data delivery yang self-descriptive sehingga manusia dapat dengan mudah memahami informasi yang disajikan dari XML tersebut. XML digunakan pada banyak aplikasi web dan mobile untuk menyimpan dan mengirimkan data. Dokumen XML membentuk struktur seperti tree yang dimulai dari root yang merupakan parent dari elemen lainnya, lalu branch, dan berakhir pada leaves. Informasi yang disajikan pada dokumen tersebut dibungkus dengan tag (semua elemen XML perlu memiliki closing tag). Tag XML ini bersifat case-sensitive.

JSON (JavaScript Object Notation) adalah data delivery yang self-describing sehingga data sangat mudah untuk dipahami. Sama seperti XML, JSON digunakan pada banyak aplikasi web dan mobile untuk menyimpan dan mengirimkan data. Walaupun sintaks JSON merupakan turunan dari Object JavaScript, program untuk membaca dan membuat file JSON banyak terdapat dibahasa pemrograman lain karena bentuk JSON yang merupakan text. Data pada JSON disimpan dalam bentuk key dan value. Value dapat berupa tipe data primitif (string, number, boolean) ataupun berupa objek. Data delivery dalam bentuk JSON adalah alternatif yang lebih banyak dipilih dibanding XML karena runtime-nya yang lebih singkat.

HTML (Hyper Text Markup Language) adalah bahasa standar yang digunakan untuk menampilkan dokumen di browser. Bahasa markup adalah sebuah sistem untuk menandai atau tag dokumen yang memiliki struktur logis dan memberikan instruksi mengenai tata letak dokumen pada halaman web, khususnya tampilan pada device. HTML menggambarkan struktur halaman web secara semantik. Elemen HTML yang memiliki sintaks seperti "<judul>Judul Halaman</judul>", adalah building block dari halaman HTML.

# Data Delivery
Jika browser request halaman HTML, maka data yang dikirimkan adalah HTML. Jika browser request gambar, maka data yang dikirimkan adalah JPG. Jika browser request data, maka data yang dikirimkan adalah XML atau JSON. Oleh karena itu, data delivery dibutuhkan dalam pengimplementasian sebuah platform karena ada kalanya dimana data yang bermacam-macam bentuknya perlu dikirimkan dari satu stack ke stack lainnya. 

# Implementasi Checklist
- Masuk ke dalam repositori proyek Django Tugas 2 pada VSCode.
- Membuat folder untuk aplikasi baru bernama "mywatchlist".
- Membuat file "models.py" pada folder "mywatchlist" yang berisi models untuk aplikasi "mywatchlist". Models ini memiliki atribut watched, title, rating, release date, dan review.
- Membuat folder "fixtures" yang berisi file "initial_mywatchlist_data.json" pada folder "mywatchlist". File ini berisi data untuk objek dari models yang sudah dibuat di atas.
- Masuk ke dalam repositori proyek Django Tugas 2 pada terminal.
- Membuat dan menyalakan virtual environment.
- Menginstal dependencies yang diperlukan untuk menjalankan proyek Django.
- Mempersiapkan migrasi skema model ke dalam database Django lokal dengan perintah "makemigrations" dan menerapkan skema model tersebut dengan perintah "migrate".
- Memasukkan data ke dalam database Django lokal dengan perintah "loaddata initial_mywatchlist_data.json".
- Membuat file "views.py" pada folder "mywatchlist" yang berisi fungsi-fungsi untuk menyajikan data dalam bentuk HTML, JSON, atau XML. Pada file ini, models yang sudah dibuat diimport agar dapat melakukan pengambilan data dari database.
- Membuat file "urls.py" pada folder "mywatchlist" untuk mengimplementasikan URL routing untuk HTML, XML, dan JSON.
- Membuat folder "templates" yang berisi file "mywatchlist.html" untuk mengatur data dan tata letak dokumen yang akan ditampilkan pada browser. Pada file ini, dilakukan iterasi terhadap variabel list_barang yang sudah didefinisikan pada file "views.py" dan yang sudah ikut di-render ke dalam HTML untuk menampilkan daftar film ke dalam tabel.
- Mengimplementasikan URL routing untuk "mywatchlist" pada file "urls.py" yang ada pada folder "tugasduapebepe" (nama aplikasi heroku).
- Menambahkan "mywatchlist" pada file "settings.py" yang ada pada folder "tugasduapebepe", khususnya bagian "INSTALLED_APPS".
- Melakukan add, commit, dan push perubahan yang telah dilakukan ke Github.
- Melakukan deployment ke Heroku terhadap aplikasi Django yang sudah dibuat.
