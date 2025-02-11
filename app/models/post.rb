class Post < ApplicationRecord
  belongs_to :user
  has_many :audit_logs, as: :record
  
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 1500 }
  validates :publish_date, presence: true

  scope :featured, -> { where(feature: true) }
  scope :active, -> { where(active: true) }

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  private

  def log_create
    AuditLog.create(
      user: user,
      action: 'create',
      record_type: self.class.name,
      record_id: id,
      details: attributes
    )
  end

  def log_update
    AuditLog.create(
      user: user,
      action: 'update',
      record_type: self.class.name,
      record_id: id,
      details: {
        changes: previous_changes,
        attributes: attributes
      }
    )
  end

  def log_destroy
    AuditLog.create(
      user: user,
      action: 'destroy',
      record_type: self.class.name,
      record_id: id,
      details: attributes
    )
  end
end