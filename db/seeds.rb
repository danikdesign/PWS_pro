@brands = ["A.O.Smith", "Aquafilter", "Aqualine", "Atoll",
              "BIO+ Systems", "Crystal", "DO.WATER", "DO.F",
              "Ecosoft", "Filter-1", "Filtrons", "Kaplya",
              "Leader", "Leader Comfort", "Purezzo", "Puricom",
              "Raifil", "Raifil GRANDO", "Zepter", "Аквафор",
              "Гейзер", "Насосы+", "Новая Вода", "Эковода"]
# @brands.each do |brand|
#   PurifierBrand.create name: brand
# end

@stages = (3..7).to_a
# @stages.each do |stage|
#   PurifierStage.create number: stage
# end

@tanks = [6, 8, 10] #, 50, 100, 200, 300, 500, 1000]
# @tanks.each do |tank|
#   PurifierTank.create capacity: tank
# end

@parts = ['10" PP Filter (5u)', '10" PP Filter (1u)', '20" PP Filter (5u)', '10" Big Blue PP Filter(5U)',
          '10" CTO Block Carbon Filter', '20" CTO Block Carbon Filter', '10" Big Blue CTO Block Carbon Filter',
          '10" UDF Grain Carbon Filter', '20" UDF Grain Carbon Filter', '10" Big Blue UDF Grain Carbon Filter',
          'In-Line CL-10 Post Carbon Filter', 'In-Line Mineral Filter', 'Deionization (DI) Post Filters',
          'In-Line 4 In 1 Infra-Red Filter', '50G RO Membrane', '75G RO Membrane', '80G RO Membrane',
          '100G RO Membrane', '200G RO Membrane', '400GPD RO Membrane', '500GPD RO Membrane', '600GPD RO Membrane',
          'Auto Shut-off Four Way Valve', 'Brass Ball Valve 1/4"', 'Big Single Clamp 2.5"', 'Small Single Clamp 2"',
          'Double Clamp (For Membrane / In-line Filter)', 'Double Clamp / For Inline Filter', 'Flow Restrictor',
          'High Pressure Switches', 'Low Pressure Switches', 'RO Diaphragm Booster Pump', 'RO PUMP TRANSFORMER',
          'RO PUMP HEAD & TRIANGLE DIAPHRAGM', 'Solenoid Valve']
@parts.each do |part|
  PurifierPart.create name: part
end

@pump = [true, false]

100.times do
  Client.create first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                phone: FFaker::PhoneNumber.short_phone_number,
                address: FFaker::Address.street_address,
                purifier_brand: @brands.sample,
                purifier_stages: @stages.sample,
                purifier_tank: @tanks.sample,
                purifier_pump: @pump.sample
end

@clients = Client.all
@days = (1..182).to_a
@pressure = (1..8).to_a
@in_tds = (120..430).to_a
@out_tds = (5..40).to_a
@notes = [FFaker::Lorem.phrase, '']

@clients.each do |client|
  client.installations.create date: (Date.current - @days.sample),
                              pressure: @pressure.sample,
                              incoming_tds: @in_tds.sample,
                              out_tds: @out_tds.sample,
                              notes: @notes.sample,
                              client_id: client.id,
                              status: true
end

@clients.each do |client|
  if (client.installations.last.date + 182) < Date.current
    @status = true
  else
    @status = false
  end
  client.services.create date: (client.installations.last.date + 182),
                         replaced: 'PP Filter (5u), PP Filter (1u), CTO Block Carbon Filter',
                         pressure: @pressure.sample,
                         incoming_tds: @in_tds.sample,
                         out_tds_before: @out_tds.sample,
                         out_tds_after: @out_tds.sample,
                         notes: @notes.sample,
                         client_id: client.id,
                         status: @status
end
