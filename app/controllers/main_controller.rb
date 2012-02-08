class MainController < ApplicationController

  def index
    
  end

  def generate
    client_agilezen = AgileZen::Client.new(:api_key => params[:apikey])
    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(:name => "Basic Worksheet") do |sheet|
    sheet.add_row ["First Column", "Second", "Third"]
    sheet.add_row [1, 2, 3]
    end

    p.validate.each { |e| puts e.message }

    p.serialize(Rails.root.to_s+"/tmp/proyectos.xlsx")

    send_file(Rails.root.to_s+"/tmp/proyectos.xlsx", :filename => "proyectos.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

  end

end
