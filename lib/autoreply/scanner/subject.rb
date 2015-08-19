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
      "Réponse automatique"
    ]

    def autoreply?
      !detected_subjects.blank?
    end

    private

      def detected_subjects
        return unless mail.subject

        KNOWN_SUBJECTS.inject([]) do |result, subject|
          result << subject if starts_with?(mail.subject, subject)
          result
        end
      end

      def starts_with?(string, prefix)
        string[0, prefix.length] == prefix
      end
  end
end
