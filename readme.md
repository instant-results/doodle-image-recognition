The .npy resources can be found at https://console.cloud.google.com/storage/browser/quickdraw_dataset/full/numpy_bitmap;tab=objects?prefix=&forceOnObjectsSortingFiltering=false 
To use the program, please put the resources into the `resources` folder in the application's main directory.
Up to 16 resource files can be read by the program.
The application checks available files and their names upon startup, if the file name has `full_numpy_bitmap_` prefix, the remaining part will be used by the application as the name of the contained class, otherwise the full file name will be interpreted that way.
User is supposed to start with loading the files in the `Data` tab, then creating and training a NN in the `Settings` tab. After that, the user can use the `Drawing` tab in order to test the NN.