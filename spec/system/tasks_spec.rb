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

  describe '一覧機能表示' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content 'ユーザーAのタスク1'
      end
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

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content 'ユーザーAのタスク1'
      end
    end
  end
end