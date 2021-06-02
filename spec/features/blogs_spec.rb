require 'rails_helper'

RSpec.feature "Blogs", type: :feature do

  before do
    visit root_path
    click_link "受講生の方はこちら"
    click_link "管理者・スタッフはこちら"
  end

  describe "新規作成機能" do

    # 管理者は新しいブログを作成する
    scenario "admin creates new blog" do
      admin = FactoryBot.create(:staff, :admin)
      fill_in "Eメール", with: admin.email
      click_button 'ログイン'
      click_link "スタッフブログ投稿"
      expect(page).to have_content "スタッフブログ一覧"
      expect {
        click_link "新規作成"
        fill_in "Title", with: "title0"
        fill_in "Datetime", with: DateTime.now
        attach_file "blog[image]", "/mnt/c/Users/ruffini47/Pictures/人工インターン_EarTherage/1.jpg"
        click_button '作成する'
        expect(page).to have_content "title0"
        expect(page).to have_content Date.today
        expect(page).to have_content "管理者"
      }.to change(admin.blogs, :count).by(1)
    end

    # スタッフは新しいブログを作成する
    scenario "a staff creates new blog" do
      staff = FactoryBot.create(:staff)
      fill_in "Eメール", with: staff.email
      click_button 'ログイン'
      click_link "スタッフブログ投稿"
      expect(page).to have_content "スタッフブログ一覧"
      expect {
        click_link "新規作成"
        fill_in "Title", with: "title1"
        fill_in "Datetime", with: DateTime.now
        attach_file "blog[image]", "/mnt/c/Users/ruffini47/Pictures/人工インターン_EarTherage/2.jpg"
        click_button '作成する'
        expect(page).to have_content "title1"
        expect(page).to have_content Date.today
        expect(page).to have_content "staff"
      }.to change(staff.blogs, :count).by(1)
    end

  end

  describe "一覧表示機能" do

    # 管理者はブログを一覧表示する
    scenario "admin lists blogs" do
      admin_blog = FactoryBot.create(:blog, :admin)
      blog = []
      4.times do |n|
          blog[n] = FactoryBot.create(:blog)
      end
      admin = Staff.find(admin_blog.staff_id)
      fill_in "Eメール", with: admin.email
      click_button 'ログイン'
      click_link "スタッフブログ投稿"
      expect(page).to have_content "スタッフブログ一覧"
      expect(page).to have_content admin_blog.title
      expect(page).to have_content Date.today
      expect(page).to have_content "管理者"
      expect(page).to have_content blog[0].title
      expect(page).to have_content "staff2"
      expect(page).to have_content blog[1].title
      expect(page).to have_content "staff3"
      expect(page).to have_content blog[2].title
      expect(page).to have_content "staff3"
      expect(page).to have_content blog[3].title
      expect(page).to have_content "staff4"
    end

    # スタッフはブログを一覧表示する
    #scenario "a staff lists a blog" do
    #  blog = FactoryBot.create(:blog)
    #  staff = Staff.find(blog.staff_id)
    #  fill_in "Eメール", with: staff.email
    #  click_button 'ログイン'
    #  click_link "スタッフブログ投稿"
    #  expect(page).to have_content "スタッフブログ一覧"
    #  expect(page).to have_content blog.title
    #  expect(page).to have_content Date.today
    #  expect(page).to have_content "staff2"
    #end

  end

  describe "詳細表示機能" do

    context "管理者は管理者自身のブログを詳細表示する" do
      scenario "admin views admin's blog details" do
        admin_blog = FactoryBot.create(:blog, :admin)
        blog = []
        4.times do |n|
          blog[n] = FactoryBot.create(:blog)
        end
        admin = Staff.find(admin_blog.staff_id)
        fill_in "Eメール", with: admin.email
        click_button 'ログイン'
        click_link "スタッフブログ投稿"
        click_link "Show0"
        expect(page).to have_content "スタッフブログ詳細表示"
        expect(page).to have_content admin_blog.title
        expect(page).to have_content "管理者"
      end
    end

    context "管理者はスタッフのブログを詳細表示する" do
      scenario "admin views staff's blog details" do
        admin_blog = FactoryBot.create(:blog, :admin)
        blog = []
        4.times do |n|
          blog[n] = FactoryBot.create(:blog)
        end
        admin = Staff.find(admin_blog.staff_id)
        fill_in "Eメール", with: admin.email
        click_button 'ログイン'
        click_link "スタッフブログ投稿"
        click_link "Show2"
        expect(page).to have_content "スタッフブログ詳細表示"
        expect(page).to have_content blog[1].title # = show - 1
        expect(page).to have_content "staff11" #= show + 9
      end
    end

    #スタッフはブログを詳細表示する
    #scenario "a staff views blog details" do
    #  blog = FactoryBot.create(:blog)
    #  staff = Staff.find(blog.staff_id)
    #  fill_in "Eメール", with: staff.email
    #  click_button 'ログイン'
    #  click_link "スタッフブログ投稿"
    #  click_link "Show"
    #  expect(page).to have_content "スタッフブログ詳細表示"
    #  expect(page).to have_content blog.title
    #  expect(page).to have_content "MyString"
    #  expect(page).to have_content "staff4"
    #end

  end

end
