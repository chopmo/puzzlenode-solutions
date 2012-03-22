# [[#6] Steganography 101](http://puzzlenode.com/puzzles/6-steganography-101)

_This puzzle was contributed by Gregory Brown and published on May 15, 2011_

Like most extraordinarily successful people, you know that the best way to find new and exciting opportunities is via late night television infomercials. For a while, you were busy making your millions on fool-proof real estate <strike>scams</strike> strategies, and couldn't take on new commitments. But tonight, as you lay on your bed of hard earned money, you are faced with an offer you can't refuse.

The world-famous University of Feenucks is offering an online master's program in <i>Spycraft and General Sneakiness</i>. To get your official recognition as an <i>International Programmer of Mystery</i> and all the accolades that come along with it, all you need to do is send in 300 weekly payments of $13.37 and take a simple test. Since money is not a concern for you, you decide to get started right away!

## Problem

Given a text file with a message in it and an ordinary bitmap image, hide the message within the image by making subtle modifications that would be very difficult to detect by someone who wasn't looking for them.

## Encoding instructions

You will need to learn a bit about Bitmaps in order to complete this task, and [wikipedia](http://en.wikipedia.org/wiki/BMP_file_format) is a good place to start. To avoid getting bogged down in the details, focus on just figuring out how to find the offset for which the image array begins in a file.

In bitmaps, the image array maps directly to the pixels that make up the image. In the particular image used for this test, it's safe to zero out the least significant bit of every byte in that array without making a noticeable difference to the visual appearance of the image.

Once you have done that, you can then do a simple conversion of an ASCII encoded text message into binary code. For example, since the ASCII value of `"H"` is `72` in decimal, its padded binary representation would be `01001000`. If we pad all the characters in a string such as "Hello World" to make sure they represent a full byte, and then join them together, we'd end up with the following binary data: 

0100100001100101011011000110110001101111001000000101011101101111011100100110110001100100

This data could then be mapped onto the image array by starting with the first byte of data and setting the least significant bit to the first bit in the binary string shown above. Then the second byte's LSB would be set to the second bit in the above string, and so on until the entire message was hidden in the image.

The end result of this process is shown in the <i>sample_output.bmp</i> file included in the files section below. You'll notice that visually it looks the same as <i>input.bmp</i>, but someone who knew that there was a message embedded could look at the LSB of each byte in its image array and process it to recover the "Hello World" message. You're encouraged to give this a try to verify that you understand the whole process.

You can also test that your encoder is working properly by generating a bitmap yourself using the "Hello World" message stored in the <i>sample_input.txt</i> file. If your encoder is working correctly, then the image produced by it should be identical to the <i>sample_output.bmp</i> file. This is easy to test by either taking a hash of the file's contents using something like SHA1, or by using the *nix `diff -b` command. <u>NOTE: Both the sample_input.txt and input.txt have a newline character at the end of the file that SHOULD be encoded into your output image. This detail was omitted from the above "Hello World" example for simplicity.</u>

## Submitting your results

The sample files are for helping you check your answers at home before you send them into University of Feenucks. However, please note that the real task is to embed the message found in the <i>input.txt</i> file into the <i>input.bmp</i> image file. Once you have done that, you can submit your encoded image to PuzzleNode. As a licensed testing center for the University of Feenucks, we promise not to take your work and pawn it off as our own, nor do we expect any payment for our role as middlemen. That having been said, we do not take responsibility if by applying to the <i>Spycraft and General Sneakiness</i> program, you end up living a life with far more mystery and intrigue than you are able to handle. So submit at your own risk!