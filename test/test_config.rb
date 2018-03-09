require 'test/unit'
require 'hiklas/utils/lumber'
require 'hiklas/config/config'


class TestConfig < Test::Unit::TestCase

  include Hiklas::Utils::Lumber::LumberJack

  @@log = lumber(self.name)

  def setup()
    @@log.debug('Setup')
    @config = Config.new
  end

  def test_creation()
    assert(@config != nil)
  end

end