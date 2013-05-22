#encoding: utf-8
require "prawn"

class Report
  include ActiveAttr::Model

  attribute :start, type: Date
  attribute :finish, type: Date
  attribute :total, type: Integer
  attribute :orders_quantity, type: Integer
  attribute :products_quantity, type: Integer

  attr_accessible :start, :finish, :total, :products_quantity, :orders_quantity
  validates_presence_of :start, :finish, :total, :products_quantity, :orders_quantity

  def helpers
    ActionController::Base.helpers
  end

  def initialize(*args)
    if args.present?
      attrs = args.extract_options!
      new_attrs = attrs.merge({start: parse_date(:start, attrs)})
      new_attrs = new_attrs.merge({finish: parse_date(:finish, attrs)})
      super(new_attrs)
    else
      super()
    end
  end

  def to_html
    self.total = 0
    self.products_quantity = 0
    self.orders_quantity = 0
    Order.where("status = ? AND created_at >= ? AND created_at <= ?", 3, self.start, self.finish).each do |order|
      self.orders_quantity += 1
      order.order_items.each do |item|
        if item && item.product
          self.products_quantity += 1
          self.total += item.product.final_price.to_f*item.quantity
        end
      end
    end
  end

  def to_pdf
    pdf = Prawn::Document.new(:page_size => "A4")
    pdf.font("#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf")
    pdf.font_size 9

    pdf.text "Raport zamówień dla daty od #{helpers.localize(self.start, format: :long)} do #{helpers.localize(self.finish, format: :long)}"
    pdf.move_down 5

    Order.where("created_at >= ? AND created_at <= ?", self.start, self.finish).each do |order|
      generate_text(pdf, order)
    end

    string = "strona <page> / <total>"
    options = {:at => [pdf.bounds.right - 150, 0],
               :width => 150,
               :align => :right,
               :start_count_at => 1,
               :color => "007700"}
    pdf.number_pages string, options

    file = File.join(Rails.root, "tmp", "report.pdf")
    pdf.render_file file

    file
  end

  def valid?
    true
  end

  private

  def generate_text(pdf, order)
    pdf.group do
      self.total = 0
      pdf.text "Nr zamówienia: #{order.number } #{helpers.localize order.created_at, :format => :long }"

      order.order_items.each_with_index do |item, index|
        pdf.text "#{index+1}. #{item.quantity} x #{item.product.name} cena: #{helpers.number_to_currency(item.product.final_price.to_f)} wartość: #{helpers.number_to_currency(item.quantity*item.product.final_price.to_f)}"
        self.total += item.product.final_price.to_f*item.quantity
      end

      string = ""
      if order.payment==0
        string = "Sposób zapłaty: PRZELEW"
      else
        string = "Sposób zapłaty: GOTÓWKA PRZY ODBIORZE"
        self.total += 10.5
      end

      pdf.text "Razem koszt książek: #{helpers.number_to_currency(total)} #{string} Razem do zapłaty: #{helpers.number_to_currency(total)}"

      unless order.notice.blank?
        pdf.text "Uwagi: #{order.notice}"
      end

      pdf.text "Adres wysyłki: #{order.full_name} #{order.street} #{order.building_no} #{order.place_no.blank? ? '' : '/ ' + order.place_no} #{order.code} #{order.city}"
      #pdf.text "#{order.full_name}"
      #pdf.text "#{order.street} #{order.building_no} #{order.place_no.blank? ? '' : '/ ' + order.place_no}"
      #pdf.text "#{order.code} #{order.city}"

      unless order.client.nil?
        pdf.text "Adres Płatnika: #{order.client.full_name} #{order.client.street} #{order.client.building_no} #{order.client.place_no.blank? ? '' : '/ ' + order.client.place_no} #{order.client.code} #{order.client.city}"
        #pdf.text "#{order.client.full_name}"
        #pdf.text "#{order.client.street} #{order.client.building_no} #{order.client.place_no.blank? ? '' : '/ ' + order.client.place_no}"
        #pdf.text "#{order.client.code} #{order.client.city}"
      end
      pdf.move_down 5
      pdf.stroke_horizontal_rule
      pdf.move_down 5
    end
  end

  def parse_date(name, attrs)
    Date.civil(attrs["#{name}(1i)"].to_i, attrs["#{name}(2i)"].to_i, attrs["#{name}(3i)"].to_i)
  end

end