class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @notes = @note.recipient.received_notes
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Observação criada' }
        format.json { render :show, status: :created, location: @note }
        format.js
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @plano = @note.recipient.plano
    @notes = @note.recipient.received_notes
    @note.destroy
    respond_to do |format|
      if current_user.type == 'Student'
        format.html { redirect_to student_area_my_plan_path, notice: 'Observação deletada' }
      else
        format.html { redirect_to notes_url, notice: 'Observação deletada' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.fetch(:note, {}).permit(:sender_id, :recipient_id, :texto, :topico)
    end
end
