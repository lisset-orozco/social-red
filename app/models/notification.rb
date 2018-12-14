# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_type  :string
#  item_id    :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true
  after_create { NotificationBroadcastJob.perform_later(self) }
  scope :unviewed, -> { where(viewed: false) }
  scope :latest, -> { order("created_at desc").limit(10) }
  # Ex:- scope :active, -> {where(:active => true)}

  def self.for_user(user_id)
    where(user_id: user_id).unviewed.count
    #where(user_id).or(where(viewed: false)).count
  end

  def self.get_notifications(user_id)
    where(user_id: user_id).unviewed
  end
end

# create personalized actions of what happened
