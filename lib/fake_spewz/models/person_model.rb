module FakeSpewz
  module Models
    class PersonModel #< Model
      GENDER_KINDS              = [:male, :female]
      NEUTRAL_NAME_PREFIX_KINDS = [:adm, :atty, :capt, :cmdr, :col, :dr, :gov, :hon, :prof]
      MALE_NAME_PREFIX_KINDS    = [:brother, :father, :mr] + NEUTRAL_NAME_PREFIX_KINDS
      FEMALE_NAME_PREFIX_KINDS  = [:ms, :mrs, :sister] + NEUTRAL_NAME_PREFIX_KINDS

      NEUTRAL_NAME_SUFFIX_KINDS = [:cpa, :dds, :esq, :jd, :lld, :phd, :ret, :rn, :do]
      MALE_NAME_SUFFIX_KINDS    = [:ii, :iii, :iv, :jr, :sr] + NEUTRAL_NAME_SUFFIX_KINDS
      FEMALE_NAME_SUFFIX_KINDS  = NEUTRAL_NAME_SUFFIX_KINDS

      AGE_EPOCH_KINDS = [:child, :child_under_26, :adult, :elder] 
      ADULT_AGE_RANGE = 18..65
      CHILD_AGE_RANGE = 0..18
      CHILD_UNDER_26_AGE_RANGE = 0..26
      ELDER_AGE_RANGE = 66..120

      USES_TOBACCO_KINDS = [:true, :false, :unknown]

      def call(traits = {})
        @id_offset  = traits[:id_offset]  || 0
        @age_epoch  = traits[:age_epoch]  || :adult

        # Enable override of any model attribute
        @id               = traits[:id]               if traits[:id].present?
        @gender           = traits[:gender]           if traits[:gender].present?
        @first_name       = traits[:first_name]       if traits[:first_name].present?
        @middle_name      = traits[:middle_name]      if traits[:middle_name].present?
        @last_name        = traits[:last_name]        if traits[:last_name].present?
        @name_prefix      = traits[:name_prefix]      if traits[:name_prefix].present?
        @name_suffix      = traits[:name_suffix]      if traits[:name_suffix].present?
        @date_of_birth    = traits[:date_of_birth]    if traits[:date_of_birth].present?
        @ssn              = traits[:ssn]              if traits[:ssn].present?
        @is_incarcerated  = traits[:is_incarcerated]  if traits[:is_incarcerated].present?
        @is_disabled      = traits[:is_disabled]      if traits[:is_disabled].present?
        @uses_tobacco     = traits[:uses_tobacco]     if traits[:uses_tobacco].present?

        build_person
      end

      def build_person
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
        @date_of_birth = Date.new(Date.today - age_today, day_of_year)
      end

      def ssn
        123456789
      end

      def is_incarerated
        @is_incarcerated ||= [true, false].sample
      end

      def is_disabled
        @is_disabled ||= [true, false].sample
      end

      def uses_tobacco
        USES_TOBACCO_KINDS.sample
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