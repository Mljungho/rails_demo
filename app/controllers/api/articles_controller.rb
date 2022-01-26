class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_params_presence, only: [:create]
  #  before_action will only kick in during [:create] action

  def index
    articles = Article.all
    render json: { articles: serialized_articles(articles) }, status: 200
  end

  def show
    article = Article.find(params['id'])
    render json: { article: article }
  end

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { article: article }, status: 201
    else
      render json: { message: article.errors.full_message.to_sentence }, status: 422
    end
  end

  private

  def validate_params_presence
    render json: { message: 'Missing params' }, status: 422 if params[:article].nil?
  end

  def article_params
    params[:article].permit(:title, :content)
  end

  def serialized_articles(articles)
    articles.map do |article|
      article.serialized
    end
  end
end
