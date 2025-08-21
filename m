Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDB2DA76C
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793127; cv=none; b=VpVEF4mPaUFdwAPz5zi42Yd9lZ2zCR771TvH9YorhfEfDCvx3Ur1Lp1CuoazJOhRrwPEVykkK+42PKqED+vxLZHvTewE2byZ6zc7kpWu/D9qnY1Yv+KIuw8kcV9Z1HyHMBQSu7PoF9oy9MlPbE4yQZhX1bPh4JG1w15tFGOWABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793127; c=relaxed/simple;
	bh=KW7X69odbBm9aUyUm5Gna2h9dVBp3wBzBKo+AhbDR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7KHTEyROBols5THC0yuWFy1FIiZN79xK0gtiE9ZnjiWiUlEO2DMZf79WWUGIpy3tzfshWYwcFXqM2g/1Gw6xXJRIGrRoceYMo2n74EXbz7tal4cU9TgGSi9QNSJVNu31EoFfQI+5Dzuxa0Jz24HPQyvP+7sLtDHXuweiRISvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPV43oBO; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPV43oBO"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61c13125538so306776eaf.2
        for <damon@lists.linux.dev>; Thu, 21 Aug 2025 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793124; x=1756397924; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/kgWz84JgBVeLVTDbEVdswXhuU3eGT9Q6c09Y/7GpI=;
        b=JPV43oBOR6IOHBcm+wtfmyJeOpRxPToJkZi7liZWLCO5AFKMj7epWKEvdZ3k+kc1NU
         Hw2p4qfi+ijeQcdJJougPThkmf0KsKy/ZRfsCSd5XyuVG6A0acG63zZg9w7lxK3mrEke
         tmQvwUuJb+HwU5Q0kcz6A+UWq9e3jggPgnYtzVHYp5JlvnJAA8LapYBoRjobX2F9LJr5
         DePEoPe0NVhfxLznaCkTcmjczkRKg2sPCTdx2HLF05zzWhs2f6sDES43GJx2N8O36RQ8
         EIn2qa++wSB+AJ3BUGjFlZSKpMc1Gsu//xi9Jho3OEfeKdqbYsHdm9N9W2sOsYSMFDXI
         JK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793124; x=1756397924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/kgWz84JgBVeLVTDbEVdswXhuU3eGT9Q6c09Y/7GpI=;
        b=GII+yS7+GmWuJFL7XFRLjglVmplIDqHt2Is7d/zxJHkL1eOniQoZX3V5RqvCAZcGBk
         St8XzLzdn1Bk/eiHqf2UVJCUC7DD1gLZ13u5jwFp5e0rrgPJRSyyA/j8EgOu6KC3fWW6
         uNmq6Qdpex1c0sUIzsAd7SdTS2BgLsiwbhSRx4yDt58b6bbpvXmMc024E+Mew5fL5dxr
         +ZIVe0i0mnpNYR2XJ0RFwnPy4UkC7mkvwQIoPk8g3xIS4esatvlaRtO/p5WKgoV5tG3/
         AoYGP3oxghbSvf1OACnL0iuvxR4lkml0rGBqdEL0CnKslGnMbfLcdkrftNqqD2iy186Q
         ox9g==
X-Forwarded-Encrypted: i=1; AJvYcCWAsMA1xf87h7YvLuPQHyIM0LIjeZqOla2uD3nzXbu2m5HvLDSiBqe7FAkLeP8KA5v2n5duoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy80ZQG4WZrErKSe4SO9CIHeLmS2iP0HVxfpw5Od/Tzhgt5wDid
	gL33Ac/utVcVE8Zw0ELpegAT8BDFEwGTWQ4ZC9JqFvw4ibuGsEhG20LcuoLqtlGasQzkAEUhzE5
	SVLw9dwrxFThnefzlOXTpBuOY1+g/mzw=
