require "better_robots/version"
require 'ostruct'

module BetterRobots
  class Generator
    DEFAULT_DISALLOW_TEXT = "User-agent: *\nDisallow: /"
    ROBOTS_CACHE = {}

    class << self

      def config
        @config ||= {
          :robots_txt_path => ((Rails.root.join("public") if defined? Rails) || ".")
        }
      end

      def call(env)
        res = cached_robots_txt_for(env['SERVER_NAME'])
        [ 200, headers_for(res), [ res.txt ] ]
      end

      def cached_robots_txt_for(server_name)
        ROBOTS_CACHE[server_name] ||= robots_txt_for(server_name)
      end

      def robots_txt_for(server_name)
        begin
          txt = read_robots_file(server_name)
          OpenStruct.new(:txt => txt, :length => txt.length)
        rescue Errno::ENOENT
          OpenStruct.new(:txt => DEFAULT_DISALLOW_TEXT, :length => DEFAULT_DISALLOW_TEXT.length)
        end
      end

      def read_robots_file(server_name)
        File.read(File.join(config[:robots_txt_path], "#{server_name}.robots.txt"))
      end

      def headers_for(res)
        {
          "Content-Type" => "text/plain",
          "Content-Length" => res.length.to_s
        }
      end

    end

    private_class_method :cached_robots_txt_for, :robots_txt_for,
                         :read_robots_file, :headers_for

  end
end
