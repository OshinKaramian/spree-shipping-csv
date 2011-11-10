Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'shipping_csv'
  s.version      = '1.1.0'
  s.summary      = 'Export spreee order data as a csv file'
  s.description  = ''
  s.required_ruby_version = '>= 1.8.7'

  s.author       = 'Oshin Karamian, Max Sharples'
  s.email        = 'maxsharples@gmail.com'
  s.homepage     = 'https://github.com/msharp/spree-shipping-csv'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '~> 0.60.0')
  s.add_dependency('fastercsv')

end
