<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

This project is about tracking the PSE's Puppet Forge modules, number of downloads, release, and any other relevant information that assists the team in identifying productivity to the wider community.  The data should be presented as a dashboard in a webrowse, and statistic retrieved from https://forge.puppet.com using code written in the Ruby langauage.

Smashing has been selected to present the data, it is a Sinatra based framework provides a plaform to build beautiful dashboards. It comes with predefined widgets, API calls can be used to push data to your dashboards, widgets can be fully customized or just create your own from scratch.

### Built With

The following applications are used to buuld the framework:

* [smashing](https://smashing.github.io/)
* [puppet-forge](https://rubygems.org/gems/puppet_forge)

_For more examples, please refer to the [Documentation](https://github.com/Smashing/smashing/wiki)_

<!-- GETTING STARTED -->
## Getting Started

To get the project up and running simply clone this repository, it can be run locally or on a server.  The application will start on port http://localhost:3030, an internet connection is required to make API calls from the application to the Puppet Forge.

The repository has all dependencies and gem included.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
2. Install Ruby packages
   ```sh
   bundle install
   ```
3. Start the application
   ```sh
   bundle exec smashing start
   ```

Connect to the dashboard from your webrowser.

<!-- USAGE EXAMPLES -->
## Usage

The project is based on writing code in Ruby, 

It is important to understand and how to manipulate the data passed to the application by understand the Puppet Forge GEM and the Puppet Forge API.

_For further details, please refer to the [Documentation](https://forgeapi.puppet.com)_

_and for information making API calls refer to the [Documentation](https://github.com/puppetlabs/forge-ruby#puppet-forge)_

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://trello.com/b/ri9PuQXn/pse-okr-dashboard-forge) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)
