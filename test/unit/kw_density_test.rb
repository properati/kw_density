require "test_config"
require "kw_density"
require "kw_density/es"
require "kw_density/pt"

class TestKwDensity < Minitest::Unit::TestCase
  def test_basic
    d = KwDensity::Base.new
    d << "test"
    assert_equal({"test" => 1}, d.top, "Basic")
    d << "perrito test"
    assert_equal({"test" => 2, "perrito" => 1}, d.top, "Add more keywords")
    d << "TEST"
    assert_equal({"test" => 3, "perrito" => 1}, d.top, "Canonicalize")
  end

  def test_strip_html
    d = KwDensity::Base.new
    d << "perrito <br> test"
    assert_equal({"test" => 1, "perrito" => 1}, d.top, "Add more keywords")
  end

  def test_reject_symbols
    d = KwDensity::Base.new
    d << "perrito - test, o-oo"
    assert_equal({"test" => 1, "ooo" => 1, "perrito" => 1}, d.top, "Symbols should be rejected")
  end


  def test_basic_lang_Es
    d = KwDensity::Es.new
    d << "test"
    assert_equal({"test" => 1}, d.top, "Basic")
    d << "perrito tést"
    assert_equal({"test" => 2, "perrito" => 1}, d.top, "Add more keywords")
    d << "TÉST"
    assert_equal({"test" => 3, "perrito" => 1}, d.top, "Canonicalize")
    d << "a ante cabe"
    assert_equal({"test" => 3, "perrito" => 1}, d.top, "Reject prepositions")
  end

  def test_basic_lang_Pt
    d = KwDensity::Pt.new
    d << "test"
    assert_equal({"test" => 1}, d.top, "Basic")
    d << "perrito têst"
    assert_equal({"test" => 2, "perrito" => 1}, d.top, "Add more keywords")
    d << "TêsT"
    assert_equal({"test" => 3, "perrito" => 1}, d.top, "Canonicalize")
    d << "acima depois circulo em porque"
    assert_equal({"test" => 3, "perrito" => 1}, d.top, "Reject prepositions")
  end

  def test_ngrams
    d = KwDensity::Es.new(2)
    d << "hermosa piscina calefaccionada"
    assert_equal({"hermosa piscina" => 1, "piscina calefaccionada" => 1}, d.top, "Basic, ngram")
    d << "hermosa piscina con calefaccionada"
    assert_equal({"hermosa piscina" => 2, "piscina calefaccionada" => 2}, d.top, "Basic, ngram")

  end

end

