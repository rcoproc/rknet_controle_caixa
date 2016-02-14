Rails.configuration.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]
Rails.configuration.i18n.available_locales %w[pt-BR en]