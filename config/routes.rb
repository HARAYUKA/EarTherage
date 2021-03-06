Rails.application.routes.draw do
  #rootを受講生ログイン画面に設定
  devise_scope :student do
    root 'therapist_training_course#index', as: :public_root, constraints: LoggedInConstraint.new("therapist_training")
    root 'self_care_course#index', constraints: LoggedInConstraint.new("self_care")
    root 'admin_screen#index', constraints: LoggedInConstraint.new("true")
    root 'staffs_screen#index', constraints: LoggedInConstraint.new("false")
    root "students/sessions#new", constraints: LoggedInConstraint.new("")
  end

  devise_for :staffs, :controllers => {
    :registrations => 'staffs/registrations',
    :sessions => 'staffs/sessions'
  }
  devise_for :students, :controllers => {
    :sessions => 'students/sessions'
  }

  get 'therapist_training_course' => 'therapist_training_course#index', as: :therapist_training_course#セラピスト養成コース画面トップページ
  get 'self_care_course' => "self_care_course#index", as: :self_care_course#セルフケアコース画面トップページ
  get 'therapist_training_course/:id' => 'therapist_training_course#show', as: :therapist_training_course_show#セラピスト養成コース マイページ
  get 'self_care_course/id' => 'self_care_course#show', as: :self_care_course_show#セルフケアコース マイページ

  get 'admin_screen' => 'admin_screen#index', as: :admin_screen#管理者画面
  get 'staffs_screen' => 'staffs_screen#index', as: :staffs_screen#スタッフ画面

  resources :staffs do
    resources :blogs #スタッフブログ
  end

  resources :schedules#開講スケジュール

  resources :students#ユーザー管理

  resources :uploads, only: [:create, :destroy]

  resources :backgrounds#背景画像選択

  get 'serapoke' => 'serapoke#index', as: :serapoke#せらポケ

  get 'diploma' => 'diploma#index', as: :diploma#ディプロマ

  get '/admin/:student_id/student_edit' => 'admins#student_edit', as: :student_edit_admin#student編集

  post '/students/import' => 'students#import', as: :import_students#csvファイル取り込み

end
