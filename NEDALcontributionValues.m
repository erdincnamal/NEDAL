% Import Data'ya tıkladıktan sonra önce sütunların "Number" formatında seçildiğine emin olun.
% Sonra Number formatının üzerinde yazan isim sıralamasının VarName1 ile başlayıp VarName10 ile bittiğinden emin olun. (Aradakiler de bu sırada olmalı)
% Bu adımlardan istediğiniz dataları seçip, ardından scanRate ve dosya çıktı ismini ayarlayarak çalıştırabilirsiniz.


% Sağ tarafta import ettiğiniz tablonun ismi yazmaktadır onu direkt buraya değiştirmeden yazınız.
nedalData = table2struct(Book1);
columnNames = fieldnames(nedalData);

% Data sayısını artık girmenize gerek yok.
data_size = size(nedalData,1);

% TARAMA HIZLARI İÇİN SADECE BURADA EŞİTLİĞİN SAĞ TARAFINDAKİ SAYILARI DEĞİŞTİRİN. ONDALIK İÇİN NOKTA KULLANIN.
scanRate1=0.1; 
scanRate2=0.2;
scanRate3=0.5;
scanRate4=1;
scanRate5=2;
% -------------------------------------------------------------------------------------------------------------

srScanV1 = scanRate1^(1/2);
srScanV2 = scanRate2^(1/2);
srScanV3 = scanRate3^(1/2);
srScanV4 = scanRate4^(1/2);
srScanV5 = scanRate5^(1/2);


k1_values = zeros(data_size,1);
k2_values = zeros(data_size,1);

data1=srScanV1;
data2=srScanV2;
data3=srScanV3;
data4=srScanV4;
data5=srScanV5;

x_array=[data1 data2 data3 data4 data5];

for i=1:data_size
data6=nedalData(i).(columnNames{2})()/data1;
data7=nedalData(i).(columnNames{4})()/data2;
data8=nedalData(i).(columnNames{6})()/data3;
data9=nedalData(i).(columnNames{8})()/data4;
data10=nedalData(i).(columnNames{10})/data5;

y_array=[data6 data7 data8 data9 data10];
lineer = LinearModel.fit(x_array,y_array);
k1_values(i)=lineer.Coefficients.Estimate(2);
k2_values(i)=lineer.Coefficients.Estimate(1);
end

scanV1_k1 = k1_values.*scanRate1;
scanV1_k2 = k2_values*srScanV1;
fittingCurrentV1=scanV1_k1+scanV1_k2;

scanV2_k1 = k1_values.*scanRate2;
scanV2_k2 = k2_values.*srScanV2;
fittingCurrentV2=scanV2_k1+scanV2_k2;

scanV3_k1 = k1_values.*scanRate3;
scanV3_k2 = k2_values.*srScanV3;
fittingCurrentV3=scanV3_k1+scanV3_k2;

scanV4_k1 = k1_values.*scanRate4;
scanV4_k2 = k2_values.*srScanV4;
fittingCurrentV4=scanV4_k1+scanV4_k2;

scanV5_k1 = k1_values.*scanRate5;
scanV5_k2 = k2_values.*srScanV5;
fittingCurrentV5=scanV5_k1+scanV5_k2;

label=["Tarama Hızı","K1","K2","K1-"+scanRate1,"K2-"+scanRate1,"Fitting Current","Tarama Hızı "+scanRate2,"K1-"+scanRate2,"K2-"+scanRate2,"Fitting Current","Tarama Hızı "+scanRate3,"K1-"+scanRate3,"K2"+scanRate3,"Fitting Current","Tarama Hızı "+scanRate4,"K1-"+scanRate4,"K2-"+scanRate4,"Fitting Current","Tarama Hızı "+scanRate5,"K1-"+scanRate5,"K2-"+scanRate5,"Fitting Current"];

outputValues=zeros(data_size,22);

for i=1:data_size
outputValues(i,1)=nedalData(i).(columnNames{1});
outputValues(:,2)=k1_values;
outputValues(:,3)=k2_values;

outputValues(:,4)=scanV1_k1;
outputValues(:,5)=scanV1_k2;
outputValues(:,6)=fittingCurrentV1;

outputValues(i,7)=nedalData(i).(columnNames{3});
outputValues(:,8)=scanV2_k1;
outputValues(:,9)=scanV2_k2;
outputValues(:,10)=fittingCurrentV2;

outputValues(i,11)=nedalData(i).(columnNames{5});
outputValues(:,12)=scanV3_k1;
outputValues(:,13)=scanV3_k2;
outputValues(:,14)=fittingCurrentV3;

outputValues(i,15)=nedalData(i).(columnNames{7});
outputValues(:,16)=scanV4_k1;
outputValues(:,17)=scanV4_k2;
outputValues(:,18)=fittingCurrentV4;

outputValues(i,19)=nedalData(i).(columnNames{9});
outputValues(:,20)=scanV5_k1;
outputValues(:,21)=scanV5_k2;
outputValues(:,22)=fittingCurrentV5;
end

outputData=struct;
outputData.labels=label;
outputData.values=outputValues;

% Output dosyasının ismini tırnak işaretlerini ve .xlsx 'i silmeden değiştirin.
filename = 'Output1.xlsx';


writematrix(outputData.labels,filename)
writematrix(outputData.values,filename,'WriteMode','append')

plot(outputValues(:,1),outputValues(:,4))
xlabel('Time'), ylabel('K values')
title('CV Grafiği')

