# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true
    # Bullet.alert   = true   # ブラウザのJavaScriptアラート
    Bullet.bullet_logger = true # Rails.root/log/bullet.log
    Bullet.console = true # ブラウザの console.log の出力先
    Bullet.rails_logger = true # Railsのログ
    Bullet.add_footer = true # 画面の下部に表示
  end
end
