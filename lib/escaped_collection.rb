class EscapedCollection
  def self.from(objects)
    new(objects).make_safe
  end

  def initialize(objects)
    @objects = objects
  end

  def make_safe
    @objects.map { |object| EscapedObject.new(object) }
  end

  class EscapedObject < SimpleDelegator
    def to_s
      CGI.escape_html(super)
    end
  end
end
