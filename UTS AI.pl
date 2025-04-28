% File: hama_tanaman.pl
% Sistem Pakar Diagnosa Hama Tanaman

% Fakta gejala (akan diisi berdasarkan input pengguna)

% Aturan inferensi
hama('Virus Tanaman') :-
    gejala(daun_menguning),
    gejala(tanaman_layu).

hama('Hama Kutu Daun') :-
    gejala(daun_menguning),
    \+ gejala(tanaman_layu).

hama('Jamur Daun') :-
    gejala(terdapat_bercak_hitam).

hama('Hama Ulat') :-
    gejala(daun_berlubang).

hama('Infeksi Bakteri') :-
    gejala(tanaman_layu),
    \+ gejala(daun_menguning).

hama('Tanaman Sehat') :-
    \+ gejala(daun_menguning),
    \+ gejala(terdapat_bercak_hitam),
    \+ gejala(daun_berlubang),
    \+ gejala(tanaman_layu).

% Program utama untuk bertanya kepada pengguna
tanya(Gejala) :-
    write('Apakah '), write(Gejala), write('? (ya/tidak): '),
    read(Jawaban),
    ( (Jawaban == ya) -> assert(gejala(Gejala));
      (Jawaban == tidak) -> assert(gejala(tidak(Gejala)))
    ).

% Menjalankan program diagnosa
diagnosa :-
    retractall(gejala(_)),
    retractall(gejala(tidak(_))),
    tanya(daun_menguning),
    tanya(terdapat_bercak_hitam),
    tanya(daun_berlubang),
    tanya(tanaman_layu),
    ( hama(Hama) ->
        nl, write('>> Diagnosa: '), write(Hama), nl;
        nl, write('>> Maaf, jenis hama tidak dapat dikenali.'), nl
    ).
