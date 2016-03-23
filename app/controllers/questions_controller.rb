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
    current_user
    @question = Question.new
    if @current_user.nil?
      flash[:notice] = "Please sign in before posting a question"
      redirect_to root_url
    end
  end

  def create
    current_user

    @question = Question.new(question_params)
    @question.user_id = @current_user.id

    if @question.save
      redirect_to @question
      flash[:notice] = "New question created"
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
    flash[:notice] = "Question updated!"
    redirect_to @question
  else
    render :edit
  end
end

def destroy
  @question = Question.find(params[:id])
  @question.destroy
  flash[:notice] = "Question deleted!"
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
