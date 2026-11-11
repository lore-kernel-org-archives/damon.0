Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794402871;
	b=DuwKVSVYxdzcB6M6X+ue4R2Ejukn+CkIZAdEcKwefEiz1ZqaDJ6ccpz4KC2Qlf3T4Ulh
	 ZAs8TFI+1G+zyUf76RVZMrdlWX6nW78iULlVbmpRbw6ZjrxDubO+kV9i8OTakxN0tsWdk
	 ennDtx3FAO0nTaDh/G5LtA2B6aM2RatXXH0OaZgTqS5jlKOpvBKBvWfP3B0lNV9Aqcu4O
	 jKyWMRycYEF/mLZIwRMNXpEY6p7Tv8CdBpl2i6M/q+5oj7fXT7uIC+kk07CGh1+JXCqCy
	 EVqL9o8e11a+b5AjGDO4m3KOkxb9rR3sJtkQsh91TYVxK9NeiChsmvXyiyW3t8p4HOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g/0oI6uv/H1EEuDN9a5C5Hh0fYM+cFB/bWC6crw40RE=;
	b=5omWFuBkg4xrxWxS9n96oySc/TGx8FMFGYFMU3UImt5u0ZFCx/NK6zKbilr10by7gCd9
	 K6pPnzGSA8BuP3r4ykJGEySDHXKekvcBQgkvWzJza4l4I2S7Un58EPI7dON4iUE1bNF6c
	 0DdgTPr5nJXZ4ek3SmdCdQaOUFHPDnzsZbQenXCKfyPZsZSIdyTHHPRh31vq29f3gfgR2
	 g1IYv8DcXutQAihHgQdOq0wdT03hQwmoQDjmbGmW0gq/e7v2f/+CrU/zMjg+KCCyfmsD6
	 E+V9iG+8+ntgAUbNgsMg895KRMlMyG0rsjK+cFvYsxu3OQ7fybY/Y225HIXstNKhDxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7dXi4c6;
	arc=fail smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C0606A321
	for <damon@lists.linux.dev>; Wed, 11 Nov 2026 13:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7dXi4c6
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso20312955ad.1
        for <damon@lists.linux.dev>; Wed, 11 Nov 2026 05:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794402870; cv=none;
        d=google.com; s=arc-20260327;
        b=nmPSnFjoHDpnRs0YP3wVlufyKM3xijIEZ1841VZvz30dBbtmr+F+otStOQ3FX/ljxO
         pjXm8aNMQcTHZMmbRh1TVWP1vugaKsJOPPd2Jp+KXCLY07xXkOmAGlLXYnfX9Ucgz63x
         abEImXa0HMW+7BWLiJBrvmfDk0DGUl+moCqsCFPPyYNXHEtWIGBVv9fz52BgsJJ6dSjJ
         B0emt2yXDPlBW2DFB6uYjFxnQcVGYT4s7OW0uxCGDxSqq80EwXfFeUNfIG81Y6txaW/z
         G1i5njrVlFepO0u+v5Lef8hLReeI4RgcnNmSsNqK9N4WwJjX6C/Ak1YEBmcqLZoAVisB
         MJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g/0oI6uv/H1EEuDN9a5C5Hh0fYM+cFB/bWC6crw40RE=;
        fh=wYZYJnAcw6+HVN/P2kSdXfJsdE6FgNo8MAB+3lqWGt0=;
        b=fg1RHadp3GvMIBHTQYyNs+G83m8rl9yBiNXbtHhf7JeX56a81fJbxuNNIrw6JHVzuv
         4evU6W61HhafBh1DwYbuiVcsAosdWGILCQ4CPG4cZGyYvLbDIHovIvSTcGHLuGMc7XuQ
         nY38eRmiQaG4uxMVq/6WQpI6dQHtr42OUPu/m7YDkrdV6FWHcbFVhLxqXpw74Y/uvLTC
         9VrDrDcjQYGKweMVxON+Ir6hcZ32piUKToJLQmlD8KAP/10h2r1Q1/wiSUsqt/oYDfxG
         oklUBuRJvXMLyIi5M+ho+eN7Y9VL7FlsHUGQArdqSwzxFuLeZ9cbscseyTcDFagxGtA4
         OGVQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794402870; x=1795007670; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/0oI6uv/H1EEuDN9a5C5Hh0fYM+cFB/bWC6crw40RE=;
        b=z7dXi4c6TiONnNgCIL5b31hXPYGYdjAuD0HH7gJIlnKhljgNpiTbnEMhyh/+V9vbOd
         OPB26kVmcDCVaS+tcLXvUi+LT+2NZwwhKKPVb/wyNO7ZgM0BZa0LUvsFY8WHW64dAos0
         /kAjpRO1IeBVtUjEtHhpjdEty/kRbeWEDZq80w5aYte9UIz68zFuJFnShUV8pK71JqNj
         hd8aJ5Y3eD+2zcBfDIPji5aMl+sW6ldQ6zjnzuI0+57o4eXGQtIziGi7Akevjs8VZxmS
         N0bu0HwD0+POA2JuPQphXa34k+gsg9Me1Vxq8j1HkfkPY9oYJV59Qv77D8C9llh5gtMh
         S2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402870; x=1795007670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/0oI6uv/H1EEuDN9a5C5Hh0fYM+cFB/bWC6crw40RE=;
        b=Np7nMRxu3MahdkH4iIA8WtN6w6d2PTjqsw8KDzusOb7CuGklAz8xbFJbKvB3apUNBc
         5IWdHsWyFtg1w0CwHI9RV5kxYz3+K4tZKws5kIS7/ukppFa6g9uvnpzanBuXDTIE8uyM
         ofnZySaNxURwfYifyJn59171NIZttPRJ7ZvFStOqb9oByJRMpg8vgbeuhlYIF7cb+I4z
         sMKTshfijMDV0omX5uqa6JdY4B3iMa0JIeDT56wBK7Y0AJ/9yoZjGf0NGMmOXvJwfR6d
         4UJ6GoM1q+MnCG4NfwLfIgizuc11GVgnU/HMLda0dllvCVuvtFmU38QrNigGCVdXj7Jr
         aS5Q==
