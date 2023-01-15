clc; clear; close all; warning off all;

% -> training data sel darah merah normal <- %

directory = 'dataset-eritrosit\data-test\normal';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

normcharacter = zeros(totaldata, 5);
normtarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah normal

for datapic = 1 : totaldata
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename(datapic).name)));
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

    fillarea = bwareaopen(inverpic, 200);
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

    % mengambil nilai ekstraksi fitur bentuk

    normcharacter(datapic, 1) = bloodiame;
    normcharacter(datapic, 2) = bloodmin;
    normcharacter(datapic, 3) = metric;
    normcharacter(datapic, 4) = compactness;
    normcharacter(datapic, 5) = bloodecc;

    % target normal

    normtarget{datapic} = 'eritrosit normal';
end

% -> training data sel darah merah ellyptocytes <- %

directory = 'dataset-eritrosit\data-test\ellyptocytes';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

ellcharacter = zeros(totaldata, 5);
elltarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah ellyptocytes

for datapic = 1 : totaldata
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename(datapic).name)));
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
    % -> filling holes (menutup lubang pada objek)

    fillholes = imfill(inverpic, 'holes');
    % figure, imshow(fillholes);
    
    % -> area opening (membersihkan area di sekitar objek dari noise)

    fillarea = bwareaopen(fillholes, 800);
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

    % mengambil nilai ekstraksi fitur bentuk

    ellcharacter(datapic, 1) = bloodiame;
    ellcharacter(datapic, 2) = bloodmin;
    ellcharacter(datapic, 3) = metric;
    ellcharacter(datapic, 4) = compactness;
    ellcharacter(datapic, 5) = bloodecc;

    % target normal

    elltarget{datapic} = 'eritrosit ellyptocytes';
end

% -> training data sel darah merah ovalocytes <- %

directory = 'dataset-eritrosit\data-test\ovalocytes';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

ovacharacter = zeros(totaldata, 5);
ovatarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah ovalocytes

for datapic = 1 : totaldata
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename(datapic).name)));
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
    % -> filling holes (menutup lubang pada objek)

    fillholes = imfill(inverpic, 'holes');
    % figure, imshow(fillholes);
    
    % -> area opening (membersihkan area di sekitar objek dari noise)

    fillarea = bwareaopen(fillholes, 800);
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

    % mengambil nilai ekstraksi fitur bentuk

    ovacharacter(datapic, 1) = bloodiame;
    ovacharacter(datapic, 2) = bloodmin;
    ovacharacter(datapic, 3) = metric;
    ovacharacter(datapic, 4) = compactness;
    ovacharacter(datapic, 5) = bloodecc;

    % target normal

    ovatarget{datapic} = 'eritrosit ovalocytes';
end

% -> training data sel darah merah stomatocytes <- %

directory = 'dataset-eritrosit\data-test\stomatocytes';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

stomcharacter = zeros(totaldata, 5);
stomtarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah stomatocytes

for datapic = 1 : totaldata
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename(datapic).name)));
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

    fillarea = bwareaopen(inverpic, 1800);
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

    % mengambil nilai ekstraksi fitur bentuk

    stomcharacter(datapic, 1) = bloodiame;
    stomcharacter(datapic, 2) = bloodmin;
    stomcharacter(datapic, 3) = metric;
    stomcharacter(datapic, 4) = compactness;
    stomcharacter(datapic, 5) = bloodecc;

    % target stomatocytes

    stomtarget{datapic} = 'eritrosit stomatocytes';
end

% -> training data sel darah merah teardop <- %

directory = 'dataset-eritrosit\data-test\teardop';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

tearcharacter = zeros(totaldata, 5);
teartarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah teardop

for datapic = 1 : totaldata
    % input dan output citra asli
    originalpic = im2double(imread(fullfile(directory, filename(datapic).name)));
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
    % -> filling holes (menutup lubang pada objek)

    fillholes = imfill(inverpic, 'holes');
    % figure, imshow(fillholes);
    
    % -> area opening (membersihkan area di sekitar objek dari noise)

    fillarea = bwareaopen(fillholes, 2400);
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

    % mengambil nilai ekstraksi fitur bentuk

    tearcharacter(datapic, 1) = bloodiame;
    tearcharacter(datapic, 2) = bloodmin;
    tearcharacter(datapic, 3) = metric;
    tearcharacter(datapic, 4) = compactness;
    tearcharacter(datapic, 5) = bloodecc;

    % target normal

    teartarget{datapic} = 'eritrosit teardop';
end

% mengambil nilai karakteristik dan target data training

traincharacter = [normcharacter; ellcharacter; ovacharacter; stomcharacter; tearcharacter];
traintarget = [normtarget; elltarget; ovatarget; stomtarget; teartarget];

% melakukan pelatihan menggunakan algoritma K-NN

load trainmodel

% membaca kelas keluaran hasil pelatihan

trainresult = predict(trainmodel, traincharacter);

% menghitung akurasi pelatihan

traindata = totaldata * 5;
traindata
trueresult = 0;
lossresult = totaldata * 5;
totaldata = size(traincharacter, 1);
for data = 1 : totaldata
    if isequal(trainresult{data}, traintarget{data})
        trueresult = trueresult + 1;
    end
end
lossresult = lossresult - trueresult;
trainaccuracy = trueresult / totaldata * 100;
trueresult, lossresult, trainaccuracy