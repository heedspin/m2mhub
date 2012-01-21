include FormatHelper

def locations(partno) 
  M2m::Item.with_part_number(partno).all.map do |item| 
    item.inventory_locations.map do |loc|
      "#{loc.bin.strip}   --   #{cm loc.quantity_on_hand.to_i}"
    end
  end.flatten
end

loc_with_part = ['H4406A', 'U0982B', 'H4116B', 'SPH-002-GI-PO.5S', 'MI0430MT-1', 'A1430A', 'M4550B', 'H4679B', 'H0058A', 'M4724A', 'P19801', 'H0930H', 'M4294B', 'H4710B', 'H0029A', 'M4730B', 'M4828A', 'JYG-24032036G (R)-KTCL2VE', 'M4746A', 'H1196B', 'M4590A', 'H4683A', 'H4768A', 'H0488C', 'M4529B', 'M4576D', 'M4529C', 'LC#4*', 'H0689C', 'H1256B', 'H1011B', 'A1465A', 'H1231A', 'H4117B', 'H4178C', 'M4193A', 'A1444A', 'U4284B', 'H0055B', 'A1435A', 'H4554A', 'H4183B', 'A1440A', 'H4275B', 'H4196D', 'AB02BA-0360-0AC (PLATED)', 'H0053C', 'H0490B', 'H0353B', 'R-1394B', 'H4138B', 'H0049B', 'H0043B', 'H0531B', 'H4114B', 'H0856A', 'A4721A', 'H4415B', 'SFM070WX1', 'H0488B', 'H4562B', 'A1436A', 'M4154A', 'H4001C', 'M4550A', 'M4509A', 'A4107A', 'H0935A', 'H0691A', 'P13506', 'R-1394A', 'H1042C', 'M4730A', 'M4143B', 'M4537B', 'H4520A', 'H0574B', 'M4725A', 'H4671B', 'M4529A', 'M4527A', 'H1363C', 'H4179B', 'H4415A', 'H4458A', 'M4326B'].map do |partno|
  locations(partno).map do |loc|
    "#{loc}  --  #{partno}"
  end
end

puts loc_with_part.sort.join("\n")
