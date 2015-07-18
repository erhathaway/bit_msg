# require "#{Rails.root}/lib/bitcoin/parse"
# require "#{Rails.root}/lib/bitcoin/parse"


def index
  if params[:search].present?
  @species = Species.search(params[:search]).page params[:page]
else
  @species = Species.all.order(:common_name).page params[:page]
end
end
