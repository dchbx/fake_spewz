require 'date'
module FakeSpewz
  module Models
    class PersonModel #< FakeSpewz::Models::Model
      GENDER_KINDS              = [:male, :female]
      NEUTRAL_NAME_PREFIX_KINDS = [:adm, :atty, :capt, :cmdr, :col, :dr, :gov, :hon, :prof]
      MALE_NAME_PREFIX_KINDS    = [:brother, :father, :mr] + NEUTRAL_NAME_PREFIX_KINDS
      FEMALE_NAME_PREFIX_KINDS  = [:ms, :mrs, :sister] + NEUTRAL_NAME_PREFIX_KINDS

      NEUTRAL_NAME_SUFFIX_KINDS = [:cpa, :dds, :esq, :jd, :lld, :phd, :ret, :rn, :do]
      MALE_NAME_SUFFIX_KINDS    = [:ii, :iii, :iv, :jr, :sr] + NEUTRAL_NAME_SUFFIX_KINDS
      FEMALE_NAME_SUFFIX_KINDS  = NEUTRAL_NAME_SUFFIX_KINDS

      AGE_EPOCH_KINDS = [:child, :child_under_26, :adult, :elder] 
      ADULT_AGE_RANGE = 18..64
      CHILD_AGE_RANGE = 0..18
      CHILD_UNDER_26_AGE_RANGE = 0..26
      ELDER_AGE_RANGE = 65..120

      USES_TOBACCO_KINDS = [:true, :false, :unknown]

      def initialize(traits = {})
        # super

        traits.each do |k,v|
          instance_variable_set("@#{k}", v) unless v.nil?
        end

        @id_offset = traits[:id_offset] || 0
        @age_epoch = traits[:age_epoch] || :adult

        # Enable override of any model attribute
        # @id               = traits[:id]               unless traits[:id].nil?
        # @gender           = traits[:gender]           unless traits[:gender].nil?
        # @first_name       = traits[:first_name]       unless traits[:first_name].nil?
        # @middle_name      = traits[:middle_name]      unless traits[:middle_name].nil?
        # @last_name        = traits[:last_name]        unless traits[:last_name].nil?
        # @name_prefix      = traits[:name_prefix]      unless traits[:name_prefix].nil?
        # @name_suffix      = traits[:name_suffix]      unless traits[:name_suffix].nil?
        # @date_of_birth    = traits[:date_of_birth]    unless traits[:date_of_birth].nil?
        # @ssn              = traits[:ssn]              unless traits[:ssn].nil?
        # @is_incarcerated  = traits[:is_incarcerated]  unless traits[:is_incarcerated].nil?
        # @is_disabled      = traits[:is_disabled]      unless traits[:is_disabled].nil?
        # @uses_tobacco     = traits[:uses_tobacco]     unless traits[:uses_tobacco].nil?
      end

      def call
        build_person_model
      end

      def build_person_model
        {
            id: id,
            gender: gender,
            name_prefix: name_prefix,
            first_name: first_name,
            middle_name: middle_name,
            last_name: last_name,
            name_suffix: name_suffix,
            ssn: ssn,
            date_of_birth: date_of_birth,
            is_incarcerated: is_incarcerated,
            is_disabled: is_disabled,
            uses_tobacco: uses_tobacco,
          }
      end

      def id
        @id ||= @id_offset + 1
      end

      def gender
        @gender ||= GENDER_KINDS.sample
      end

      def first_name
        @first_name ||= _get_first_name
      end

      def middle_name
        @middle_name ||= _get_middle_name
      end

      def last_name
        @last_name ||= _get_last_name
      end

      def name_prefix
        @gender == :male ? MALE_NAME_PREFIX_KINDS.sample : FEMALE_NAME_PREFIX_KINDS.sample
      end

      def name_suffix
        @gender == :male ? MALE_NAME_SUFFIX_KINDS.sample : FEMALE_NAME_SUFFIX_KINDS.sample
      end

      def date_of_birth
        # Age epoch is ignored if date of birth value is a specified trait
        return @date_of_birth if defined?(@date_of_birth)

        case @age_epoch
        when :adult
          age_today = rand(ADULT_AGE_RANGE)
        when :child
          age_today = rand(CHILD_AGE_RANGE)
        when :child_under_26
          age_today = rand(CHILD_UNDER_26_AGE_RANGE)
        when :elder
          age_today = rand(ELDER_AGE_RANGE)
        end

        # Eliminate leap year edge case
        day_of_year = [Date.today.yday, 365].min
        @date_of_birth = Date.ordinal(Date.today.year - age_today, day_of_year)
      end

      def ssn
        123456789
      end

      def is_incarcerated
        @is_incarcerated ||= [true, false].sample
      end

      def is_disabled
        @is_disabled ||= [true, false].sample
      end

      def uses_tobacco
        @uses_tobacco ||= USES_TOBACCO_KINDS.sample
      end

    private

      # use Redit in-memory database to pick random name
      def _get_first_name
        "johnny"
      end

      # use the first name call to return middle name
      def _get_middle_name
        "adam"
      end

      # use Redit in-memory database to pick random name
      def _get_last_name
        "appleseed"
      end

    end
  end
end