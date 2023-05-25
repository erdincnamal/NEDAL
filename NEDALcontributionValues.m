% Import Data'ya tıkladıktan sonra önce sütunların "Number" formatında seçildiğine emin olun.
% Sonra Number formatının üzerinde yazan isim sıralamasının VarName1 ile başlayıp VarName10 ile bittiğinden emin olun. (Aradakiler de bu sırada olmalı)
% Bu adımlardan istediğiniz dataları seçip, ardından scanRate ve dosya çıktı ismini ayarlayarak çalıştırabilirsiniz.


% Sağ tarafta import ettiğiniz tablonun ismi yazmaktadır onu direkt buraya değiştirmeden yazınız.
nedalData = table2struct(cvexcel2);


% Data sayısını artık girmenize gerek yok.
data_number = size(nedalData,1);

% TARAMA HIZLARI İÇİN SADECE BURADA EŞİTLİĞİN SAĞ TARAFINDAKİ SAYILARI DEĞİŞTİRİN. ONDALIK İÇİN NOKTA KULLANIN.
scanRate1=0.1; 
scanRate2=0.2;
scanRate3=0.5;
scanRate4=0.7;
scanRate5=1;
% -------------------------------------------------------------------------------------------------------------

srScanV01 = scanRate1^(1/2);
srScanV02 = scanRate2^(1/2);
srScanV05 = scanRate3^(1/2);
srScanV1 = scanRate4^(1/2);
srScanV2 = scanRate5^(1/2);


k1_values = zeros(data_number,1);
k2_values = zeros(data_number,1);

data1=srScanV01;
data2=srScanV02;
data3=srScanV05;
data4=srScanV1;
data5=srScanV2;

x_array=[data1 data2 data3 data4 data5];

for i=1:data_number
data6=nedalData(i).VarName2()/data1;
data7=nedalData(i).VarName4()/data2;
data8=nedalData(i).VarName6()/data3;
data9=nedalData(i).VarName8()/data4;
data10=nedalData(i).VarName10()/data5;

y_array=[data6 data7 data8 data9 data10];
lineer = LinearModel.fit(x_array,y_array);
k1_values(i)=lineer.Coefficients.Estimate(2);
k2_values(i)=lineer.Coefficients.Estimate(1);
end

scanV01_k1 = k1_values.*scanRate1;
scanV01_k2 = k2_values*srScanV01;
fittingCurrentV01=scanV01_k1+scanV01_k2;

scanV02_k1 = k1_values.*scanRate2;
scanV02_k2 = k2_values.*srScanV02;
fittingCurrentV02=scanV02_k1+scanV02_k2;

scanV05_k1 = k1_values.*scanRate3;
scanV05_k2 = k2_values.*srScanV05;
fittingCurrentV05=scanV05_k1+scanV05_k2;

scanV1_k1 = k1_values.*scanRate4;
scanV1_k2 = k2_values.*srScanV1;
fittingCurrentV1=scanV1_k1+scanV1_k2;

scanV2_k1 = k1_values.*scanRate5;
scanV2_k2 = k2_values.*srScanV2;
fittingCurrentV2=scanV2_k1+scanV2_k2;

label=["Tarama Hızı","K1","K2","K1-"+scanRate1,"K2-"+scanRate1,"Fitting Current","Tarama Hızı "+scanRate2,"K1-"+scanRate2,"K2-"+scanRate2,"Fitting Current","Tarama Hızı "+scanRate3,"K1-"+scanRate3,"K2"+scanRate3,"Fitting Current","Tarama Hızı "+scanRate4,"K1-"+scanRate4,"K2-"+scanRate4,"Fitting Current","Tarama Hızı "+scanRate5,"K1-"+scanRate5,"K2-"+scanRate5,"Fitting Current"];

outputValues=zeros(data_number,22);

for i=1:data_number
outputValues(i,1)=nedalData(i).VarName1;
outputValues(:,2)=k1_values;
outputValues(:,3)=k2_values;

outputValues(:,4)=scanV01_k1;
outputValues(:,5)=scanV01_k2;
outputValues(:,6)=fittingCurrentV01;

outputValues(i,7)=nedalData(i).VarName3;
outputValues(:,8)=scanV02_k1;
outputValues(:,9)=scanV02_k2;
outputValues(:,10)=fittingCurrentV02;

outputValues(i,11)=nedalData(i).VarName5;
outputValues(:,12)=scanV05_k1;
outputValues(:,13)=scanV05_k2;
outputValues(:,14)=fittingCurrentV05;

outputValues(i,15)=nedalData(i).VarName7;
outputValues(:,16)=scanV1_k1;
outputValues(:,17)=scanV1_k2;
outputValues(:,18)=fittingCurrentV1;

outputValues(i,19)=nedalData(i).VarName9;
outputValues(:,20)=scanV2_k1;
outputValues(:,21)=scanV2_k2;
outputValues(:,22)=fittingCurrentV2;
end

outputData=struct;
outputData.labels=label;
outputData.values=outputValues;

% Output dosyasının ismini tırnak işaretlerini ve .xlsx 'i silmeden değiştirin.
filename = 'FILENAME.xlsx';


writematrix(outputData.labels,filename)
writematrix(outputData.values,filename,'WriteMode','append')

plot(outputValues(:,1),outputValues(:,4))
xlabel('Time'), ylabel('K values')
title('cv')

