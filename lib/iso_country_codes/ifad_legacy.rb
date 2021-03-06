class IsoCountryCodes

  # List of legacy ISO-2 and ISO-3 codes used in IFAD.
  # These should be changed as soon as possible in other systems.
  LEGACY_CODES = {
    'CD'  => 'ZR',
    'RS'  => 'YG',
    'TL'  => 'TP',
    'COD' => 'CDR',
    'PSE' => 'PAL',
    'TLS' => 'TMP',
    'NLD' => 'ABW',
    'NL'  => 'AW',
    'IT'  => 'IF', # IFAD is a Country for PeopleSoft
    'ITA' => 'IFA' # IFAD is a Country for PeopleSoft
  }.freeze

  def self.legacy(iso_2)
    return unless iso_2
    LEGACY_CODES[iso_2.to_s.upcase]
  end

  def self.current(iso_2)
    return unless iso_2
    LEGACY_CODES.invert[iso_2.to_s.upcase]
  end

  class << IsoCountryCodes
    alias_method :orig_find, :find
    private :orig_find

    def find(code, &block)
      orig_find(IsoCountryCodes.current(code) || code, &block)
    end
  end

end
