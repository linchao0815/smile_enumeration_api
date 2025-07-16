class SmileEnumerationApiController < ApplicationController
  # ✅ 啟用 API 認證（支援 API Key / HTTP basic）
  accept_api_auth :project

  # ✅ 執行順序：啟用檢查 → API key 身分驗證
  before_action :check_api_enabled
  before_action :find_user_by_api_key

  def project
    # ⚠️ 雖上述方法中應已驗證身分，但仍防呆一次確認登入狀態
    unless User.current.logged?
      render json: { error: 'Unauthorized. No API user.' }, status: 401 and return
    end

    # ✅ 查出所有 ProjectEnumeration 並建構 json hash
    enumerations = ProjectEnumeration.all.each_with_object({}) do |e, hash|
      hash[e.id] = {
        project_id:      e.project_id,
        custom_field_id: e.custom_field_id,
        value:           e.value,
        status:          e.status,
        sharing:         e.sharing,
        position:        e.position
      }
    end
    Rails.logger.info "[SmileEnumerationApi] 回傳 enumerations 筆數: #{enumerations.size}"
    render json: enumerations, status: 200
  end

  private

  # ✅ 只支援 X-Redmine-API-Key header 驗證 API key 並設定 User.current
  def find_user_by_api_key
    api_key = request.headers["X-Redmine-API-Key"]
    if api_key.present?
      user = User.find_by_api_key(api_key)
      if user && user.active?
        User.current = user
      else
        render json: { error: 'Unauthorized' }, status: 401 and return
      end
    else
      render json: { error: 'Unauthorized' }, status: 401 and return
    end
  end

  # ✅ 檢查 Redmine 是否有啟用 REST API
  def check_api_enabled
    unless Setting.rest_api_enabled?
      render json: { error: 'API not enabled in Redmine settings' }, status: 403 and return
    end
  end
end
