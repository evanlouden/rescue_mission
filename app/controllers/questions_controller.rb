require 'pry'
class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answer.question = @question
    @answers = @question.answers.order(created_at: :asc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else

      render :new
    end
  end

def edit
  @question = Question.find(params[:id])
end

def update
  @question = Question.find(params[:id])
  if @question.update(question_params)
    redirect_to @question
  else
    render :edit
  end
end

def destroy
  @question = Question.find(params[:id])
  @question.destroy
  redirect_to root_url
end

private
  def question_params
    params.require(:question).permit(
    :title,
    :body,
    :user_id
    )
  end
end
