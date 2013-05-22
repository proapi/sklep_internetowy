# encoding: utf-8

class MainController < ApplicationController

  layout "application"

  def add_to_cart
    @order_items = (session[:order_items] ||= Array.new)

    if params[:product_id]
      product = Product.find(params[:product_id])
      return if product.nil?

      b = false
      for item in @order_items
        if item.product == product
          item.quantity += 1
          item.update_attribute(:quantity, item.quantity)
          b = true
        end
      end

      unless b
        order_item = OrderItem.new
        order_item.product = product
        order_item.quantity = 1
        order_item.notice = ""
        @order_items.push order_item
      end

      session[:order_items] = @order_items
    end

    params.clear

    respond_to do |format|
      #format.html { redirect_to basket_orders_path }
      format.html { redirect_to request.referer, notice: 'Produkt został dodany poprawnie do koszyka' }
    end
  end

  def remove_from_cart
    if request.xhr?
      @order_items = session[:order_items] if session[:order_items]

      if @order_items.nil? || @order_items.empty?
        return
      end

      if params[:product_id]
        product = Product.find(params[:product_id])
        return if product.nil?
        for item in @order_items
          if item.product.eql? product
            @order_items.delete(item)
          end
        end
      end

      session[:order_items] = @order_items

      respond_to do |format|
        format.js
      end
    end
  end

  def inc_order_item
    if request.xhr?
      @order_items = session[:order_items] if session[:order_items]

      if @order_items.nil? || @order_items.empty?
        return
      end

      if params[:product_id]
        product = Product.find(params[:product_id])
        return if product.nil?
        for item in @order_items
          if item.product.eql? product
            item.quantity += 1
          end
        end
      end

      session[:order_items] = @order_items

      respond_to do |format|
        format.js
      end
    end
  end

  def dec_order_item
    if request.xhr?
      @order_items = session[:order_items] if session[:order_items]

      if @order_items.nil? || @order_items.empty?
        return
      end

      if params[:product_id]
        product = Product.find(params[:product_id])
        return if product.nil?
        for item in @order_items
          if item.product.eql? product
            if item.quantity <= 1
              @order_items.delete(item)
            else
              item.quantity -= 1
            end
          end
        end
      end

      session[:order_items] = @order_items

      respond_to do |format|
        format.js
      end
    end
  end

  def refresh_category_list
    if request.xhr?
      @category = Category.find(params[:id])

      respond_to do |format|
        format.js
      end
    end
  end

  def refresh_products_list
    if request.xhr?
      @category = Category.find(params[:id])

      respond_to do |format|
        format.js
      end
    end
  end

end