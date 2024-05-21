import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildHeader(context),
            SizedBox(height: 35.h),
            _buildTermsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Text(
          'شروط الاستخدام',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
            height: 0.08,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_forward,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF2B2F4E),
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Divider(
            color: Color(0xFFEEEEEE),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          _longTermsText,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF2B2F4E),
            fontSize: 16.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  String get _longTermsText =>
      'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسماً ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن ...';
}
