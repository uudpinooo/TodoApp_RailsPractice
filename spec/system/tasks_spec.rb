require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧機能表示' do
    before do
      # ユーザーAを作成
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # 作成者がユーザーAであるタスクを作成
      FactoryBot.create(:task, name: 'ユーザーAのタスク1', description: 'ユーザーAが作成したタスクの1つ目です', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        # Capybara使用
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content 'ユーザーAのタスク1'
      end
    end
  end
end