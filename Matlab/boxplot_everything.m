function boxplot_sth = boxplot_everything(matrix,no_columns)
label_txt = '';
label_1 = strcat(label_txt,'0.3');
label_2 = strcat(label_txt,'0.4');
label_3 = strcat(label_txt,'0.5');
label_4 = strcat(label_txt,'0.6');
label_5 = strcat(label_txt,'0.7');
label_6 = strcat(label_txt,'0.8');
label_7 = strcat(label_txt,'0.9');
label_8 = strcat(label_txt,'1');
label_9 = strcat(label_txt,'1.25');
label_10 = strcat(label_txt,'1.5');
label_11 = strcat(label_txt,'2.0');
label_12 = strcat(label_txt,'2.5');
label_13 = strcat(label_txt,'3.0');
label_14 = strcat(label_txt,'3.5');
label_15 = strcat(label_txt,'4.0');
label_16 = strcat(label_txt,'4.5');

switch no_columns
    case 0
       box = boxplot(matrix,'Labels',{label_1}); 
    case 1
       box = boxplot(matrix,'Labels',{label_1,label_2});
    case 2
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3});   
    case 3
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4}); 
    case 4
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5}); 
    case 5
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6});
    case 6
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7});   
    case 7
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8}); 
    case 8
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9}); 
    case 9
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10}); 
    case 10
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11});
    case 11
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11,label_12});
    case 12
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11,label_12,label_13});
    case 13
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11,label_12,label_13,label_14});
    case 14
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11,label_12,label_13,label_14,label_15});
    case 15
       box = boxplot(matrix,'Labels',{label_1,label_2,label_3,label_4,label_5,label_6,label_7,label_8,label_9,label_10,label_11,label_12,label_13,label_14,label_15,label_16});
    otherwise 
       box = boxplot(matrix);
end

boxplot_sth = box;