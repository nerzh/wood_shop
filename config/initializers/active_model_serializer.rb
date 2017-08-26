class Serializer < ActiveModel::Serializer
  class << self
    def group(group_name, &block)
      with_options(if: -> { group?(group_name) }, &block)
    end
  end

  def group_set
    @group_set ||= begin
      groups = [instance_options[:group]].flatten.compact
      groups.map(&:to_sym).to_set
    end
  end

  def group?(group_name)
    group_set.include?(group_name.to_sym)
  end

  # my
  # def initialize(object, options = {})
  #   define_attributes(options[:paid_account])
  #   super(object, options)
  # end
  #
  # def define_attributes(state)
  #   self.class._attributes_data = {}
  #
  #   if state
  #     self.class.attributes :name, :specialty_vacancy_id, :salary, :job_period, :job_start, :job_form,
  #                           :cost_house, :duties, :amount_seats, :place_work, :responsibility, :making_decisions,
  #                           :education, :experience, :comp_service, :languages, :courses, :knowledge, :skills,
  #                           :privileges, :equipment
  #   else
  #     self.class.attributes :name, :specialty_vacancy_id, :salary, :job_period, :job_start, :job_form,
  #                           :cost_house, :duties, :amount_seats
  #   end
  # end
end