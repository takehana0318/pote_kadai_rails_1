class Schedule < ApplicationRecord
  # タイトルのバリデーション
  validates :title, presence: true, length: { maximum: 20 }

  # 開始日、終了日のバリデーション
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  # スケジュールメモのバリデーション
  validates :schedule_memo, length: { maximum: 500 }

  private

  # 終了日が開始日以降であることを確認するカスタムバリデーション
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "は開始日以降の日付である必要があります")
    end
  end
end
