import 'package:flutter/material.dart';

class VendorFilterWidget extends StatelessWidget {
  const VendorFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
              onPressed: () {},
              elevation: 3,
              backgroundColor: Colors.black54,
              label: const Text(
                'All vendors',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            ActionChip(
              onPressed: () {},
              elevation: 3,
              backgroundColor: Colors.black54,
              label: const Text(
                'Active',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            ActionChip(
              onPressed: () {},
              elevation: 3,
              backgroundColor: Colors.black54,
              label: const Text(
                'InActive',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            ActionChip(
              onPressed: () {},
              elevation: 3,
              backgroundColor: Colors.black54,
              label: const Text(
                'Top Picked',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            ActionChip(
              onPressed: () {},
              elevation: 3,
              backgroundColor: Colors.black54,
              label: const Text(
                'Top Rated',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
