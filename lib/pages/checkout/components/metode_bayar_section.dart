import 'package:flutter/material.dart';
import '../../../models/pembayaran_model.dart';

class MetodeBayarSection extends StatelessWidget {
  final List<PembayaranModel> listPembayaran;
  final int activeIndex;
  final Function(int index) onChange;

  const MetodeBayarSection({
    super.key,
    required this.listPembayaran,
    required this.activeIndex,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text("Metode Pembayaran"),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listPembayaran.length,
          itemBuilder: (context, index) {
            final pembayaran = listPembayaran[index];
            return Row(
              children: [
                Checkbox(
                  value: activeIndex == index,
                  onChanged: (value) => onChange(index),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => onChange(index),
                    child: Row(
                      children: [
                        Image.asset(
                          pembayaran.gambar,
                          height: 30,
                          width: 80,
                        ),
                        Text(pembayaran.text),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
