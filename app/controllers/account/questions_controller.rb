class Account::QuestionsController < ApplicationController
  # 必须登录才能问问题
  before_action :authenticate_user!
  # f120
  before_action :get_mailbox

  layout "user"

  # 只显示当前用户的问题
  def index
    @questions = Question.where(user_id: current_user).recent
  end



  # 新建问题
  def new
    @question = Question.new
  end

  # 问题
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @new_answer = Answer.new

    # f120
    # qid = @question.id.to_s
    # 查是否有关于此问题的回复
    @conversations = @question.conversations
    # binding.pry


  end

  # 编辑
  def edit
    @question = Question.find(params[:id])
  end

  # 建立
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to account_questions_path, notice: "问题已发布!"
    else
      render :new
    end
  end

  # 更新
  def update
    @question = Question.find(params[:id])
    @question.user = current_user
    if @question.update(question_params)
      redirect_to account_question_path(@question), notice: "问题已修改!"
    else
      render :back, notice: "修改失败!"
    end
  end

  # 删除
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to :back
  end

  # 评价系统
  def rating
    # 获取message的参数
    conversation_id = params[:conversation_id]
    message_id = params[:message_id]
    score = params[:rating]

    # 找到指定的message
    conversation = Conversation.find(conversation_id.to_i)
    message = conversation.messages.find(message_id.to_i)
    # 为message评级
    message.rating = score
    message.save

    return 'success'
  end





  private

  # 问题参数
  def question_params
    params.require(:question).permit(:content,:area,:district)
  end

  # 答案参数
  def answer_params
    params.require(:answer).permit(:content)
  end

end
