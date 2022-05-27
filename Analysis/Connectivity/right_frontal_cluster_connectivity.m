for part_i= 1:length(connectres_NF_select)
    connectres_NF_select(part_i).FP2_con = connectres_NF_select(part_i).psispctrm(34,:,5);
    connectres_NF_select(part_i).AF8_con = connectres_NF_select(part_i).psispctrm(35,:,5);
    connectres_NF_select(part_i).F8_con = connectres_NF_select(part_i).psispctrm(42,:,5);
    connectres_NF_select(part_i).AF4_con = connectres_NF_select(part_i).psispctrm(36,:,5);
    connectres_NF_select(part_i).F4_con = connectres_NF_select(part_i).psispctrm(40,:,5);
    connectres_NF_select(part_i).F6_con = connectres_NF_select(part_i).psispctrm(41,:,5);
    all_electrodes = cat(1,connectres_NF_select(part_i).FP2_con,connectres_NF_select(part_i).AF8_con,connectres_NF_select(part_i).F8_con,connectres_NF_select(part_i).AF4_con,connectres_NF_select(part_i).F4_con,connectres_NF_select(part_i).F6_con);
    mean_all_electrodes = mean(all_electrodes,2);
    connectres_NF_select(part_i).flow_right_frontal_con =mean(mean_all_electrodes,1);
    all_electrodes = [];
    mean_all_electrodes = [];
end

for part_i= 1:length(connectres_NF_select)
    connectres_NF_select(part_i).FP2_con = connectres_NF_select(part_i).psispctrm(34,:,5);
    connectres_NF_select(part_i).AF8_con = connectres_NF_select(part_i).psispctrm(35,:,5);
    connectres_NF_select(part_i).F8_con = connectres_NF_select(part_i).psispctrm(42,:,5);
    connectres_NF_select(part_i).AF4_con = connectres_NF_select(part_i).psispctrm(36,:,5);
    connectres_NF_select(part_i).F4_con = connectres_NF_select(part_i).psispctrm(40,:,5);
    connectres_NF_select(part_i).F6_con = connectres_NF_select(part_i).psispctrm(41,:,5);
    all_electrodes = cat(1,connectres_NF_select(part_i).FP2_con,connectres_NF_select(part_i).AF8_con,connectres_NF_select(part_i).F8_con,connectres_NF_select(part_i).AF4_con,connectres_NF_select(part_i).F4_con,connectres_NF_select(part_i).F6_con);
    mean_all_electrodes = mean(all_electrodes,2);
    connectres_NF_select(part_i).nonflow_right_frontal_con =mean(mean_all_electrodes,1);
    all_electrodes = [];
    mean_all_electrodes = [];
end