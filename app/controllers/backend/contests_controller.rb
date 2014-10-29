class Backend::ContestsController < Backend::BackendController
  before_action :find_scope

  def index
    @contests = @scope.contests.page(params[:page]).per(5)
  end

  def new
    @contest = @scope.contests.new
  end

  def create
    @contest = @scope.contests.new(contest_attributes)
    @contest.scope_id = @scope.id
    if @contest.save!
      redirect_to backend_scope_contest_path(@scope, @contest)
    else
      render 'new'
    end
  end

  def show
    @contest = Contest.find(params[:id])
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def update
    @contest = Contest.find(params[:id])
    if @contest.update(contest_attributes)
      redirect_to backend_scope_contest_path(@scope, @contest)
    else
      render 'edit'
    end    
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy if @contest.present?
    redirect_to backend_scope_contests_path(@scope)
  end    

private

  def find_scope
    @scope = Scope.find(params[:scope_id])
  end

  def contest_attributes
    params.require(:contest).permit(:title, :body, :banner, :finished)
  end

end
