Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188374420
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005233; cv=none; b=Ri1AOLzMWXH2QBiyD+RDhiK5v6Wr0VK6ERBvR/tpTJjZw3GB5QEsowmu0hmEj5lpYPlxcdAeW6eRQpc/AWq8nAUCGbubO1duUJX6DyubLdoPhBi4SDjd7oct2GW93/tiEpktubZ6EMiLgUdIZ3WAOn0qhxk5zrI7ILxfivZmSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005233; c=relaxed/simple;
	bh=ie/kJJDkTzro9jVYrFcfQsbZ3JqTIJO1trf4qDlhrdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3N3csjOChhEv/IHHLGG8uh4T/wPn56qj7YKSSuTBg/HCbZl1wT2LOv6zI7u71A3mgF5Q/I8i9i95VNWa7QgfazSh8HwPnuhkeSuQ6c6evGWCrSJXz9QcWUebTpMkVXk+PmZlERmIJCt+tgqWWJ4OMvYK/k3W1ZCbtwq/JHP3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JytO1ZKc; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JytO1ZKc"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eb6c422828so4397518fac.1
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755005231; x=1755610031; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RREPB+k7a/mceQdaxCB2njGP8WW7v6Nzrb7ci/2EA8A=;
        b=JytO1ZKcLtZMMVDKc/BZb0e8IcwZjYGALjIA9Dz6mrFDPmtYQ05MmeObEDc4Vl3D2G
         g1PB4gxYhAD3xoc3/f2c/SG4QpL1towQQBT/8zJT3eNPEWItHS0eUuF6hGoQpbqIH5tM
         HoIlB3PI52AwVeWC88hOkURzaN5nSJXQpMVbdTzdl/ozX/hkzZW9bnhIV3d+REmXEPNr
         HqMwQnmF8f3JYLpaoTKdFXUdvvIWkEXl6iyUpfOJdKMCcmh0y1grdLN0BjTcq+6P827I
         caQKqzDaLO5Na/p1uWbhInpOaxrbc6s0eMuFkntVHyvnUJMCwBDzrYwu5LKsY2jLYgFi
         wL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005231; x=1755610031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RREPB+k7a/mceQdaxCB2njGP8WW7v6Nzrb7ci/2EA8A=;
        b=MZnDI/B0+9SQe2+kgcLsEfGxYP7MWgXCyojdp2cxaNCbFi3nUi7+viXTkb/AB8XeSc
         riY38iFYQOKOJ+5fNdOmaRlpVnrsoXOuFMb9o13j7UMC94nHbouUN2z+kjFiee9I78Gs
         ejJRYdeLG9GwMIDCtWRL4LBfFEQ4E+WjApz/gWAYqXnt9cG22yCBR/1eM4/tYr7y0KQ/
         oicEe1GXIMyTH5Hu4HImYeeuX1CfzXbri1qAIHew9YTDMWVAe9NX6j9ZdXHouCIBUccq
         nWBIMBaz+f0PcRXTPbpkDHe8jT434LycFM4jgTkjtvn9O8wXqjFDqN0WRMYhMeFLG7cS
         hFxw==
X-Forwarded-Encrypted: i=1; AJvYcCVFyWOv9FsG1ha8kvBmojruPIjo40dxbfCt4/Sr2x5OchaaQkNWPF06tBlFQ33X40z8MUDZwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhvCcP2MxBkvNbNGR3Uy6B2dikASg/OzuUaH0bcGFNAlAxyT2u
	bcSBb2M0pg37qgv1MGMN0mOQENea5r1n0ZRbykiCpdbL87/cIvjVJM0O3ewR2Z1JQ+R/foscmWq
	ws+m1NPDn2xnapQyb8dt8UiR/klhc568DCthhfwg=
X-Gm-Gg: ASbGncshXG4CGZTYR66t2ai8PhO4K3Ays8bK+Mlcw1AovpcOFu+sMl+x/5OqDjUmOdu
	JU0ITtAcigk+lL5VCdcaSARJMrXLNhDsf82DraaX108V3w8114jw5rku1srR4nNKW77zGpFtRUc
	rDcWFKPSxHtVLUX7MXDrOoVBvfqh5T3k7+oSKI7/AKIMbTzvX05qjDv4e6Pk1S+ZQfSIrb/RZeG
	VRR
X-Google-Smtp-Source: AGHT+IGpbMz1DdsWZ1z4GCKL7utzJO8TIQxtkA8SafJyjmZ6lfFuwcFQBFZL2gHHQv89lc/KdDVrhAdvffGsU9WPpY8=
X-Received: by 2002:a05:6871:6718:b0:2e9:925b:206f with SMTP id
 586e51a60fabf-30c94f3cf74mr1607259fac.17.1755005231005; Tue, 12 Aug 2025
 06:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com> <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
In-Reply-To: <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 12 Aug 2025 22:27:00 +0900
X-Gm-Features: Ac12FXxoAocnTTpz6traLMo0gPyYiDuR8cKin4JSoMSWQ6SUh-o9iDKVTOiC780
Message-ID: <CABFDxMEQYx7fdx4T7meUb01FoqJaHcW_2RoYnBwJ8GzmJTexzQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Alexandre

On Tue, Aug 12, 2025 at 9:32=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Hello, Alexandre
>
> On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > _common.sh was recently introduced but is not installed and then
> > triggers an error when trying to run the damon selftests:
> >
> > selftests: damon: sysfs.sh
> > ./sysfs.sh: line 4: _common.sh: No such file or directory
> >
> > Install this file to avoid this error.
>
> I tried to reproduce those error with my vm environment but I failed;
> with my workaround test method, it doesn't exist.
> If you're okay, could you please tell me line by line how you execute
> tests in what environment?
> I'm also struggling with the test environment, as well.

I succeeded to reproduce and also check that this patch removes those error=
s.

> > Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host sha=
red function")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---

Tested-by: Sang-Heon Jeon <ekffu200098@gmail.com>

> >  tools/testing/selftests/damon/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/sel=
ftests/damon/Makefile
> > index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a0=
8f2ad008e6b28ac87 100644
> > --- a/tools/testing/selftests/damon/Makefile
> > +++ b/tools/testing/selftests/damon/Makefile
> > @@ -4,6 +4,7 @@
> >  TEST_GEN_FILES +=3D access_memory access_memory_even
> >
> >  TEST_FILES =3D _damon_sysfs.py
> > +TEST_FILES +=3D _common.sh
> >
> >  # functionality tests
> >  TEST_PROGS +=3D sysfs.sh
> >
> > ---
> > base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
>
> Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
> the same base-commit environment.

However, I'm still not sure that this patch is in the correct
baseline. maybe it will not cause any problems with the merge
though... but I'm not sure. So I didn't add a reviewed-by tag.

> > change-id: 20250812-alex-fixes_manual-aed3ef75dd83
> >
> > Best regards,
> > --
> > Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> >
>
> Thank you for great work!
>
> Best Regards.
> Sang-Heon Jeon

Best Regards.
Sang-Heon Jeon
