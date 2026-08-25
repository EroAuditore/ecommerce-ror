class Products::FilterQuery
  SORT_OPTIONS = {
    "price_asc" => { price: :asc },
    "price_desc" => { price: :desc },
    "name_asc" => { name: :asc },
    "newest" => { created_at: :desc }
  }.freeze

  def initialize(filters: {})
    @filters = filters
  end

  def call
    scope = Product.published.includes(:category)
    scope = filter_by_category(scope)
    scope = filter_by_min_price(scope)
    scope = filter_by_max_price(scope)
    scope = filter_by_stock(scope)
    sort(scope)
  end

  private

  def filter_by_category(scope)
    return scope if @filters[:category_slug].blank?

    scope.joins(:category).where(categories: { slug: @filters[:category_slug] })
  end

  def filter_by_min_price(scope)
    return scope if @filters[:min_price].blank?

    scope.where("products.price >= ?", @filters[:min_price])
  end

  def filter_by_max_price(scope)
    return scope if @filters[:max_price].blank?

    scope.where("products.price <= ?", @filters[:max_price])
  end

  def filter_by_stock(scope)
    return scope unless ActiveModel::Type::Boolean.new.cast(@filters[:in_stock_only])

    scope.where("products.stock > 0")
  end

  def sort(scope)
    scope.order(SORT_OPTIONS.fetch(@filters[:sort], SORT_OPTIONS["newest"]))
  end
end
