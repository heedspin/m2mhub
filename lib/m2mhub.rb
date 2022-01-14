module M2mhub
  class Engine < ::Rails::Engine
    # Credit: Daniel Connolly
    config.autoload_paths += %W(#{config.root}/lib)
  end
end