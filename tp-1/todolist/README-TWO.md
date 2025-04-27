Kathleen Daniella Wijaya | 2106637366 

# TUGAS 6 PBP

Link menuju aplikasi Heroku yang sudah dideploy: https://tugasduapebepe.herokuapp.com/todolist/

# Asynchronous Programming VS Synchronous Programming
Asynchronous programming adalah sebuah teknik multi-thread yang bersifat non-blocking sehingga memungkinkan program untuk memulai suatu tugas dan tetap responsif terhadap tugas lain di saat yang bersamaan. Dengan teknik ini, program akan menyajikan hasil setelah semua tugas selesai dijalankan. Di sisi lain, synchronous programming adalah sebuah teknik dimana program akan dibaca secara baris per baris sesuai dengan urutan. Setelah suatu baris selesai dieksekusi, program akan menyajikan hasil lalu pindah ke baris selanjutnya. 

# Event-Driven Programming
Event-Driven Programming adalah salah satu teknik pemrograman yang menjalankan suatu tugas berdasarkan kejadian atau event tertentu. Teknik ini merupakan paradigma dimana entitas berkomunikasi secara tidak langsung dengan mengirimkan pesan terhadap satu sama lain melalui suatu perantara. Salah satu contoh penerapan teknik pemrograman ini pada tugas 6 PBP adalah saat ingin memunculkan modal form. Pertama-tama, pengguna akan melakukan interaksi berupa click dengan button "Add Task" yang telah dibuat. Lalu, baris "$('#add_task').click()" menandakan bahwa suatu event click telah terjadi pada button "Add Task" dan program akan masuk ke potongan kode tersebut. Terakhir, browser akan mengeluarkan output pada situs web sesuai dengan potongan kode yang telah didefinisikan yaitu, modal form untuk menambahkan task pada to-do list.

# Asynchronous Programming pada AJAX
AJAX, yang merupakan singkatan dari Asynchronous JavaScript And XML, adalah teknik yang memungkinkan situs web untuk diperbarui secara asynchronous. Setelah halaman HTML dimuat, data akan dibaca dari server web. Hal ini berarti browser tidak perlu memuat ulang seluruh halaman HTML ketika hanya sedikit data pada halaman yang berubah.

# Implementasi Checklist
- Membuat sebuah fungsi bernama "show_json" pada file "views.py" untuk mengembalikan data dalam bentuk JSON.
- Menambahkan sebuah path "json/" pada file "urls.py" yang akan mengarah ke fungsi show_json yang telah dibuat.
- Mengambil data task dalam bentuk JSON dengan menggunakan AJAX GET(json/) pada file "todolist.html".
- Membuat sebuah fungsi bernama "add_task" pada file "views.py" untuk menambahkan task baru ke dalam database.
- Menambahkan sebuah path "add/" pada file "urls.py" yang akan mengarah ke fungsi add_task yang telah dibuat. 
- Membuat sebuah button "Add Task" pada file "todolist.html".
- Membuat sebuah modal form bernama "modalAddTaskForm" yang meminta title dan description dari sebuah task.
- Menerapkan event-driven programming dimana setelah terjadi event click pada button "Add Task", situs web akan menampilkan modal form untuk menambahkan task baru pada to-do list.
- Menambahkan sebuah button "Add" pada modal form.
- Membuat sebuah fungsi bernama "addTask" pada file "todolist.html".
- Mendeteksi apakah DOM pada halaman HTML sudah siap digunakan dengan barisan kode "$(document).ready()". Jika sudah siap, maka program akan memanggil function "addTask".
- Membuat sebuah fungsi bernama "validate" untuk mengecek jika input title dan description kosong atau tidak.
- Menerapkan event-driven programming dimana setelah terjadi event click pada button "Add", situs web akan menambahkan task baru pada tabel to-do list dengan menggunakan AJAX POST(add/).
- Melakukan add, commit, dan push perubahan yang telah dilakukan ke Github.
- Melakukan deployment ke Heroku terhadap aplikasi Django yang sudah dibuat.
