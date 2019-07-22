clear;
batteries_avg = [];
food_total = [];
dead_total = [];
charging_total_counts = [];
charging_total_often_counts = [];
charging_total_frequency = [];
charging_total_met = [];
charging_total_decision = [];
charging_total_arriving = [];
exploring_total = [];

row_frequency_counter = [];
row_met_counter = [];
row_decision_counter = [];
row_arriving_counter = [];
row_charging_counter = [];

Label_X = ('RAB range ');

Set = "set";
%Sets for 'RAB range'
% SetName = {Set + '2', Set + '3', Set + '1', Set + '4', Set + '5', Set + '6', Set + '7', Set + '8', Set + '9', Set + '10', Set + '11', Set + '12', Set + '13', Set + '14', Set + '15'};

%Sets for 'number of robots'
%SetName = {Set + '18',Set + '16',Set + '19',Set + '20',Set + '21',Set + '17',Set + '22',Set + '23',Set + '24',Set + '25'};

%Sets for 'differnt algorithms'
SetName = {Set + '1', Set + '16', Set + '26', Set + '27'};
    
SetNumber = size(SetName,2);
% SetNumber = 1;

for nn = 1:SetNumber
    
    A = [];         %matrix for data%.txt files
    B = [];         %matrix for battery_data%.txt files

    battery_file_rows = [0];
    charging_sub_counts = [];
    g = [];

    avg_battery = [];
    food_sub_total = [];
    dead_sub_total = [];
    FolderName = SetName{nn};
    DataSets = 10;
    DataName ={FolderName + '/data1.txt',FolderName + '/data2.txt',FolderName + '/data3.txt',FolderName + '/data4.txt',FolderName + '/data5.txt',FolderName + '/data6.txt',FolderName + '/data7.txt',FolderName + '/data8.txt',FolderName + '/data9.txt',FolderName + '/data10.txt'};
    BatteryFolderName = FolderName + "/battery_data";
    BatteryDataName ={BatteryFolderName + '1.txt',BatteryFolderName + '2.txt',BatteryFolderName + '3.txt',BatteryFolderName + '4.txt',BatteryFolderName + '5.txt',BatteryFolderName + '6.txt',BatteryFolderName + '7.txt',BatteryFolderName + '8.txt',BatteryFolderName + '9.txt',BatteryFolderName + '10.txt'};
    delimiterIn = ' ';
    headerlinesIn = 0;
    %A = importdata(filename,delimiterIn,headerlinesIn);
    for i = 1:DataSets
       A = [A; importdata(DataName{i},delimiterIn,headerlinesIn)]; 
       B = [B; importdata(BatteryDataName{i},delimiterIn,headerlinesIn)];
       [rowsB,columnsB] = size(B);
       battery_file_rows = [battery_file_rows;rowsB];
       old_r = rowsB;
    end

    A(:,1) = (A(:,1)/10)/60;    %time in minutes
    B(:,3) = (B(:,3)/10);       %time in seconds 
    [rowsA,columnsA] = size(A);
    Argos_iterations = rowsA/DataSets;
    %caluculate mean battery level of all robots in particular moment 
    for i = 1:rowsA
        A(i,(columnsA+1)) = mean(A(i,4:(columnsA-1)));   
    end
    
    %calculate number of completely discharged robots 
    for i = 1:rowsA
       A(i,(columnsA+2)) = ((((A(1,2)+A(1,3))-(A(i,2)+A(i,3)))/(A(1,2)+A(1,3)))*100); 
    end

    avg_battery = [avg_battery; plot_avg(DataSets,A,columnsA,Argos_iterations,FolderName)];

    plot_each_battery(DataSets,A,columnsA,Argos_iterations,FolderName)

    food_sub_total = [food_sub_total; plot_food_items(DataSets,A,columnsA,Argos_iterations,FolderName)];
    
    plot_operating_robots(1,A,columnsA,Argos_iterations,FolderName)
    
    dead_sub_total = [dead_sub_total; plot_dead_robots(DataSets,A,columnsA,Argos_iterations,FolderName)];

    %plot boxplot of avarage battery level of whole swarm during whole experiment 
    boxplot_avg_battery()
    [batteries_avg_rows,batteries_avg_columns] = size(batteries_avg);
    for i = 1:DataSets
        batteries_avg(i,(batteries_avg_columns+1)) = avg_battery(i,1);   
    end
    subFileName = [FolderName + '/Avarage battery level'];
    fileName = [subFileName + '.png'];
    boxplot_everything(batteries_avg,batteries_avg_columns);
    xlabel(Label_X)
    ylabel('Battery level')
    saveas(gcf,fileName)

    %plot boxplot total number of found food items
    [food_total_rows,food_total_columns] = size(food_total);
    for i = 1:DataSets
        food_total(i,(food_total_columns+1)) = food_sub_total(i,1);   
    end
    subFileName = [FolderName + '/Found food itmes'];
    fileName = [subFileName + '.png'];
    boxplot_everything(food_total,food_total_columns);
    xlabel(Label_X)
    ylabel('Found items')
    saveas(gcf,fileName)
    
    %plot boxplot of exploring robots
    [exploring_total_rows,exploring_total_columns] = size(exploring_total);
    exploring_total(:,(exploring_total_columns+1)) = ((A(:,2)/A(1,2))*100);
    subFileName = [FolderName + '/Exploring robots (boxplot)'];
    fileName = [subFileName + '.png'];
    boxplot_everything(exploring_total,exploring_total_columns);
    xlabel(Label_X)
    ylabel('Exploring robots [%]')
    saveas(gcf,fileName)
    
    %plot boxplot how often robots recharge 
