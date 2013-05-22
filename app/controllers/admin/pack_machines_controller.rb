class Admin::PackMachinesController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :pack_machine, :name, :full => true

  # GET /admin/pack_machines
  # GET /admin/pack_machines.json
  def index
    if params[:pack_machine]
      @search = PackMachine.search :name_like => params[:pack_machine][:name]
      params.clear
    else
      @search = PackMachine.search(params[:search])
    end

    @pack_machines = @search.paginate(:per_page => "20", :page => params[:page])

    redirect_to [:admin, @pack_machines.first] and return if (@pack_machines.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pack_machines }
    end
  end

  # GET /admin/pack_machines/1
  # GET /admin/pack_machines/1.json
  def show
    @pack_machine = PackMachine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pack_machine }
    end
  end

  # GET /admin/pack_machines/new
  # GET /admin/pack_machines/new.json
  def new
    @pack_machine = PackMachine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pack_machine }
    end
  end

  # GET /admin/pack_machines/1/edit
  def edit
    @pack_machine = PackMachine.find(params[:id])
  end

  # POST /admin/pack_machines
  # POST /admin/pack_machines.json
  def create
    @pack_machine = PackMachine.new(params[:admin_pack_machine])

    respond_to do |format|
      if @pack_machine.save
        format.html { redirect_to [:admin, @pack_machine], notice: 'Pack machine was successfully created.' }
        format.json { render json: @pack_machine, status: :created, location: @pack_machine }
      else
        format.html { render action: "new" }
        format.json { render json: @pack_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/pack_machines/1
  # PUT /admin/pack_machines/1.json
  def update
    @pack_machine = PackMachine.find(params[:id])

    respond_to do |format|
      if @pack_machine.update_attributes(params[:admin_pack_machine])
        format.html { redirect_to [:admin, @pack_machine], notice: 'Pack machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pack_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pack_machines/1
  # DELETE /admin/pack_machines/1.json
  def destroy
    @pack_machine = PackMachine.find(params[:id])
    @pack_machine.destroy

    respond_to do |format|
      format.html { redirect_to admin_pack_machines_url }
      format.json { head :no_content }
    end
  end
end
