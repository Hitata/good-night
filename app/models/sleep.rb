class Sleep < ApplicationRecord
  belongs_to :user

  validates :date, presence: true

  scope :from_date, lambda { |from_date|
    where(Sleep.arel_table[:date].gteq(from_date))
      .select(
        arel_table[:id],
        arel_table[:clockin_at],
        arel_table[:clockout_at],
        arel_table[:date],
        'age(sleeps.clockout_at, sleeps.clockin_at) as sleep_time'
      )
  }

  scope :from_date_order_by_sleep_time, lambda { |from_date|
    from_date(from_date)
      .order('sleep_time desc NULLS LAST')
  }
end
