## Rotten Tomatoes

This is a movies app displaying top box office movies using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: `10'

### Features

#### Required

- [YES] User can view a list of movies. Poster images load asynchronously.
- [YES] User can view movie details by tapping on a cell.
- [YES] User sees loading state while waiting for the API.
- [YES] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [YES] User can pull to refresh the movie list.

#### Optional

- [NO] All images fade in.
- [NO] For the larger poster, load the low-res first and switch to high-res when complete.
- [NO] All images should be cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [NO] Customize the highlight and selection effect of the cell.
- [NO] Customize the navigation bar.
- [NO] Add a tab bar for Box Office and DVD.
- [NO] Add a search bar: pretty simple implementation of searching against the existing table view data.

### Walkthrough
![Video Walkthrough - core features](http://imgur.com/s7rmoZf)
![Video Walkthrough - loading state](http://imgur.com/mClvxSn)
![Video Walkthrough - error state](http://imgur.com/3tHcErL)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)