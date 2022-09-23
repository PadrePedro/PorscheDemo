# PorscheDemo
Porsche Demo

This app fetches images from the Unsplash phot API and displays them in a collection view.  The collection view contains a search filter which
allows the results to narrowed down.  The collection view uses diffable data sources to animate any changes to the collection view data.

Tapping an image in the collection view displays the image and associated meta data in fullscreen mode.  Meta data displayed includes photo
description, image size, photographer name, location and image. Tapping on the image will launch into the photographer's website,
if defined. Tapping on Share button shares the currently displayed image.

The app is designed using MVVM architecture, using LiveData as the conduit to report any data changes back to any listeners. PhotosViewController
communicates with PhotosViewModel to retrieve photo data.  Note that PhotosViewModel holds onto a DataService object that is set through
dependency injection. This allows different implementations of the DataService to be used for testing purposes. Included in this project are
UnsplashDataService (uses Unsplash REST API) and MockDataServices (locally defined mock responses).

Unit tests included test UnsplashDataService, MockDataService and PhotosViewModel.

PhotosViewController and PhotoDetailViewController are constructed with programmatic constraints (no usage of Storyboard, per design requirements).

No 3rd party libraries were used in this app.
