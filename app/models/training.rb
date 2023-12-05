class Training < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :zone
  belongs_to :playground, optional: true

  has_many :notifs, dependent: :destroy

  def shooting_efficiency
    return 0 if shot_total.zero?

    (shot_made.to_f / shot_total) * 100
  end

  validates :shot_total, presence: true, numericality: { only_integer: true }
  validates :shot_made, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :zone_id, presence: true
  validate :shot_made_cannot_be_greater_than_shot_total

  private

  def shot_made_cannot_be_greater_than_shot_total
    errors.add(:shot_made, "ne peut pas être supérieur à shot_total") if shot_made > shot_total
  end
end
