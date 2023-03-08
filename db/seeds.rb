@brands = ["A.O.Smith", "Aquafilter", "Aqualine", "Atoll",
              "BIO+ Systems", "Crystal", "DO.WATER", "DO.F",
              "Ecosoft", "Filter-1", "Filtrons", "Kaplya",
              "Leader", "Leader Comfort", "Purezzo", "Puricom",
              "Raifil", "Raifil GRANDO", "Zepter", "Аквафор",
              "Гейзер", "Насосы+", "Новая Вода", "Эковода"]
@brands.each do |brand|
  PurifierBrand.create title: brand
end

@stages = (4..7).to_a
@stages.each do |stage|
  PurifierStage.create number: stage
end

@tanks = [6, 8, 10, 50, 100, 200, 300, 500, 1000]
@tanks.each do |tank|
  PurifierTank.create capacity: tank
end

@parts = ['PP 5u Filter(10in)', 'Block Carbon Filter(10in)', 'PP 1u Filter(10in)', 'In-Line CL-10 Carbon Post Filter', 
          'In-Line Mineral Filter', 'In-Line Infra-Red Filter', 'Grain Carbon Filter(10in)', 'Deionization Post Filters',
          'PP 20u Filter(10in)', 'PP 10u Filter(10in)',
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
@parts.each do |part|
  PurifierPart.create title: part
end

# @pump = [true, false]

# 100.times do
#   Client.create first_name: FFaker::Name.first_name,
#                 last_name: FFaker::Name.last_name,
#                 phone: FFaker::PhoneNumber.short_phone_number,
#                 address: FFaker::Address.street_address,
#                 purifier_brand: @brands.sample,
#                 purifier_stages: @stages.sample,
#                 purifier_tank: @tanks.sample,
#                 purifier_pump: @pump.sample
# end

# @clients = Client.all
# @days = (1..730).to_a
# @pressure = (1..8).to_a
# @in_tds = (120..430).to_a
# @out_tds = (5..40).to_a

# @clients.each do |client|
#   @notes = [FFaker::Lorem.phrase, ''].sample
#   client.installations.create date: (Date.current - @days.sample),
#                               pressure: @pressure.sample,
#                               incoming_tds: @in_tds.sample,
#                               out_tds: @out_tds.sample,
#                               notes: @notes,
#                               client_id: client.id,
#                               status: true
# end

# @parts = PurifierPart.all