X-Forwarded-Encrypted: i=1; AL+hErEkXDrYz0XfN57fzi9QyZ8XVtjz1j7peEMP5H5pRHQWAYGev9NBcZfW6QQ2NDWJQKek7ujfag==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eD+L6vIibRdzz2fmt7okJKAs8yqyQCQJ1zym6Gtl644M8DCuL
	pjUmV3nrqpMV18spz/L7pTWf7Yd+Ogv4P55GXL7FSxNOlCgMdXIhcMl+ekOq1tdA0pBD4D+6kON
	z9EPO/zqjRjyWKMlknwj5VWoL4BktPzY=
X-Gm-Gg: AYBFou1raBzojxZx6oMqr5AGjhe1Wqd9sehytvS2G0kc9iXe6Xs26l3Gid4LabINhkt
	gFeoSqPgbtT5jUs5PBoDs/ctsfK+yrf8qplsQd7ITmp+hmiMFunD1oSEm1aXAahV8ZQzKhAK411
	y0etAD0/cWzUxRzKjT91RV/4OD05NTYMt1yOSi86f+1v3kk9bkchV6GMzSaTW+SE5vj1B3i/ee7
	EsAv57Z0vqSAYISykJWd8D3U8/FwBLiu84XaZzJGMhRUKgUPViL7LTBf4AtMNX8Vl+A6DrqZvdX
	WRvFenPepSlz5qXX/Hf1P1vkiJxDYpQwxzzaok72GuBuHSa41+zzVnJUggSkxHOt28bRBMDNHZ5
	eeKkbQW7dLu0L+IuwTyYIKnKWWvbpqHquBn4zoQsOl4nJ55GdZPUFzIwu/THpfioB
X-Received: by 2002:a17:903:2442:b0:2ed:45eb:51d2 with SMTP id
 d9443c01a7336-2edd7a9888dmr27729925ad.47.1794402870030; Wed, 11 Nov 2026
 05:14:30 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110085132.1023-1-adrianhuang0701@gmail.com> <20261110153907.158338-1-sj@kernel.org>
In-Reply-To: <20261110153907.158338-1-sj@kernel.org>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Wed, 11 Nov 2026 21:14:18 +0800
X-Gm-Features: AclHuK_JPlTrjZpaZjohmplxPFoK1WduWQbas8gb3wbIHqUrtWb9Qa3r2Biv8pg
Message-ID: <CAHKZfL3+i_Sq+zgA76O0gqj1nP8x_FKJR8SRa0oz-5N4LrduFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/damon/core: simplify minimum watermark wait time calculation
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,

On Tue, Nov 10, 2026 at 11:39=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> Hello Adrian,
>
> On Tue, 10 Nov 2026 16:51:32 +0800 "Adrian Huang (Lenovo)" <adrianhuang07=
01@gmail.com> wrote:
>
> > The minimum watermark wait time calculation uses an additional boolean
> > variable, init_wait_time, to determine whether min_wait_time has been
> > initialized.
> >
> > Simplify the logic by using list_is_first() to identify the first
> > scheme and initialize min_wait_time accordingly. Subsequent schemes
> > update min_wait_time only when their waiting intervals are shorter.
> >
> > This removes the unnecessary boolean variable while preserving the
> > existing behavior, including the case where no schemes are configured.
> >
> > Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> > ---
> >  mm/damon/core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d36823f4d092..93ec684a113c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3985,14 +3985,12 @@ static int kdamond_wait_activation(struct damon=
_ctx *ctx)
> >
> >       while (!kdamond_need_stop(ctx)) {
> >               unsigned long min_wait_time =3D 0;
> > -             bool init_wait_time =3D false;
> >
> >               damon_for_each_scheme(s, ctx) {
> >                       wait_time =3D damos_wmark_wait_us(s);
> > -                     if (!init_wait_time || wait_time < min_wait_time)=
 {
> > -                             init_wait_time =3D true;
> > +                     if (list_is_first(&s->list, &ctx->schemes) ||
> > +                         wait_time < min_wait_time)
> >                               min_wait_time =3D wait_time;
> > -                     }
>
> I implemented and used list handling wrappers like damon_for_each_scheme(=
), to
> hide implementation details of data structures.  This change exposes some=
 of
> such details.  If we agree we have to remove init_wait_time, I'd prefer a=
dding
> a sort of damon_first_scheme() like wrapper.

Ah, sorry. I didn't realize you intentionally hid the implementation
details. That makes sense.

> But, init_wait_time really need to be removed?  I cannot show clear benef=
it of
> removing it that justifies adding a new wrapper.  To someone or on some
> evironments, init_wait_time might making the code too difficult to read o=
r
> inefficient (system having so small amount of memory?), though.  If not, =
I'd
> suggest dropping this.
>
> What do you think, Adrian?

I agree with your point. Let's drop this patch. Thanks for the quick
feedback anyway. ;-)

-- Adrian
