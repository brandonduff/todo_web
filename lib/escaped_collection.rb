class EscapedCollection
  def self.from(objects)
    new(objects).make_safe
  end

  def initialize(objects)
    @objects = objects
  end

  def make_safe
    @objects.each do |object|
      def object.to_s
        CGI.escape_html(super)
      end
    end
  end
end
