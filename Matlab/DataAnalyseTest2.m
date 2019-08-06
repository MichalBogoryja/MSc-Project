clear;

results_a = [];
results_b = [];

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
recharging_total = [];
waiting_total = [];

row_frequency_counter = [];
row_met_counter = [];
row_decision_counter = [];
row_arriving_counter = [];
row_charging_counter = [];

Label_X = ('Algorithm ');

Set = "set";
%Sets for 'RAB range'
% SetName = {Set + '2', Set + '3', Set + '1', Set + '4', Set + '5', Set + '6', Set + '7', Set + '8', Set + '9', Set + '10', Set + '11', Set + '12', Set + '13', Set + '14', Set + '15'};

%Sets for 'number of robots'
%SetName = {Set + '18',Set + '16',Set + '19',Set + '20',Set + '21',Set + '17',Set + '22',Set + '23',Set + '24',Set + '25'};

%Sets for 'differnt algorithms'
% SetName = {Set + '31', Set + '32', Set + '30', Set + '29', Set + '28', Set + '26', Set + '36', Set + '35', Set + '37',Set + '40',Set + '41'};

SetName = {Set + '45',Set + '46'};
%Sets for 'scalable tests'
% SetName = {Set + '31', Set + '32'};

% SetName = {Set + '45'};
    
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
    DataName ={FolderName + '/data1.txt',FolderName + '/data2.txt',FolderName + '/data3.txt',FolderName + '/data4.txt',FolderName + '/data5.txt',FolderName + '/data6.txt',FolderName + '/data7.txt',FolderName + '/data8.txt',FolderName + '/data9.txt',FolderName + '/data10.txt',FolderName + '/data11.txt',FolderName + '/data12.txt',FolderName + '/data13.txt',FolderName + '/data14.txt',FolderName + '/data15.txt',FolderName + '/data16.txt',FolderName + '/data17.txt',FolderName + '/data18.txt',FolderName + '/data19.txt',FolderName + '/data20.txt',FolderName + '/data21.txt',FolderName + '/data22.txt',FolderName + '/data23.txt',FolderName + '/data24.txt',FolderName + '/data25.txt',FolderName + '/data26.txt',FolderName + '/data27.txt',FolderName + '/data28.txt',FolderName + '/data29.txt',FolderName + '/data30.txt'};
    BatteryFolderName = FolderName + "/battery_data";
    BatteryDataName ={BatteryFolderName + '1.txt',BatteryFolderName + '2.txt',BatteryFolderName + '3.txt',BatteryFolderName + '4.txt',BatteryFolderName + '5.txt',BatteryFolderName + '6.txt',BatteryFolderName + '7.txt',BatteryFolderName + '8.txt',BatteryFolderName + '9.txt',BatteryFolderName + '10.txt',BatteryFolderName + '11.txt',BatteryFolderName + '12.txt',BatteryFolderName + '13.txt',BatteryFolderName + '14.txt',BatteryFolderName + '15.txt',BatteryFolderName + '16.txt',BatteryFolderName + '17.txt',BatteryFolderName + '18.txt',BatteryFolderName + '19.txt',BatteryFolderName + '20.txt',BatteryFolderName + '21.txt',BatteryFolderName + '22.txt',BatteryFolderName + '23.txt',BatteryFolderName + '24.txt',BatteryFolderName + '25.txt',BatteryFolderName + '26.txt',BatteryFolderName + '27.txt',BatteryFolderName + '28.txt',BatteryFolderName + '29.txt',BatteryFolderName + '30.txt'};
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
        A(i,(columnsA+1)) = mean(A(i,5:(columnsA-1)));   
    end
    
    %calculate number of completely discharged robots 
    for i = 1:rowsA
       A(i,(columnsA+2)) = ((((A(1,2)+A(1,3)+A(1,4))-(A(i,2)+A(i,3)+A(i,4)))/(A(1,2)+A(1,3)+A(1,4)))*100); 
    end

    avg_battery = [avg_battery; plot_avg(DataSets,A,columnsA,Argos_iterations,FolderName)];

    plot_each_battery(DataSets,A,columnsA,Argos_iterations,FolderName)

    food_sub_total = [food_sub_total; plot_food_items(DataSets,A,columnsA,Argos_iterations,FolderName)];
    
    plot_operating_robots(1,A,columnsA,Argos_iterations,FolderName)
    
    plot_charging_robots(1,A,columnsA,Argos_iterations,FolderName)
    
    plot_waiting_robots(1,A,columnsA,Argos_iterations,FolderName)
    
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
    
    %plot boxplot of recharging robots
    [recharging_total_rows,recharging_total_columns] = size(recharging_total);
    recharging_total(:,(exploring_total_columns+1)) = ((A(:,3)/A(1,2))*100);
    subFileName = [FolderName + '/Recharging robots (boxplot)'];
    fileName = [subFileName + '.png'];
    boxplot_everything(recharging_total,recharging_total_columns);
    xlabel(Label_X)
    ylabel('Recharging robots [%]')
    saveas(gcf,fileName)
    
    %plot boxplot of waiting robots
    [waiting_total_rows,waiting_total_columns] = size(waiting_total);
    waiting_total(:,(waiting_total_columns+1)) = ((A(:,4)/A(1,2))*100);
    subFileName = [FolderName + '/Waiting robots (boxplot)'];
    fileName = [subFileName + '.png'];
    boxplot_everything(waiting_total,waiting_total_columns);
    xlabel(Label_X)
    ylabel('Waiting robots [%]')
    saveas(gcf,fileName)
    
    %plot boxplot how often robots recharge
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
    
    switch nn
        case 1
            results_a = food_sub_total;
%             results_a = charging_sub_counts;
        case 2
            results_b = food_sub_total;
%             results_b = charging_sub_counts;
    end    
end

logic_test = 1;

if logic_test == 1
    % % Wilcoxon rank-sum test (aka Mann-Whitney U test)
    [p, h] = ranksum(results_a, results_b, 'alpha', 0.05)
    
    % 
    % % Kolmogorov-Smirnoff test (aka KS test)
    [h, p] = kstest2(results_a, results_b, 0.05)
    % 
    % % Varga-Delaney A test (aka Effect Magnitude test)
    [p, h, st] = ranksum(results_a, results_b, 'alpha', 0.05);

    N = size(results_a, 1);
    M = size(results_b, 1);

    A_result = (st.ranksum/N - (N+1)/2)/M
end
