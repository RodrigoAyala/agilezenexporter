# encoding: utf-8

class MainController < ApplicationController

  def index
    
  end

  def generate
    client_agilezen = AgileZen::Client.new(:api_key => params[:apikey])
    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(:name => "Proyectos") do |sheet|
      sheet.add_row ["Nombre", "Descripción", "Fecha de creación", "Owner"]
      client_agilezen.projects.items.each do |project|
        sheet.add_row [project.name,project.description,project.createTime,project.owner.name]
      end
    


    end

    p.validate.each { |e| puts e.message }

    p.serialize(Rails.root.to_s+"/tmp/proyectos.xlsx")

    send_file(Rails.root.to_s+"/tmp/proyectos.xlsx", :filename => "proyectos.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

  end

end
