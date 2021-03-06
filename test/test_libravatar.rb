require 'helper'

class TestLibravatar < Test::Unit::TestCase
  should "Generate url from email" do
    # echo -n "user@example.com"|shasum -a 256
    # => b4c9a289323b21a01c3e940f150eb9b8c542587f1abfd8f0e1cc1ffc5e475514
    avatar = Libravatar.new(:email => "user@example.com")
    assert_equal avatar.to_s, "http://cdn.libravatar.org/avatar/b4c9a289323b21a01c3e940f150eb9b8c542587f1abfd8f0e1cc1ffc5e475514"

    assert_equal Libravatar.new(:email => "USER@ExAmPlE.CoM").to_s, "http://cdn.libravatar.org/avatar/b4c9a289323b21a01c3e940f150eb9b8c542587f1abfd8f0e1cc1ffc5e475514"

    assert_equal Libravatar.new(:email => "USER@ExAmPlE.CoM", :default => "http://example.com/avatar.png").to_s, "http://cdn.libravatar.org/avatar/b4c9a289323b21a01c3e940f150eb9b8c542587f1abfd8f0e1cc1ffc5e475514?d=http://example.com/avatar.png"

    assert_equal Libravatar.new(:email => "USER@ExAmPlE.CoM", :size => 512, :default => "mm").to_s, "http://cdn.libravatar.org/avatar/b4c9a289323b21a01c3e940f150eb9b8c542587f1abfd8f0e1cc1ffc5e475514?s=512&d=mm"
  end

  should "Generate url from openid" do
    avatar = Libravatar.new(:openid => "http://example.com/id/Bob")
    assert_equal avatar.to_s, "http://cdn.libravatar.org/avatar/80cd0679bb52beac4d5d388c163016dbc5d3f30c262a4f539564236ca9d49ccd"

    avatar = Libravatar.new(:openid => "hTTp://EXAMPLE.COM/id/Bob")
    assert_equal avatar.to_s, "http://cdn.libravatar.org/avatar/80cd0679bb52beac4d5d388c163016dbc5d3f30c262a4f539564236ca9d49ccd"

    avatar = Libravatar.new(:openid => "hTTp://EXAMPLE.COM/id/Bob", :size => 512)
    assert_equal avatar.to_s, "http://cdn.libravatar.org/avatar/80cd0679bb52beac4d5d388c163016dbc5d3f30c262a4f539564236ca9d49ccd?s=512"
  end

  should "Normalize OpenID" do
    x = Libravatar.new
    assert_equal x.send(:normalize_openid, "HTTP://EXAMPLE.COM/id/Bob"), "http://example.com/id/Bob"

    assert_equal x.send(:normalize_openid, "HTTP://EXAMPLE.COM"), "http://example.com/"
  end
end
