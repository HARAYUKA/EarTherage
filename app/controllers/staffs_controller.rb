class StaffsController < ApplicationController
  # オブジェクトの準備
  before_action :set_staff, only: [:show, :edit, :update, :destroy]
  # アクセス制限
  before_action :admin_only, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    @staffs = Staff.order(created_at: "ASC").paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def edit
  end

  def update
    if @staff.update_attributes(staff_params)
      flash[:success] = "スタッフ情報を更新しました。"
      redirect_to @staff
    else
      render :template=> "staffs/edit", :locals=> { :@staff=> @staff }
   end
  end

  def destroy
    @staff.destroy
    flash[:success] = "「#{@staff.name}」のデータを削除しました。"
    redirect_to staffs_url
  end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:name, :email)
  end


end
