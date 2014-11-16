class ContestsController < ScopeController

  before_action :contests
  before_action :find_contest, only: [:show, :edit, :update, :destroy]

  def index
    @contest = @contests.first
  end

  def show
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = @scope.contests.new(contest_attributes)
    @contest.scope_id = @scope.id
    if @contest.save
      flash[:notice] = t('action.created', entity: Contest.model_name.human) 
      redirect_to contest_path(assigned_locale, @contest.slug)
    else
      flash[:alert] = t('action.error')       
      render 'new'
    end
  end
  
  def edit  
  end

  def update
    if @contest.update(contest_attributes)
      flash[:notice] = t('action.updated', entity: Contest.model_name.human) 
      redirect_to contest_path(assigned_locale, @contest.slug)
    else
      flash[:alert] = t('action.error') 
      render 'edit'
    end    
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy if @contest.present?
    flash[:notice] = t('action.destroyed', entity: Contest.model_name.human)
    redirect_to contests_path(assigned_locale)
  end


private

  def contests
    @contests = @scope.contests.where('startdate <= ?', Date.today).order(startdate: :desc).page(params[:page]).per(30)
  end

  def find_contest
    @contest = @scope.contests.order(created_at: :desc).where(slug: params[:id]).first
    redirect_to contests_path(locale: @scope.locale) if @contest.blank?
  end

  def contest_attributes
    params.require(:contest).permit(:title, :body, :banner, :finished, :startdate, :enddate)
  end  
end
