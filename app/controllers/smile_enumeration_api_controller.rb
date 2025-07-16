class SmileEnumerationApiController < ApplicationController
  unloadable

  skip_before_action :check_if_login_required
  before_action :check_api_authentication

  def project
    enumerations = ProjectEnumeration.all.each_with_object({}) do |e, hash|
      hash[e.id] = {
        project_id: e.project_id,
        custom_field_id: e.custom_field_id,
        value: e.value,
        status: e.status,
        sharing: e.sharing,
        position: e.position
      }
    end

    render json: enumerations
  end

  private

  def check_api_authentication
    # 嘗試從 header 取得 API 金鑰
    if request.headers['X-Redmine-API-Key'].present?
      user = User.find_by_api_key(request.headers['X-Redmine-API-Key'])
      if user
        User.current = user
        return
      end
    end

    # 或從 URL ?key=xxx 查詢
    if params[:key].present?
      user = User.find_by_api_key(params[:key])
      if user
        User.current = user
        return
      end
    end

    render json: { error: 'Forbidden - invalid or missing API key' }, status: 403
  end
end
