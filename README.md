# DrawerViewController

When I first came to implement a drawer-like view controller, I thought I might write a complete container view controller like UITabBarViewController, but soon I realized that its hard to manage the childViewController’s life cycle. Later I got an idea, **why not just use UITabBarViewController, and just replace the default tabBar with a Drawer?**.

OK, this DrawerViewController provide a drawer for UITabBarViewController like this:

![demo.jpg](https://github.com/Josscii/DrawerViewController/blob/master/demo.gif)

# Usage

Cause the heart of DrawerViewController is just a subClass of UITabBarViewController, it’s really easy to use.

**Use it in StoryBoard**

Just set your tabBarController’ class to WYTabBarController, and  set the tabBarItem’s title and image of its view controllers, everything is ok.(behind will grab the title and image to set drawer item’s title and image)

**Use it in Code**

Just initialize WYTabBarController and pass in your view controllers, one more step is required:

set the items property in WYTabBarController, the items is an array with NSDictionary，the dictionary as follows:

 *  the first key is `title`, value is a string 
 *  the second key is `image`, value is a image

# TODO:

* add more drawer effect, like move to right.
* add user-customizable drawer, like add drawer header and sections.
