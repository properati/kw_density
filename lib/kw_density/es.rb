class KwDensity
  class Es < Base
    require "i18n"
    def canonicalize(words)
      stripped_accents = words.map{|w| I18n.transliterate(w)}
      super(stripped_accents)
    end

    def clean(words)
      words = reject_prepositions(words)
      super(words)
    end

    PREPOSITIONS = %w{ del ref hs and que si no al son el o y a ante bajo cabe con contra de desde durante en entre hacia hasta mediante para por según sin so sobre tras un una unas unos uno sobre todo también tras otro algún alguno alguna algunos algunas ser es soy eres somos sois estoy esta estamos estais estan como en para atras porque por qué estado estaba ante antes siendo ambos pero por poder puede puedo podemos podeis pueden fui fue fuimos fueron hacer hago hace hacemos haceis hacen cada fin incluso primero desde conseguir consigo consigue consigues conseguimos consiguen ir voy va vamos vais van vaya gueno ha tener tengo tiene tenemos teneis tienen el la lo las los su aqui mio tuyo ellos ellas nos nosotros vosotros vosotras si dentro solo solamente saber sabes sabe sabemos sabeis saben ultimo largo bastante haces muchos aquellos aquellas sus entonces tiempo verdad verdadero verdadera cierto ciertos cierta ciertas intentar intento intenta intentas intentamos intentais intentan dos bajo arriba encima usar uso usas usa usamos usais usan}
    def reject_prepositions(words)
      words.reject{|word| PREPOSITIONS.include?(word)}
    end
  end
end
