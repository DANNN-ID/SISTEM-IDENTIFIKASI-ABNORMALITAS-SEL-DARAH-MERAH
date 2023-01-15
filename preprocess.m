clc; clear; close all; warning off all;

% -> training data sel darah merah normal <- %

directory = 'dataset-eritrosit\data-train\stomatocytes';
filename = dir(fullfile(directory, '*.jpg'));
totaldata = numel(filename);

% inisialisasi ciri bentuk dan target bentuk

normalcharacter = zeros(totaldata, 4);
normaltarget = cell(totaldata, 1);

% proses pengolahan citra sel darah merah normal

for datapic = 1 : 1
    % input dan output citra asli
    originalpic = im2double(imread('dataset-eritrosit\data-train\stomatocytes\stomatocytes9-8-flpho.jpg'));
    % figure, imshow(originalpic);
    
    % konversi warna citra asli menjadi citra green
    greenpic = originalpic(:,:,2);
    redpic = originalpic(:,:,1);
    bluepic = originalpic(:,:,3);
    graypic = im2gray(originalpic);
    
    % figure, imshow(greenpic);
    % figure, imhist(greenpic);
    % figure, imshow(redpic);
    % figure, imshow(bluepic);
    % figure, imshow(graypic);

    % peningkatan kontras citra green
    minvalue = min(min(greenpic)); maxvalue = max(max(greenpic));
    upcontrast = imadjust(greenpic, [minvalue/1 maxvalue/1], [0/1 1/1]);
    % figure, imshow(upcontrast);
    % figure, imhist(upcontrast);

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

    fillarea = bwareaopen(fillholes, 2200);
    % figure, imshow(fillarea);

    awd = bwareaopen(inverpic, 2200);
    % figure, imshow(awd);

    erospic = imerode(fillarea, strel('disk', 5));
    % figure, imshow(erospic);

    % memulai ekstraksi fitur bentuk
    
    phi = 3.14;
    stats = regionprops(fillarea, 'all');
    MajorAxisLength = cat(1, stats.MajorAxisLength)
    MinorAxisLength = cat(1, stats.MinorAxisLength)
    Eccentricity = cat(1, stats.Eccentricity)
    bloodarea = stats.Area;
    bloodper = stats.Perimeter;
    Metric = 4 * bloodarea * phi / bloodper^2
    Compactness = bloodper^2 / bloodarea
end