desc 'Switch Rails logger to stdout (app level)'
task v: :environment do
  init_logger
end

desc 'Switch Rails logger to stdout (debug level)'
task vd: :environment do
  init_logger
  Rails.logger.level = 0
end

def init_logger
  stdout_logger = Logger.new(STDOUT)
  file_logger = Logger.new("#{Rails.env}.log")
  ActiveSupport::BroadcastLogger.new(stdout_logger, file_logger)
end
