# frozen_string_literal: true
#
# SKP Rollback to 2013
# Copyright (c) 2026 Arman Arisman
# Licensed under the MIT License.
#

require 'sketchup.rb'

module SKPRollback
  COPYRIGHT = "© 2026 Arman Arisman. Released under the MIT License."

  def self.save_to_2013
    model = Sketchup.active_model
    unless model
      UI.messagebox("SKP Rollback to 2013\n\nNo active SketchUp model found.\n\n#{COPYRIGHT}", MB_OK)
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
      UI.messagebox("SKP Rollback to 2013\n\nSuccessfully saved model copy to:\n#{target_path}\n\n#{COPYRIGHT}", MB_OK)
    else
      UI.messagebox("SKP Rollback to 2013\n\nFailed to save file to SketchUp 2013.\n\n#{COPYRIGHT}", MB_OK)
    end
  rescue => e
    UI.messagebox("SKP Rollback to 2013\n\nError saving to SketchUp 2013:\n#{e.message}\n\n#{COPYRIGHT}", MB_OK)
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
