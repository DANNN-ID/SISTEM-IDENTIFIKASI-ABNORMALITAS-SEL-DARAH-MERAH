clc; clear; close all; warning off all;

% memanggil fungsi (browse file)
[filename, directory] = uigetfile('*.jpg;');

% kondisi ketika file terdekteksi (sesuai)
if ~isequal(filename, 0)
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename)));
    % figure, imshow(originalpic);
    
    % konversi warna citra asli menjadi citra green
    greenpic = originalpic(:,:,2);
    % figure, imshow(greenpic);
    % figure, imhist(greenpic);

    % peningkatan kontras citra green
    minvalue = min(min(greenpic)); maxvalue = max(max(greenpic));
    upcontrast = imadjust(greenpic, [minvalue/1 maxvalue/1], [0/1 1/1]);
    % figure, imshow(upcontrast);

    % membersihkan noise pada citra hasil contrast
    noisepic = imnoise(upcontrast, 'salt & pepper', 0.02);
    clearpic = medfilt2(noisepic, [5 5]);
    % figure, imshow(clearpic);

    % segmentasi menggunakan metode otsu thresholding
    otsuthresh = graythresh(clearpic);
    otsupic = im2bw(clearpic, otsuthresh);
    % figure, imshow(otsupic);

    % invers citra (membalik warna citra hasil thresholding)
    inverpic = imcomplement(otsupic);
    % figure, imshow(inverpic);

    % melakukan operasi morfologi (penyempurnaan hasil segmentasi)
    % -> area opening (membersihkan area di sekitar objek dari noise)

    fillarea = bwareaopen(inverpic, 2400);
    % figure, imshow(fillarea);

    % memulai ekstraksi fitur bentuk
    
    phi = 3.14;
    stats = regionprops(fillarea, 'all');
    bloodiame = cat(1, stats.MajorAxisLength);
    bloodmin = cat(1, stats.MinorAxisLength);
    bloodecc = cat(1, stats.Eccentricity);
    bloodarea = stats.Area;
    bloodper = stats.Perimeter;
    metric = 4 * bloodarea * phi / bloodper^2;
    compactness = bloodper^2 / bloodarea;

    % menyusun variabel karakteristik data testing
    
    testcharacter = [bloodiame, bloodmin, metric, compactness, bloodecc];

    % memanggil datamodel K-NN hasil training
    
    load trainmodel

    % membaca kelas keluaran data hasil testing
    
    testresult = predict(trainmodel, testcharacter);

    % menampilkan citra asli dan hasil kesesuiaan dengan data pengujian
    
    figure, imshow(originalpic), title({['Nama file : ', filename], ['Hasil pengujian : ', testresult{1}]});
    
else
    return;
end