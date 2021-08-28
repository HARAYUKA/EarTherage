class BlogsController < ApplicationController
# オブジェクトの準備
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :set_staff, only: [:new, :create, :show]
  before_action :set_staff_by_blog_object, only: [:edit, :update, :destroy]
  # アクセス制限
  before_action :correct_staff_only, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_staff.present?
      @blogs = Blog.where(share_with: 0..4).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
    elsif current_student.present?
      if current_student.course_type == "therapist_training"
        @blogs = Blog.where(share_with: 1..3).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
      elsif current_student.course_type == "self_care"
        @blogs = Blog.where(share_with: 2..3).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
      end
    else
      @blogs = Blog.where(share_with: 3).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
    end

  #検索機能-------------------------------------------------------------------↲
  if current_staff.present?
    if params[:share_with].blank? || params[:share_with].to_i.in?([0,1,2,3])
      if params[:staff_name].present?
        @blogs = Blog.where(share_with: 0..3).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
        @blogs = @blogs.get_by_staff_name params[:staff_name]
      else
        @blogs = Blog.where(share_with: 0..3).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
      end
    elsif params[:share_with].to_i == 4
      if params[:staff_name].present?
        @blogs = Blog.where(share_with: 4).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
        @blogs = @blogs.get_by_staff_name params[:staff_name]
      else
        @blogs = Blog.where(share_with: 4).order(created_at: "DESC").paginate(page: params[:page], per_page: 10)
      end
    end
  end
  #------------------------------------------------------------------------------↲

    #if current_staff.present?
    #  @blogs = Blog.all
    #elsif current_student.present?
    #  if current_student.course_type == "therapist_training"
    #    @blogs = Blog.all
    #  elsif current_student.course_type == "self_care"
    #    @blogs = Blog.where(share_with: 1..2)
    #  end
    #else
    #  @blogs = Blog.where(share_with: 2)
    #end

    if current_staff.present?
      @staff = Staff.find(current_staff.id)
    else
      @staff = nil
    end
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      # flash.now[:success] = "ブログを作成しました。"
      # redirect_to staff_blogs_url(@staff)
      flash[:success] = "ブログを作成しました。"
      redirect_to staff_blog_url(@staff, @blog)
    else
      # flash.now[:danger] = "#{@blog.errors.full_messages}" if @blog.errors.present?
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @blog.update_attributes(blog_params)
      flash[:success] = "ブログを更新しました。"
      # redirect_to staff_blogs_url(@staff)
      redirect_to staff_blog_url(@staff, @blog)
    else
      flash.now[:danger] = "#{@blog.errors.full_messages}" if @blog.errors.present?
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:success] = "ブログのデータを削除しました。"
    redirect_to staff_blogs_url(@staff)
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :content, :image, :share_with, :staff_id, :staff_name)
    end

    # 管理者かログインしているスタッフが自身のブログである場合のみアクセス可
    def correct_staff_only
      unless current_staff.present? && (current_staff.admin == true || current_staff.id == @staff.id)
        flash[:notice] = "許可されていない操作です。"
        redirect_to root_url
      end
    end

    def set_staff
      @staff = Staff.find(params[:staff_id])
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end

    def set_staff_by_blog_object
      @staff = Staff.find(@blog.staff_id)
    end
end
