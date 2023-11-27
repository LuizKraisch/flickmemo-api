# Monitoring

For Flickmemo's events and bugs monitoring it's being used New Relic and Bugsnag.

### Busgnag

Bugsnag works fine with Ruby on Rails-based applications and also has some interesting features related to app performance.

![Screenshot 2023-11-27 at 5 54 34 PM](https://github.com/LuizKraisch/flickmemo-api/assets/54246850/65440a58-4a45-44ef-a507-925f5ec18010)
Bugnsag error page screenshot.

### New Relic

New Relic is also used as an alternative for Bugsnag since the free tier available limits the issues filters by 7 days. New Relic has more
options for that and also offers more solutions for performance and logs.

It's also one of the best options available in the market.

![Screenshot 2023-11-27 at 5 54 45 PM](https://github.com/LuizKraisch/flickmemo-api/assets/54246850/86bc5e9c-93ad-4c34-8a40-3f4b60199f90)
New Relic dashboard page screenshot.

### Code coverage

Code coverage is defined using Simplecov. When running `rspec` in your machine, an HTML can be accessed to see the results:

![Screenshot 2023-11-27 at 8 27 32 PM](https://github.com/LuizKraisch/flickmemo-api/assets/54246850/02b0b850-85cb-4c9d-81af-2a3a9af20b44)
Simplecov results screenshot.
