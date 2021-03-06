class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authorize
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
  end

  def comment
    @comment = Comment.new
    @comment.user = current_user.email
    @comment.comment = comment_params[:comment]
    @comment.event = Event.find(1) #alterar para pegar a pagina corrent
    if @comment.save
      redirect_to :back
    end
  end

  # GET /events/new
  def new
    if current_user.is_admin == 0
      redirect_to '/'
    else
      @event = Event.new
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    if current_user.is_admin == 0
      redirect_to '/' 
    else
      @event = Event.new
      t = Date.strptime(event_params[:start_time], "%d/%m/%Y").strftime("%FT%T")
      @event.title = event_params[:title]
      @event.description = event_params[:description]
      @event.start_time = t.to_time
      @event.end_time = (t.to_time + 4 * 60 * 60)
      # t = Time.now
      # @event.start_time = t
      # @event.end_time = (t + 4 * 60 * 60)
      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render action: 'show', status: :created, location: @event }
        else
          format.html { render action: 'new' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
      @comments = @event.comments
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_time, :end_time)
    end
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
