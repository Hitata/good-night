class Sleep < ApplicationRecord
  belongs_to :user

  validates :date, presence: true

  scope :group_by_and_from_date, lambda { |from_date|
    group('DATE(sleeps.date)')
      .where(Sleep.arel_table[:date].gteq(from_date))
      .select(
        arel_table[:id].maximum.as('id'),
        arel_table[:clockin_at].maximum.as('clockin_at'),
        arel_table[:clockout_at].maximum.as('clockout_at'),
        arel_table[:date]
      )
  }
end
