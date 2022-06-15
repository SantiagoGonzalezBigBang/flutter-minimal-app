import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    Key? key,
    this.size = 50.0,
    this.url = '', 
    this.isDialog = false
  }) : super(key: key);

  final double size;
  final String url;
  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xffE4F353),
          width: 1.0,          
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: !isDialog ? url != '' ? FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url,
          imageErrorBuilder: (context, object, stackTrace) {
            return FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: const AssetImage('assets/no_image.png')
            );
          },
        ) : FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: const AssetImage('assets/no_image.png')
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (url != '') FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: url,
              imageErrorBuilder: (context, object, stackTrace) {
                return Column(
                  children: [
                    FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage('assets/no_image.png')
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Upload image',
                      style: GoogleFonts.dmSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff080816).withOpacity(0.38)
                      ),
                    )
                  ]    
                );
              },
            ) else ...[
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const AssetImage('assets/no_image.png')
              ),
              const SizedBox(height: 10.0),
              Text(
                'Upload image',
                style: GoogleFonts.dmSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff080816).withOpacity(0.38)
                ),
              )
            ]           
          ],
        ),
      ),
    );
  }
}