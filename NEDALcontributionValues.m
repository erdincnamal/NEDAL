nedalData = table2struct(newexcel);

srScanV01 = 0.1^(1/2);
srScanV02 = 0.2^(1/2);
srScanV05 = 0.5^(1/2);
srScanV1 = 1;
srScanV2 = 2^(1/2);

data_number = 20;


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

scanV01_k1 = k1_values.*0.1;
scanV01_k2 = k2_values.*srScanV01;

scanV02_k1 = k1_values.*0.2;
scanV02_k2 = k2_values.*srScanV02;

scanV05_k1 = k1_values.*0.5;
scanV05_k2 = k2_values.*srScanV05;

scanV1_k1 = k1_values.*1;
scanV1_k2 = k2_values.*srScanV1;

scanV2_k1 = k1_values.*2;
scanV2_k2 = k2_values.*srScanV2;
