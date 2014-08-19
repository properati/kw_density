#encoding: utf-8
class KwDensity
  class Pt < Base
    require "i18n"
    def canonicalize(words)
      stripped_accents = words.map{|w| I18n.transliterate(w)}
      super(stripped_accents)
    end

    def clean(words)
      words = reject_prepositions(words)
      super(words)
    end

    #Preposiciones
    #Contracciones de artículos
    #Pronombres
    #Verbos situacionales (ser ter ir estar falar morar)

    PREPOSITIONS = %w{ acima depois circulo em porque antes ao lado entre mas perto para durante de frente dentro vez como perto cima fora demasiado desde que para baixo até acima sim no na nos nas num numa nuns numas pelo pela pelos pelas do das dos das dum duma duns dumas deste desta destes destas desse dessa desses dessas o a os as ele ela eles elas uma um umas uns este esta estes estas esse essa esses essas aquele aquela aqueles aquelas meu minha meus minhas teu tua teus tuas seu sua dele dela seus suas nosso nossa nossos nossas vosso vossa vossos vossas eu tu nós vós você vocês mo to lho no-lo vo-lo ma ta lha no-la vo-la mos tos lhos no-los vo-los mas tas lhas no-las vo-las me te vos lhe lhes sou és é somos sois são tenho tens tem temos tendes têm vou vais vai vamos ides vão estou estás está estamos estáis estão moro moras mora moramos morais moram bastante bastantes muito muitos pouco poucos usual usuais mais ou menos verdade } 
    def reject_prepositions(words)
      words.reject{|word| PREPOSITIONS.include?(word)}
    end
  end
end