if defined?(PryByebug)
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'ff', 'finish'
end
Pry.commands.alias_command 'ee', 'exit'
# Pry.commands.alias_command 'e!', 'exit!'
Pry.commands.alias_command 'dd', 'disable-pry' rescue nil
Pry.commands.alias_command "hh", "hist -T 20", desc: "Last 20 commands"
Pry.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
  warn "awesome_print not installed"
end

class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

