# tableViewTest
- **Project**
Fetching Data Through API and Asyschronous representation of the Data that is downloaded

- **Installation & Run**
Xcode application is installed in MacBook device.  A *Single view app* is made in project mode. Suitable *StoryBoard* and *Cocoa Touch Classes* are made.

- **Description** 
 The URL for API is given below
***url:-***  [https://jsonplaceholder.typicode.com/photosimage](https://jsonplaceholder.typicode.com/photosimage)

A tabular view is made which load 10 content at a time and further next 10 as the view hit the last row.
 Each and every row contains -
 1. **Thumbnail**
 2. **Title**
 3. **Discription,if any**

The Project implements lazy loading as the image in the thumbnail view loads only when the row hits the view.

Upon clicking a selected row of the table , next view gets loaded which has detail description of the JSON api data. These are

 1. **Image**
 2. **AlbumId**
 3. **Id**
 4. **Title**

A back button is put as a part of the navigation controller. This can be done by embedding in the *Navigation Controller*.



- **Pull**

  Welcome to all *Pull* request.

**

- **Author**
 Nishit Mishra
