# 从哪里下载镜像，可以指定目录
FROM ruby:2.7.2

# 工作目录
WORKDIR /usr/src/app
# 把源代码拷贝到这个镜像中
COPY Gemfile .
COPY Gemfile.lock .
# 在镜像中运行
RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
RUN gem install bundler
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
RUN bundle install
# 将所有的文件都拷贝到这个镜像中
COPY . .
# 更新 bin 目录
RUN bundle exec rake app:update:bin
# 暴露 3000 端口
EXPOSE 3000
# 入口命令
CMD [ "bin/rails", "server", "-b","0.0.0.0", "-p","3000"]