X-Gm-Gg: ASbGncsNQRNX7hldRflpSzW6vo+SliRdAlnaeAOy590MooWud+cqubciWwRjJ2mAxvY
	cJdAx/MSPo9VO6iXWAE/UejqdmzkAScXFmvxGz16t86GnQzAKGA3MwtzfSOQhj5JvZymzPsMobq
	Zujqe7fXwpEgXpyNWJF9n0duxnLHeMHmN4k7z9Ah0li+xZPckEb5pU8zH8MuKPaVIhtxJooZoC8
	iku
X-Google-Smtp-Source: AGHT+IGxmLuafPwAwDkyNnqlueog5FlfgG/j27pU5nhQ2cB04Y8TJM9Suwdckz/XzevG80YdbjM0/bKtFAjNu506HBg=
X-Received: by 2002:a05:6820:1c99:b0:61c:4fa:7465 with SMTP id
 006d021491bc7-61dab06512emr1351756eaf.0.1755793124399; Thu, 21 Aug 2025
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABFDxMHgOPt5zx3q=KRxGGfp86R4V0AgO+FrHDftqLYoG20BWw@mail.gmail.com>
 <20250821155833.57597-1-sj@kernel.org>
In-Reply-To: <20250821155833.57597-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 22 Aug 2025 01:18:32 +0900
X-Gm-Features: Ac12FXzi3h9xpcGpuOkzdRydRGIYtRmhUHBmyrmZ9RELoX71HPL9qduVXxKXs_E
Message-ID: <CABFDxMFy18rb3K0NYYKifsBVD8MoA=O5Aj=g+KS5gR1R9GCEdQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:58=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Thu, 21 Aug 2025 20:06:58 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > On Thu, Aug 21, 2025 at 2:41=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> [...]
> > > Let's restart.  Could you please rewrite the commit log for this patc=
h and send
> > > the draft as a reply to this?
> > >
> > > We can further discuss on the new draft if it has more things to impr=
ove.  And
> > > once the discussion is finalized, you can post v4 of this patch with =
the
> > > updated commit message.
> >
> > Good Idea. This is the draft for commit message. Also, Thank you for
> > your patience and understanding.
>
> Thank you for accepting my humble suggestion.
>
> >
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> > /*
> >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> >  * so jiffies wrap bugs show up earlier.
> >  */
> >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > And jiffies comparison help functions cast unsigned value to signed to
> > cover wraparound
> >
> >  #define time_after_eq(a,b) \
> >   (typecheck(unsigned long, a) && \
> >   typecheck(unsigned long, b) && \
> >   ((long)((a) - (b)) >=3D 0))
> >
> > When quota->charged_from is initialized to 0, time_after_eq() can incor=
rectly
> > return FALSE even after reset_interval has elapsed. This occurs when
> > (jiffies - reset_interval) produces a value with MSB=3D1, which is inte=
rpreted
> > as negative in signed arithmetic.
> >
> > This issue primarily affects 32-bit systems because:
> > On 64-bit systems: MSB=3D1 values occur after ~292 million years from b=
oot
> > (assuming HZ=3D1000), almost impossible.
> >
> > On 32-bit systems: MSB=3D1 values occur during the first 5 minutes afte=
r boot,
> > and the second half of every jiffies wraparound cycle, starting from da=
y 25
> > (assuming HZ=3D1000)
> >
> > When above unexpected FALSE return from time_after_eq() occurs, the
> > charging window will not reset. The user impact depends on esz value
> > at that time.
> >
> > If esz is 0, scheme ignores configured quotas and runs without any
> > limits.
> >
> > If esz is not 0, scheme stops working once the quota is exhausted. It
> > remains until the charging window finally resets.
> >
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is considered as the first charge window. By this change, we can avo=
id
> > unexpected FALSE return from time_after_eq()
>
> This new draft looks good to me.  I find nothing to further modify.  Coul=
d you
> please send v3 of this patch with the above commit log?

I'm really glad to hear that! Your thoughtful comments really brought
this together.

>
> Thanks,
> SJ
>
> [...]

Best Regards
Sang-Heon Jeon
