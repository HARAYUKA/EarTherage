class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :staff_only, only: [:new, :edit, :destroy]


  # スケジュール一覧
  def index
    if current_staff.present?
      @schedules = Schedule.paginate(page: params[:page], per_page: 9).order(date: "DESC")
    else
      @schedules = Schedule.paginate(page: params[:page], per_page: 9).where.not(public_status: "非公開").order(date: "DESC")
    end
    # if params[:search].present?
    #   @schedules = Schedule.paginate(page: params[:page]).search(params[:search]) 
    # end

  #検索機能-------------------------------------------------------------------
    if params[:area].present?
      @schedules = @schedules.paginate(page: params[:page], per_page: 6).get_by_area params[:area]
      # @schedules = Schedule.areas.key(params[:area].to_i)
    end
    if params[:event_type].present?
      @schedules = @schedules.paginate(page: params[:page], per_page: 6).get_by_event_type params[:event_type]
    end
    if params[:teacher].present?
      @schedules = @schedules.paginate(page: params[:page], per_page: 6).get_by_teacher params[:teacher]
    end
  #--------------------------------------------------------------------------    

  #会員限定の絞り込み-----------------------------------------------------------
    if params[:judgement_of_members] == "1"
      @schedules = @schedules.paginate(page: params[:page], per_page: 6).get_by_members params[:judgement_of_members]
    end
  #-------------------------------------------------------------------------- 
  end

  # スケジュール詳細
  def show
  end

  # スケジュール作成
  def new
    @schedule = Schedule.new
    # @staffs = Staff.where.not(admin: true)
  end

  # スケジュール作成・保存
  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      flash[:success] = '新規投稿しました。'
      redirect_to @schedule
    else
      render :new
    end
  end

  # スケジュール編集
  def edit
    # @staffs = Staff.where.not(admin: true)
  end

  # スケジュール更新
  def update
    # if @schedule.update_attributes!(schedule_params)
    if @schedule.update_attributes(schedule_params)
      flash[:success] = "更新しました。"
      redirect_to @schedule
    else
      flash.now[:danger] = "#{@schedule.errors.full_messages}" if @schedule.errors.present?
      render :edit
    end
  end

  # スケジュール削除
  def destroy
    @schedule.destroy
    flash[:success] = "#{@schedule.date}の投稿を削除しました。"
    redirect_to schedules_url
  end


  private

      def schedule_params
        params.require(:schedule).permit(:date, :area, :place, :teacher, :event_type, :title, :details, :image, :public_status, :judgement_of_members)
      end

      def staff_only
        unless current_staff.present?
          flash[:danger] = "許可されていない操作です。"
          redirect_to schedules_url
        end
      end

end
