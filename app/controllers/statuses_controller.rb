class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
  end

  def upload_csv_file
    file = params[:csv_file]
    Status.import_csv file
    redirect_to statuses_url, notice: 'CSV file uploaded.'
  end

  def query
    object_type = params[:object_type]
    object_id = params[:object_id]
    @timestamp = Time.now

    if params[:ts]
      @timestamp = Time.new(params[:ts][:year].to_i,
                            params[:ts][:month].to_i,
                            params[:ts][:day].to_i,
                            params[:ts][:hour].to_i,
                            params[:ts][:minute].to_i,
                            params[:ts][:second].to_i)
    end

    statuses = Status.arel_table

    # result = Status.where(object_id: object_id,).
    result = Status.where(object_id: object_id).
                    where(statuses[:object_type].matches(object_type)).
                    where("timestamp <= ?", @timestamp).
                    order("timestamp DESC")

    # logger.debug ">>>>>>>>>>> #{result.size}, ts = #{timestamp}"

    @state_result = {}

    result.each do |s|
      @state_result = @state_result.merge(s.state)
    end

    respond_to do |format|
      format.html { render :query }
      format.json  { render json: @state_result }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:object_id, :object_type, :timestamp, :state)
    end
end
