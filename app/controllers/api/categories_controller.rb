class Api::CategoriesController < Api::ApiController

  def index
    @options = create_options
    @categories = @scope.categories.where(main_taxon: true) 
  end


  def show
    @category = @scope.categories.where(id: params[:id]).first
  end


protected

  def create_options
    result = []

    scope_option = {}
    scope_option[:name]='scope'
    scope_option[:type]='hidden'
    scope_option[:value]=@scope.id
    scope_option[:label]= ''
    result << scope_option
    if @scope.has_contest?
      contest_option = {}
      contest_option[:name]='contest'
      contest_option[:type]='check'
      contest_option[:value]=false
      contest_option[:label]= I18n.t('activerecord.attributes.contest.form_label')
      result << contest_option
    end

    return result

  end

end
