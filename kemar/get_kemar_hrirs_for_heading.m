function [left_hrir,right_hrir] = get_kemar_hrirs_for_heading(kemar_hrirs, heading_deg)
   if mod(heading_deg, 5) ~= 0
       error("KEMAR HRIR azimuth must be given in increments of 5 degrees");
   end
   heading_index = 37 + (heading_deg / 5);
   left_hrir = squeeze(kemar_hrirs(heading_index, 1, :))';
   right_hrir = squeeze(kemar_hrirs(heading_index, 2, :))';
end

