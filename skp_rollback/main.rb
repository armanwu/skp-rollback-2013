# frozen_string_literal: true

require 'sketchup.rb'

module SKPRollback
  def self.save_to_2013
    model = Sketchup.active_model
    unless model
      UI.messagebox('No active SketchUp model found.')
      return
    end

    current_path = model.path
    if current_path && !current_path.empty?
      dir = File.dirname(current_path)
      ext = File.extname(current_path)
      base = File.basename(current_path, ext)
      target_path = File.join(dir, "#{base}_v2013#{ext}")
    else
      target_path = UI.savepanel('Save to SketchUp 2013', nil, 'model_v2013.skp')
      return if target_path.nil?
    end

    target_path += '.skp' unless target_path.downcase.end_with?('.skp')

    status = model.save_copy(target_path, Sketchup::Model::VERSION_2013)
    if status
      UI.messagebox("Successfully saved to SketchUp 2013:\n#{target_path}")
    else
      UI.messagebox("Failed to save file to SketchUp 2013.")
    end
  rescue => e
    UI.messagebox("Error saving to SketchUp 2013:\n#{e.message}")
  end

  unless file_loaded?(__FILE__)
    plugins_menu = UI.menu('Plugins')
    cmd_save = UI::Command.new('Save to SketchUp 2013') {
      SKPRollback.save_to_2013
    }
    cmd_save.tooltip = 'Save copy of active model to SketchUp 2013 format'
    cmd_save.status_bar_text = 'Save copy of active model to SketchUp 2013'

    plugins_menu.add_item(cmd_save)

    file_loaded(__FILE__)
  end
end
