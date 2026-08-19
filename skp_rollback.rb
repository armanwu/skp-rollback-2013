# frozen_string_literal: true

require 'sketchup.rb'
require 'extensions.rb'

module SKPRollback
  unless file_loaded?(__FILE__)
    loader_path = File.join(File.dirname(__FILE__), 'skp_rollback', 'main.rb')
    
    ex = SketchupExtension.new('SKP Rollback to 2013', loader_path)
    ex.description = 'Directly saves a copy of the active SketchUp model to SketchUp 2013 format.'
    ex.version     = '1.0.0'
    ex.copyright   = 'Copyright 2026 Arman Arisman'
    ex.creator     = 'Arman Arisman'
    
    Sketchup.register_extension(ex, true)
    file_loaded(__FILE__)
  end
end
