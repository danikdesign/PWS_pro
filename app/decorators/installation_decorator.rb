class InstallationDecorator < ApplicationDecorator
	delegate_all
  
  def formatted_date
    l date
  end
end