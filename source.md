Problem
Working out an optimized source solution is not trivial, but once it is complete how do you reproduce it and consistently apply it to the rest of your dataset?

The following guide demonstrates the use of a comprehensive function to transform scalp level EEG recordings into source localized data sets that contain current source density timeseries for atlas nodes.


The function uses several open source tool kits to accomplish this. The primary goal of this function is to create a consistent and reproducible method that can be parameterized and has rich visualization to catch any errors.


There is no perfect method of source localization, nor is one method applicable to every type of analysis. So we will work on describing the parameters for this tutorial. Depending on your needs any of these parameters can be adjusted.

Source data? The source data for this example will be continuous recordings of resting state EEG collected using an EGI net amp 400 with 128 Geo tastic montage scalp Celine bass net the original data was sampled at 8000 Hz. Data was preprocessed prior to source analysis using published methods. This includes vaginal removal, continuous segment removal, channel interpolation, resampling to 500 Hz, and ICA based artifact removal.

We retain approximately 80 seconds of data to use for source localization.

Source localization target: for this tutorial we will be using a default head model, default electrode positions for the EGI net. For this tutorial we will be aiming to create a minimal norm estimate model. The underlying software for source localization will be brainstorm which allows the creation of other models and the script can be modified to accomplish this.

Output  format? We have found it most convenient to work in EEG lab SET format. Therefore once the source model is made we will create scouts the scouts will contain regions of interest and we will have the mean time series of current source density. The data will then be reconstructed into an EEG set file or identical to the original file in terms of length of signal, but will include 68 source localized node channels instead of the 129 scalp electro channels. The channel Atlas structure will contain the MNI coordinates of the Nobes centroid as well as the channel labels of the Deschene Killaney atlas.

Overview of process:

We will pick up this process using a pre-processed file. In upcoming weeks we will have a blog post that will demonstrate using our pipeline for artifact removal. However in this case you can find a free clean file at this link.

The first step to convert this file is to import the data into brainstorm and create a head model. We accomplish this entirely using scripting. However there are several dependencies to make all of this work appropriately in a single step and be able to use this function in a batch format.

Brainstorm can import SCT files directly, however these files must be continuous recordings. Second even though Brian and storm can import these files, there is some housekeeping that Hass to be done including confirming the correct channel montage and head layout. We create a graphic with the final image of the electrodes on the scalp to confirm our position location is correct.

With different updates to brainstorm, there may be some changes, so it’s best to verify the code step-by-step if you are putting together a new workflow.

If you were working through the graphical user interface brainstorm will have to re-calculate head models for each subject, but as noted in the brainstorm forums, we can copy our head model to multiple subjects since in this case the head model which is composed of the default MRI and the electrode positions) will be common for each subject. Discreetly speeds up the process when using multiple subjects


However, this original file should be a specific generation of a specific MRI and nettight. Therefore if you’re using for example a brain vision 129 channel net, it will not be compatible with 129 EGI version that we have in this tutorial. By examining the code you can see it is a relatively straightforward process to include your own head model based on your specific system, and even include individual head models for subjects who have individual MRIs and or electrode measurements on their scalp. For many of our high-volume studies we do not have individual MRIs, so the default model is what this tutorial is based on.

Once the source localization is complete, you will have a fully functioning representation of the source in the graphical user interface to investigate using brainstorm tools. However for our purposes we will be exporting the EEGSMT file as an output as our end goal. This SVT file can be used in various other command line functions to analyze. The closest equivalent to this would be something on along the lines of getting scout time series in brainstorm and then creating an e.g. set file around it.

In terms of scout regions, we are using one of the included atlas is that come with brainstorm that is relatively common and overlaps with some MRI atlases. However you can use a different atlas or you could also make custom ROIs based on manual positioning or brain activity and export that into a set file. Again the code should be fairly straightforward to make these type of changes

