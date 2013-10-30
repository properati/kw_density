require "kw_density/version"

class KwDensity
  class Base
    attr_accessor :stopwords
    def initialize(n=1)
      @ngrams = {}
      @stopwords = []
      @n = n
    end

    def <<(phrase)
      words = split(phrase)
      canonical = canonicalize(words)
      clean = clean(canonical)

      words = clean

      words.each.with_index{|word, index|
        next if index + @n > words.length
        ngram = words[index ... index + @n].join(' ')
        @ngrams[ngram] ||= 0
        @ngrams[ngram] += 1
      }
    end

    def top(n=100)
      Hash[sorted.reverse[0 .. n]]
    end

    def sorted
      @ngrams.sort_by(&:last)
    end

    def canonicalize(words)
      Array(words).map{|word|
        word.downcase.gsub(/[:"';_,\.)(-]/,'').strip
      }
    end

    def split(phrase)
      phrase.split.reject(&:empty?)
    end

    def clean(words)
      words = strip_html(words)
      words = reject_symbols(words)
      words = reject_stopwords(words)
      words = words.reject{|w| w.length < 3}
      words
    end


    def reject_stopwords(words)
      words.reject{|word| @stopwords.index(word)}
    end

    def reject_symbols(words)
      words.find_all{|word| word.match(/[a-z]/)}
    end

    def strip_html(words)
      words.map{|word|
        word.gsub(/<[^>]+>/,'')
      }.reject(&:empty?)
    end
  end

end
