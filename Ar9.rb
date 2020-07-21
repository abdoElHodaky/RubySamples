require "shell"
sh=Shell::new
echo=Shell::Echo.new(sh,'abdo')
s=Shell::BuiltInCommand::new(sh)
puts s.active?()
s=Shell::ProcessController.new sh
puts Shell::ProcessController.active_process_controllers

