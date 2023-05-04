# frozen_string_literal: true
# SECTION 1
# Adding purifier brands, number of stages, tanks capacity and parts titles in DataBase.

brands = ["A.O.Smith", "Aquafilter", "Aqualine", "Atoll",
              "BIO+ Systems", "Crystal", "DO.WATER", "DO.F",
              "Ecosoft", "Filter-1", "Filtrons", "Kaplya",
              "Leader", "Leader Comfort", "OEM", "Purezzo", "Puricom",
              "Raifil", "Raifil GRANDO", "Zepter", "Аквафор",
              "Гейзер", "Насосы+", "Новая Вода", "Эковода"]

stages = (4..7).to_a

tanks = [6, 8, 10, 12, 15, 20, 50, 100, 200, 300, 500, 1000]

parts = ['PP 5u Filter', 'Block Carbon Filter', 'PP 1u Filter', 'In-Line CL-10 Carbon Post Filter',
          'In-Line Mineral Filter', 'In-Line Infra-Red Filter', 'Grain Carbon Filter', 'Deionization Post Filters',
          'PP 20u Filter', 'PP 10u Filter',
          'SLIM PP 20u Filter(20in)','SLIM PP 10u Filter(20in)','SLIM PP 5u Filter(20in)', 'SLIM Block Carbon Filter(20in)', 'SLIM PP 1u Filter(20in)', 'SLIM Grain Carbon Filter(20in)',
          'Big Blue PP 20u Filter(10in)', 'Big Blue PP 10u Filter(10in)', 'Big Blue PP 5u Filter(10in)',
          'Big Blue PP 1u Filter(10in)', 'Big Blue Block Carbon Filter(10in)', 'Big Blue Grain Carbon Filter(10in)',
          'Big Blue PP 20u Filter(20in)', 'Big Blue PP 10u Filter(20in)', 'Big Blue PP 5u Filter(20in)',
          'Big Blue PP 1u Filter(20in)', 'Big Blue Block Carbon Filter(20in)', 'Big Blue Grain Carbon Filter(20in)',
          '50G RO Membrane', '75G RO Membrane', '80G RO Membrane', '100G RO Membrane',
          '200G RO Membrane', '400GPD RO Membrane', '500GPD RO Membrane', '600GPD RO Membrane',
          'Auto Shut-off Four Way Valve', 'Brass Ball Valve 1/4"', 'Big Single Clamp 2.5in', 'Small Single Clamp 2in',
          'Double Clamp (For Membrane / In-line Filter)', 'Double Clamp / For Inline Filter', 'Flow Restrictor',
          'High Pressure Switches', 'Low Pressure Switches', 'RO Diaphragm Booster Pump', 'RO PUMP DC transformer',
          'RO PUMP HEAD & TRIANGLE DIAPHRAGM', 'Solenoid Valve']

########################################

# SECTION 2
# Execution of this code is necessary for correct creation of customer models, installation and service. NEED TO BE UNCOMMENT FIRST CODE SECTION!

brands.each do |brand|
  PurifierBrand.create title: brand
end

stages.each do |stage|
  PurifierStage.create number: stage
end

parts.each do |part|
  PurifierPart.create title: part
end

tanks.each do |tank|
  PurifierTank.create capacity: tank
end

# ########################################

# # SECTION 3
# # This is code for creating fake clients. NEED TO BE UNCOMMENT FIRST CODE SECTION!

# pump = [true, false]

# 10000.times do
#   Client.create first_name: FFaker::Name.first_name,
#                 last_name: FFaker::Name.last_name,
#                 phone: FFaker::PhoneNumber.short_phone_number,
#                 address: FFaker::Address.street_address,
#                 purifier_brand: @brands.sample,
#                 purifier_stages: @stages.sample,
#                 purifier_tank: @tanks.sample,
#                 purifier_pump: @pump.sample
# end

# ########################################

# # SECTION 4
# # This is code for creating fake installations.

# clients = Client.all
# days = (1..730).to_a
# pressure = (1..8).to_a
# in_tds = (120..430).to_a
# out_tds = (5..40).to_a

# clients.each do |client|
#   notes = [FFaker::Lorem.phrase, ''].sample
#   client.installations.create date: (Date.current - @days.sample),
#                               pressure: @pressure.sample,
#                               in_tds: @in_tds.sample,
#                               out_tds: @out_tds.sample,
#                               notes: @notes,
#                               client_id: client.id,
#                               status: true
# end

# ########################################

# SECTION 5
# FIRST SERVICE. This is code for creating fake first services.

# clients = Client.all
# parts = PurifierPart.all
# service_term = (180..200).to_a
# pressure = (1..8).to_a
# in_tds = (120..430).to_a
# out_tds_before = (5..40).to_a
# out_tds_after = (5..30).to_a

# clients.each do |client|

#   date = client.installations.last.date + service_term.sample

#   notes = [FFaker::Lorem.phrase, ''].sample

#   if client.purifier_stages < 5
#     replace = []
#     parts[0..1].each { |p| replace.push(p.id) }
#   else
#     replace = []
#     parts[0..2].each { |p| replace.push(p.id) }
#   end

#   if date < Date.current
#     status = true
#   else
#     status = false
#   end

#   client.services.create(date: date,
#     pressure: pressure.sample,
#     in_tds: in_tds.sample,
#     out_tds_before: out_tds_before.sample,
#     out_tds_after: out_tds_after.sample,
#     status: status,
#     client_id: client.id,
#     notes: notes,
#     purifier_part_ids: replace)
# end

########################################

# SECTION 6
# SECOND SERVICE. This is code for creating fake second services.

# clients = Client.all
# parts = PurifierPart.all
# service_term = (180..200).to_a
# pressure = (1..8).to_a
# in_tds = (120..430).to_a
# out_tds_before = (5..60).to_a
# out_tds_after = (5..40).to_a

# clients.each do |client|

#   if client.services.last.status == true

#     date = client.services.last.date + service_term.sample

#     notes = [FFaker::Lorem.phrase, ''].sample

#     if client.purifier_stages < 5
#       replace = []
#       parts[0..2].each { |p| replace.push(p.id) }
#     else
#       replace = []
#       parts[0..3].each { |p| replace.push(p.id) }
#     end

#     if date < Date.current
#       status = true
#     else
#       status = false
#     end

#     client.services.create(date: date,
#       pressure: pressure.sample,
#       in_tds: in_tds.sample,
#       out_tds_before: out_tds_before.sample,
#       out_tds_after: out_tds_after.sample,
#       status: status,
#       client_id: client.id,
#       notes: notes,
#       purifier_part_ids: replace)
#   end
# end

########################################