# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer          not null
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  include Notificable
  include AASM
  belongs_to :user
  belongs_to :friend, class_name: "User" # nombre de la clase con la que se mapea la relación

  validates :user_id, uniqueness: {scope: :friend_id, :message => "duplicate friendship"}

  def user_ids
    
  end

  def self.friends?(user, friend)
    return true if user == friend
    where(user: user, friend: friend)
    .or(where(user: friend, friend: user))
    .any? # .count > 0
  end

  def self.pending_for_user(user)
    # where(user: user, status: 'pending') se simplifica con la maquina de estados
    pending.where(friend: user)
  end

  def self.accepted_for_user(user)
    active.where(friend: user)
  end

  # máquina de estados
  aasm column: "status" do 
    state :pending, initial: true
    state :active
    state :denied

    event :accepted do
      transitions from: [:pending], to: [:active]
    end

    event :rejected do
      transitions from: [:pending, :active], to: [:denied]
    end
  end
end

# SELECT "friendships".* FROM "friendships" WHERE "friendships"."status" = "pending" AND "friendships"."friend_id" = 1
