module M2mhub
  class Error < StandardError; end
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
  end
end