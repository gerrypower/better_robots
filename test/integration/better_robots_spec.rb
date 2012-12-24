$: << File.join(File.dirname(__FILE__), "..")

require 'routes'
require 'test_helper'
require 'rack/test'

describe BetterRobots::Generator do

  def get_robots(host = "site.org")
    BetterRobots::Generator.config[:robots_txt_path] = File.join(File.dirname(__FILE__), "robots")
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application, host))    
    browser.get '/robots.txt'
    browser
  end

  def robot_file_contents(robot_file)
    File.read(File.join(BetterRobots::Generator.config[:robots_txt_path], robot_file))
  end

  def reload_better_robots
    Object.send(:remove_const, :BetterRobots).send(:remove_const, :Generator)
    load 'better_robots.rb'
  end

  it "should process /robots.txt" do
    get_robots.last_response.should.be.ok
  end

  it "should display the contents of the test.site.org.robots.txt" do
    get_robots("test.site.org").last_response.body.should.equal \
      robot_file_contents("test.site.org.robots.txt")
  end

  it "should have a content type of text" do
    get_robots.last_response.headers["Content-Type"].should.equal "text/plain"
  end

  it "should have a content length matching the robots file length" do
    get_robots("test.site.org").last_response.headers["Content-Length"].should.equal \
      robot_file_contents("test.site.org.robots.txt").length.to_s
  end

  it "should default to disallow if there is no robots file" do
    get_robots("test.nosite.org").last_response.body.should.equal \
      BetterRobots::Generator::DEFAULT_DISALLOW_TEXT
  end

  it "should cache the results" do
    get_robots("test.site.org")
    BetterRobots::Generator::ROBOTS_CACHE["test.site.org"].txt.should.equal \
      robot_file_contents("test.site.org.robots.txt")
  end

  it "should use Rails.root + public for robot files, if Rails is defined" do
    Rails = OpenStruct.new({:root => Pathname.new(File.dirname(__FILE__))})
    reload_better_robots
    BetterRobots::Generator.config[:robots_txt_path].to_s.should.equal \
      File.join(File.dirname(__FILE__), "public")
  end

end