%     for i = 1:DataSets
%         edges = unique(B((battery_file_rows(i,1))+1:battery_file_rows(i+1,1),4));
%         charging_sub_counts = [charging_sub_counts; histc(B((battery_file_rows(i,1))+1:battery_file_rows(i+1,1),4), edges)];
%     end
%     [charging_total_counts_rows,charging_total_counts_columns] = size(charging_total_counts);
%     charging_total_counts(:,(charging_total_counts_columns+1)) = charging_sub_counts(:,1);
%     subFileName = [FolderName + '/Charging frequency'];
%     fileName = [subFileName + '.png'];
%     boxplot_everything(charging_total_counts,charging_total_counts_columns);
%     xlabel(Label_X)
%     ylabel('Charging frequency')
%     saveas(gcf,fileName)
    
    %plot boxplot how often robots recharge NEW
    for i = 1:DataSets
        edges = unique(B((battery_file_rows(i,1))+1:battery_file_rows(i+1,1),4));
        charging_sub_counts = [charging_sub_counts; histc(B((battery_file_rows(i,1))+1:battery_file_rows(i+1,1),4), edges)];
    end
    [charging_sub_counts_rows,charging_sub_counts_columns] = size(charging_sub_counts);
    charging_total_often_counts = [charging_total_often_counts; charging_sub_counts(:,1)];
    row_charging_counter = [row_charging_counter; charging_sub_counts_rows];
    subFileName = [FolderName + '/Charging frequency'];
    fileName = [subFileName + '.png'];
    boxplot_everything_B(charging_total_often_counts,nn,row_charging_counter);
    xlabel(Label_X)
    ylabel('Charging frequency')
    saveas(gcf,fileName)

    %plot boxplot how long robots need to reach charging area 
    [charging_total_frequency_rows,charging_total_frequency_columns] = size(charging_total_frequency);
    charging_total_frequency = [charging_total_frequency; B(:,3)];
    row_frequency_counter = [row_frequency_counter; rowsB];
    subFileName = [FolderName + '/Time needed to reach charging area'];
    fileName = [subFileName + '.png'];
    boxplot_everything_B(charging_total_frequency, nn, row_frequency_counter);
    xlabel(Label_X)
    ylabel('Time needed to get to charging area [s]')
    saveas(gcf,fileName)

    %plot boxplot how many other robots each robot meets between charging and next decision
    [charging_total_met_rows,charging_total_met_columns] = size(charging_total_met);
    charging_total_met = [charging_total_met; (B(:,10) + B(:,11))];
    row_met_counter = [row_met_counter; rowsB];
    subFileName = [FolderName + '/Number of robots met between chargings'];
    fileName = [subFileName + '.png'];
    boxplot_everything_B(charging_total_met, nn, row_met_counter);
    xlabel(Label_X)
    ylabel('Robots met since last charging')
    saveas(gcf,fileName)
    
    %plot boxplot of charge when deciding to recharge
    charging_total_decision = [charging_total_decision; B(:,5)];
    row_decision_counter = [row_decision_counter; rowsB];
    subFileName = [FolderName + '/Battery level when deciding to recharge'];
    fileName = [subFileName + '.png'];
    boxplot_everything_B(charging_total_decision, nn, row_decision_counter);
    xlabel(Label_X)
    ylabel('Battery level')
    saveas(gcf,fileName)
    
    %plot boxplot of charge when arriving to recharge
    charging_total_arriving = [charging_total_arriving; B(:,6)];
    row_arriving_counter = [row_arriving_counter; rowsB];
    subFileName = [FolderName + '/Battery level when arriving to the charging area'];
    fileName = [subFileName + '.png'];
    boxplot_everything_B(charging_total_arriving, nn, row_arriving_counter);
    xlabel(Label_X)
    ylabel('Battery level')
    saveas(gcf,fileName)
    
    %plot boxplot of how many robots discharge completely during the experiment 
    [dead_total_rows,dead_total_columns] = size(dead_total);
    for i = 1:DataSets
        dead_total(i,(dead_total_columns+1)) = dead_sub_total(i,1);   
    end
    subFileName = [FolderName + '/Dead robots'];
    fileName = [subFileName + '.png'];
    boxplot_everything(dead_total,dead_total_columns);
    xlabel(Label_X)
    ylabel('Percentage of completely discharged robots [%]')
    saveas(gcf,fileName)
    
end
