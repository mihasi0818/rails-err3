# 2022年5月26日時点の最新安定版
FROM ruby:3.1.4

# railsコンソール中で日本語入力するための設定
ENV LANG C.UTF-8

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
RUN mkdir /dnprp-app
ENV APP_ROOT /dnprp-app
WORKDIR $APP_ROOT

# GemfileとGemfile.lockを追加
COPY Gemfile Gemfile.lock $APP_ROOT/

# Gemfileのinstall
RUN gem install bundler -v '2.3.10'
RUN bundle install

# その他のファイルを追加
COPY . $APP_ROOT/

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
