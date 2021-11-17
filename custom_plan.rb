ROOT_PATH = File.expand_path(Dir.pwd)
require 'zeus'
require 'zeus/plan'
require 'zeus/m'
require 'bundler'

class CustomPlan < Zeus::Plan
  def boot
    $LOAD_PATH.push(File.expand_path('test'))
    $LOAD_PATH.push(File.expand_path('lib'))
    Bundler.require
    require 'test_helper'
  end

  def test(argv=$ARGV)
    Zeus::M.run(argv)
  end

  def console
    Pry.start
  end
end

Zeus.plan = CustomPlan.new

