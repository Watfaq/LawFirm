class Account::ConversationsController < ApplicationController

    # 必须登录才能问问题
    before_action :authenticate_user!
    # f120
    before_action :get_mailbox
    layout "user"

  def show
    @question = Question.find(params[:question_id])
    @conversation = @mailbox.conversations.find(params[:id])

    @messages = @conversation.messages
    # binding.pry

    @new_answer = Answer.new

  end



  # 追问问题
  def create
    @question = Question.find(params[:question_id])
    # 出题人
    akser = @question.user
    # 问题内容和问题id绑定
    subject = @question.id.to_s
    # 回答内容
    answer_content = answer_params[:content]

    # 对话id
    conversation_id = answer_params[:conversation_id]
    # mailboxer方法
    # 如果之前没有对话，就新建对话。如果有，就回复对话

    if conversation_id.blank?
      conversation = current_user.send_message(akser ,answer_content ,subject).conversation
        # 由于没有conversation的model无法进一步设置,并且由于conversation的名字也找不到
        # 所以无法使用适配器,因此只能选择从conversation里面筛选主题的方式来查表
    else
      # 通过会话id获取会话
      conversation = @mailbox.conversations.find(conversation_id)
      # binding.pry
      current_user.reply_to_conversation(conversation, answer_content)
    end

    # binding.pry
    flash[:notice] = "回复成功"
    redirect_to :back
  end






  private

  def answer_params
    params.require(:answer).permit(:content,:conversation_id)
  end

  
  # f120建一个邮箱
  def get_mailbox
    @mailbox ||= current_user.mailbox
  end




end