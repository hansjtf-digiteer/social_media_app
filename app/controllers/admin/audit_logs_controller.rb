class Admin::AuditLogsController < Admin::BaseController
  def index
    @audit_logs = AuditLog.includes(:user)
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
  end
end