class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @active = params[:active].present? ? params[:active] == 'true' : true
    @people = Person.includes(:user, :debts).where(active: @active).paginate(page: params[:page], per_page: 30)
    params.permit(:page, :active)
  end

  def search
    @people = Person.where(active: true)
                    .where("UPPER(name) LIKE ?", "#{params[:q].upcase}%")
                    .order(:name)
                    .limit(10)

    respond_to do |format|
      format.html { render :search, layout: false }
      format.json { render json: @people.to_json }
    end
  end

  def show
  end

  def new
    @person = Person.new(active: true)
  end

  def edit
  end

  def create
    @person = current_user.people.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: "Criado com sucesso." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: "Atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: "Removido." }
      format.json { head :no_content }
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :phone_number, :national_id, :active)
  end
end
