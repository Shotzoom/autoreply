module Autoreply
  class Scanner::Subject < Scanner::Base
    KNOWN_SUBJECTS = [
      "Auto:",
      "Automatic reply",
      "Autosvar",
      "Automatisk svar",
      "Automatisch antwoord",
      "Abwesenheitsnotiz",
      "Risposta Non al computer",
      "Automatisch antwoord",
      "Auto Response",
      "Respuesta automática",
      "Fuori sede",
      "Out of Office",
      "Frånvaro",
      "Réponse automatique",
      "Abwesend"
    ]

    def autoreply?
      !detected_subjects.empty?
    end

    private

      def detected_subjects
        return [] unless mail.subject

        KNOWN_SUBJECTS.inject([]) do |result, subject|
          result << subject unless mail.subject.match(subject).nil?
          result
        end
      end
  end
end
