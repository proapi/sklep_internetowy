#encoding: utf-8
require 'open-uri'

class PackMachine < ActiveRecord::Base

  attr_accessible :name, :province, :postcode, :town, :street, :building_number, :latitude, :longitude, :status, :location_description, :operating_hours, :payment_point_description, :partner_id, :payment_type, :payment_available, :machine_type

  def to_s
    "#{name} #{province} #{postcode} #{town} #{street} #{building_number}"
  end

  def self.nearest(code)
    result = Array.new

    doc = Nokogiri::XML(open("http://api.paczkomaty.pl/?do=findnearestmachines&postcode=#{code}&paymentavailable="))
    doc.xpath('//paczkomaty/machine').each do |node|
      result.append "#{node.xpath('name').text}"
    end

    pack_machines = PackMachine.where(:name => result)
    pack_machines.sort_by! { |pm| result.index(pm.name) }
  end

  def fetch_all_from_api
    doc = Nokogiri::XML(open('http://api.paczkomaty.pl/?do=listmachines_xml&paymentavailable='))
    doc.xpath('//paczkomaty/machine').each do |node|
      pack_machine = PackMachine.new
      pack_machine.name = node.xpath('name').text
      pack_machine.province = node.xpath('province').text
      pack_machine.postcode = node.xpath('postcode').text
      pack_machine.town = node.xpath('town').text
      pack_machine.street = node.xpath('street').text
      pack_machine.building_number = node.xpath('buildingnumber').text
      pack_machine.latitude = node.xpath('latitude').text
      pack_machine.longitude = node.xpath('longitude').text
      pack_machine.status = node.xpath('status').text
      pack_machine.location_description = node.xpath('name').text
      pack_machine.operating_hours = node.xpath('operatinghours').text
      pack_machine.payment_available = node.xpath('paymentavailable').text
      pack_machine.payment_point_description = node.xpath('paymentpointdescr').text
      pack_machine.payment_type = node.xpath('paymenttype').text
      pack_machine.machine_type = node.xpath('type').text
      pack_machine.partner_id = node.xpath('partnerid').text
      if pack_machine.valid?
        pack_machine.save
      end
    end
    PackMachine.fetch_all_from_api
  end

  handle_asynchronously :fetch_all_from_api, :run_at => Proc.new { 23.hours.from_now }
end
