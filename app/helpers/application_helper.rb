module ApplicationHelper
  def not_funny_is_it(var)
    "#{var} is not funny"
  end

  def full_name(name)
    [
      name['title'],
      name['first'],
      name['last']
    ].join(' ')
  end
end
