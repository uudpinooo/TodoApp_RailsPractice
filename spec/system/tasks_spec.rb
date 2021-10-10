require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # letは遅延評価のため呼び出されるまでは実行されない
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'ユーザーAのタスク1', description: 'ユーザーAが作成したタスクの1つ目です', user: user_a) }

  before do
    # ユーザーAでログインする
    # Capybara使用
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  # example(itなどの期待する挙動)の共通化
  # it_behaves_likeで呼び出す
  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content 'ユーザーAのタスク1' }
  end

  describe '一覧機能表示' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクは表示されない' do
        #ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).not_to have_content 'ユーザーAのタスク1'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'タスク名', with: task_name
      click_button '登録'
    end

    context '新規作成画面でタスク名を入力したとき' do
      let(:task_name) { 'タスク名を入力して新規作成する' }

      it 'タスクが正常に登録される' do
        expect(page).to have_selector '.alert-primary', text: 'タスクを登録しました'
      end
    end

    context '新規作成画面でタスク名を入力しなかったとき' do
      let(:task_name) { '' }

      it 'エラーになる' do
        expect(page).to have_selector '.alert-danger', text: 'タスク名を入力してください'
      end
    end
  end
end