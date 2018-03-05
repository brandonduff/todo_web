require 'escaped_collection'

describe EscapedCollection do
  describe 'when given a collection of objects' do
    subject { described_class.new(objects) }
    let(:bad_stuff) { '<script>alert("pwned")</script>' }
    let(:objects) { [bad_stuff] }

    it 'defines to_s on each to escape' do
      escaped_objects = subject.make_safe
      expect(escaped_objects[0].to_s).to eq(CGI.escape_html(bad_stuff))
    end
  end
end
