# frozen_string_literal: true

module Backend
  class AffiliatesController < Backend::BackendController
    before_action :find_scope

    def index
      @affiliates = Affiliate.where(scope_id: @scope.id)
    end

    def new
      @affiliate = Affiliate.new
    end

    def create
      @affiliate = @scope.affiliates.build(affiliate_attributes)
      if @affiliate.save
        flash[:notice] = 'Speichern Erfolgreich'
        redirect_to backend_scope_affiliate_path(@scope, @affiliate)
      else
        flash[:error] = 'Fehler beim Speiechern'
        render 'new'
      end
    end

    def show
      @affiliate = @scope.affiliates.where(id: params[:id]).first
      @unmapped_categories = @affiliate.categories

      @affiliate.mappings.each do |mapping|
        @unmapped_categories.delete(mapping.name)
      end

      @unmapped_categories.each do |unmapped_category|
        @affiliate.mappings.build(name: unmapped_category)
      end
    end

    def edit
      @affiliate = @scope.affiliates.where(id: params[:id]).first
    end

    def update
      @affiliate = @scope.affiliates.where(id: params[:id]).first
      @affiliate.update(affiliate_attributes)
      @unmapped_categories = @affiliate.categories

      @affiliate.mappings.each do |mapping|
        @unmapped_categories.delete(mapping.name)
      end

      @unmapped_categories.each do |unmapped_category|
        @affiliate.mappings.build(name: unmapped_category)
      end

      render 'show'
    end

    protected

    def find_scope
      @scope = Scope.find(params[:scope_id])
    end

    def affiliate_attributes
      params.require(:affiliate).permit(:name,
                                        :logo,
                                        :file,
                                        :importer,
                                        :item_tag,
                                        :category_tag,
                                        :category_split_char,
                                        :ean_tag,
                                        :image_tag,
                                        :name_tag,
                                        :number_tag,
                                        :description_tag,
                                        :brand_tag,
                                        :price_tag,
                                        :currency_code_tag,
                                        :shipping_cost_tag,
                                        :delivery_time_tag,
                                        :last_modified_tag,
                                        :link_tag,
                                        :ready,
                                        :pay_invoice,
                                        :free_shipping,
                                        :premium,
                                        :replace_only_images,
                                        mappings_attributes: %i[id name category_id])
    end
  end
end
