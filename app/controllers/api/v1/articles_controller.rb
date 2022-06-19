# frozen_string_literal: true

module API
  module V1
    class ArticlesController < ApplicationController
      def index
        @articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS',
                       message: 'Articles fetched successfully!',
                       data: @articles }, status: :ok
      end

      def show
        @article = Article.find(params[:id])
        render json: { status: 'SUCCESS',
                       message: 'Article fetched succesfully!',
                       data: @article }, status: :ok
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: { status: 'SUCCESS',
                         message: 'Article created succesfully!',
                         data: @article }, status: :ok
        else
          render json: { status: 'ERROR',
                         message: 'Something went wrong trying to create a new article!',
                         data: @article.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @article = Article.find(params[:id])
        @article.destroy
        render json: { status: 'SUCCESS',
                       message: 'Article deleted succesfully!',
                       data: @article }, status: :ok
      end

      def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
          render json: { status: 'SUCCESS',
                         message: 'Article updated succesfully!',
                         data: @article }, status: :ok
        else
          render json: { status: 'ERROR',
                         message: 'Something went wrong trying to update the article!',
                         data: @article.errors }, status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end
