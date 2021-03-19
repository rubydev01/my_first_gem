# MyFirstGem

A gem has 3 files inside:
1. Checksums
2. Metadata: metadata about the gem
3. Data: your ruby code

## Step 1: Create the gem

```ruby
bundle gem <gem_name>
```

In my case: 

```ruby
$ bundle gem my_first_gem
```

The first time that you execute this, you are going to see some questions

```ruby
Creating gem 'my_first_gem'...
Do you want to generate tests with your gem?
Future `bundle gem` calls will use your choice. This setting can be changed anytime with `bundle config gem.test`.

Enter a test framework. rspec/minitest/test-unit/(none): rspec

Do you want to set up continuous integration for your gem? Supported services:
* CircleCI:       https://circleci.com/
* GitHub Actions: https://github.com/features/actions
* GitLab CI:      https://docs.gitlab.com/ee/ci/
* Travis CI:      https://travis-ci.org/
Future `bundle gem` calls will use your choice. This setting can be changed anytime with `bundle config gem.ci`.

Enter a CI service. github/travis/gitlab/circle/(none): github

Do you want to license your code permissively under the MIT license?
This means that any other developer or company will be legally allowed to use your code for free as long as they admit you created it. You can read more about the MIT license at https://choosealicense.com/licenses/mit. y/(n): y

MIT License enabled in config
Do you want to include a code of conduct in gems you generate?
Codes of conduct can increase contributions to your project by contributors who prefer collaborative, safe spaces. You can read more about the code of conduct at contributor-covenant.org. Having a code of conduct means agreeing to the responsibility of enforcing it, so be sure that you are prepared to do that. Be sure that your email address is specified as a contact in the generated code of conduct so that people know who to contact in case of a violation. For suggestions about how to enforce codes of conduct, see https://bit.ly/coc-enforcement. y/(n): y

Code of conduct enabled in config
Do you want to include a changelog?
A changelog is a file which contains a curated, chronologically ordered list of notable changes for each version of a project. To make it easier for users and contributors to see precisely what notable changes have been made between each release (or version) of the project. Whether consumers or developers, the end users of software are human beings who care about what's in the software. When the software changes, people want to know why and how. see https://keepachangelog.com y/(n): y

Changelog enabled in config
Do you want to add rubocop as a dependency for gems you generate?
RuboCop is a static code analyzer that has out-of-the-box rules for many of the guidelines in the community style guide. For more information, see the RuboCop docs (https://docs.rubocop.org/en/stable/) and the Ruby Style Guides (https://github.com/rubocop-hq/ruby-style-guide). y/(n): y

RuboCop enabled in config
      create  my_first_gem/Gemfile
      create  my_first_gem/lib/my_first_gem.rb
      create  my_first_gem/lib/my_first_gem/version.rb
      create  my_first_gem/my_first_gem.gemspec
      create  my_first_gem/Rakefile
      create  my_first_gem/README.md
      create  my_first_gem/bin/console
      create  my_first_gem/bin/setup
      create  my_first_gem/.gitignore
      create  my_first_gem/.rspec
      create  my_first_gem/spec/spec_helper.rb
      create  my_first_gem/spec/my_first_gem_spec.rb
      create  my_first_gem/.github/workflows/main.yml
      create  my_first_gem/LICENSE.txt
      create  my_first_gem/CODE_OF_CONDUCT.md
      create  my_first_gem/CHANGELOG.md
      create  my_first_gem/.rubocop.yml
Initializing git repo in /home/ljimenez/my_first_gem
Gem 'my_first_gem' was successfully created. For more information on making a RubyGem visit https://bundler.io/guides/creating_gem.html
```
So, I decided to use rspec, rubocop, gitHub as a CI service... but you can change that later if you want

## Step 2: Configurate your GemSpec (<gem_name>.gemspec)

```ruby
$ cd my_first_gem/
```

The GemSpec is the definition of your Ruby gem
1. Definition
	name: name of the gem
	version
	authors and emails
	summary and description
	homepage: page where you can find the documentation of your gem
	license
2. Map all relevant files and assets
	files
	executables: everything that you have in the folder /bin 
	test_files: everything that you have in the folder /test or /rspec 
	require_paths: by default ["lib"]. Bundler is going to search the gem code in the folder /lib
3. List all gem dependencies
	Runtime dependencies: list of gems that your gem require to run
	Development dependencies: list of gems that your gem requires during the development

In my case: 

```ruby
Gem::Specification.new do |spec|
  spec.name          = "my_first_gem"
  spec.version       = MyFirstGem::VERSION
  spec.authors       = ["My name"]
  spec.email         = ["My email"]
  spec.summary       = "My first gem"
  spec.description   = "My first gem"
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")
  
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
```

## Step 3: List tasks

```ruby
$ rake --tasks
```

```ruby
rake build                 # Build my_first_gem-0.1.0.gem into the pkg directory
rake clean                 # Remove any temporary products
rake clobber               # Remove any generated files
rake install               # Build and install my_first_gem-0.1.0.gem into system gems
rake install:local         # Build and install my_first_gem-0.1.0.gem into system gems without network access
rake release[remote]       # Create tag v0.1.0 and build and push my_first_gem-0.1.0.gem to rubygems.org
rake rubocop               # Run RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
```

## Step 4: Add your gem code

In my case, I am going to add the code inside lib/my_first_gem.rb

```ruby
module MyFirstGem
  class Error < StandardError; end

  def self.say_hi
    "Hello world"
  end
end
```

## Step 5: Add your specs

In my case, I am going to add the specs inside spec/my_first_gem_spec.rb

```ruby
RSpec.describe MyFirstGem do
  it "has a version number" do
    expect(MyFirstGem::VERSION).not_to be nil
  end

  describe ".say_hi" do
    it "shows the message hello world" do
      greeting = described_class.say_hi
      message = "Hello world"
      expect(greeting).to eq(message)
    end
  end
end
```

```ruby
$ rake spec
```

## Step 5: rake build and rake install

You can execute:

```ruby
$ rake build
```

And then execute:

```ruby
$ rake install
```

## Installation

At this point we have the gem locally. You have some options:

1. Does rake release to push your gem to rubygems.org. After that, if you want to use your gem in other application:
    
    Add this line to your application's Gemfile:

    ```ruby
    gem 'my_first_gem'
    ```

2. Create a private or public repository, that depends in what you want to do with your gem. After that, if you want to use your gem in other application:
    
    Add this line to your application's Gemfile:

    ```ruby
    gem 'my_first_gem', path: <repository_path>
    ```

3. Works locally with your gem while you decide what you are going to do. If you want to use your gem in other application:

    Add this line to your application's Gemfile:

    ```ruby
    gem 'my_first_gem', path: <local_path>
    ```

4. Then execute:

```ruby
$ bundle install
```

Or install it yourself as:

```ruby
$ gem install my_first_gem
```

## Usage

In my case I only created a class method in my gem

```ruby
MyFirstGem.say_hi
```

