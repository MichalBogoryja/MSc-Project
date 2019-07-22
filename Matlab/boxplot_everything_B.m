function boxplot_sth = boxplot_everything_B(matrix,no_sets,rows)
label_txt = '';
g = [];
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

for i = 1:no_sets
    switch i
        case 1
            g1 = repmat({label_1},rows(1,1),1);
            g = [g; g1];
        case 2
            g1 = repmat({label_2},rows(2,1),1);
            g = [g; g1];
        case 3
            g1 = repmat({label_3},rows(3,1),1);
            g = [g; g1];
        case 4
            g1 = repmat({label_4},rows(4,1),1);
            g = [g; g1];
        case 5
            g1 = repmat({label_5},rows(5,1),1);
            g = [g; g1];
        case 6
            g1 = repmat({label_6},rows(6,1),1);
            g = [g; g1];
        case 7
            g1 = repmat({label_7},rows(7,1),1);
            g = [g; g1];
        case 8
            g1 = repmat({label_8},rows(8,1),1);
            g = [g; g1];
        case 9
            g1 = repmat({label_9},rows(9,1),1);
            g = [g; g1];
        case 10
            g1 = repmat({label_10},rows(10,1),1);
            g = [g; g1];
        case 11
            g1 = repmat({label_11},rows(11,1),1);
            g = [g; g1];
        case 12
            g1 = repmat({label_12},rows(12,1),1);
            g = [g; g1];
        case 13
            g1 = repmat({label_13},rows(13,1),1);
            g = [g; g1];
        case 14
            g1 = repmat({label_14},rows(14,1),1);
            g = [g; g1];
        case 15
            g1 = repmat({label_15},rows(15,1),1);
            g = [g; g1];
        case 16
            g1 = repmat({label_16},rows(16,1),1);
            g = [g; g1];
    end 
end
box = boxplot(matrix,g);
boxplot_sth = box;