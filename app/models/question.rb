class Question < ApplicationRecord


  belongs_to :user
  has_many :answers
  has_many :conversations, class_name: 'Conversation', foreign_key: 'question_id'



  scope :recent, -> { order("created_at DESC")}
  scope :area, -> { order("area DESC")}
  scope :district, -> { order("district DESC")}

  # 变成被回答状态
  def answered!
    self.be_answered = true
    self.save
  end
  
  # 变成待回答状态
  def reopened!
    self.be_answered = false
    self.save   
  end


end

# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  content     :text
#  area        :string
#  district    :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_answered :boolean          default(FALSE)
#
