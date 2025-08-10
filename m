Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169D2AEE4
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805057; cv=none; b=atQDurOm5JK2Zlj5Kdmu0rp2GLr4pXsNAwxG/WHUmq0NRi4jILsu3oaUiP+FPBSzdwWi2TbQFLd/FU0r4qW9Q11FWczO0gHT1+9MfGXiUv0ffQQu9b3uvuC/bMoRtoFDOh0KKiX9Pio3qE8x+YuHhzVVz8VebdT0B770egPsZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805057; c=relaxed/simple;
	bh=qE9hFWgOI8W5oAdXzHmoySUFIq2Kyvi0VvOjnV+fjaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtGSglyUxmUfjFb4Dd51k7pVWn0pJzM1DPs/OOQvc9B7Y2qLP5s/dkDBzjSkwaFhspxlCrDQA+elP6XkLciS41KjlUuyK56fGt1txqjXJ6a6YyPNjEvFKfWaKpLb12rq27PPkMkFv/1dMt4uQ68l6kZDt2i3hbyDf/ncYeGbdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5X7D7V4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5X7D7V4"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-433fcc4f28cso1222959b6e.0
        for <damon@lists.linux.dev>; Sat, 09 Aug 2025 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754805055; x=1755409855; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RplhLYKRbowPs0ffqGClhSE7xF+vOLgbG7MzNAT9Ds=;
        b=a5X7D7V4nTihDbM+rYhdnLk3fT6Rhoh47rcTFFvK8DrRSl1pjVcAGrMPngOUCCgasp
         VxrMqrPHP0YwGia/y2xW1jg82dIyOwirsdqlJ1+QHo3eIdfQ9Qo9OToL61Dy+wp1F6Su
         rvk9SvW8/N2qRI9xkl6j0rlQ9DG2cHmfggPnftO/Czn9uNFCJuvL/8IJ7QEcLJQUNHyG
         snygEfnaV2k2Gd3FFNTEzRPXEXPxJt1O0nwrwVLk78jP9JfbJ3ZAv+MtsorrRcVOI0Su
         iCZGjIqu36aanQ31N23TSYm8TREz1WUQT2Csw/qQsrtIybOwxRqEDiBd7eNJSnP7PDUK
         3eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754805055; x=1755409855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RplhLYKRbowPs0ffqGClhSE7xF+vOLgbG7MzNAT9Ds=;
        b=XD42SCSFKwdgBa+Mzkg1Zs+Y5iVwIMPjdK7DpcRM+J8EJQxjhDi6f6b0dtnl9vGsBX
         CgmG8OqS3CDLidB6ao2CZQZrtmubx4Ftkfn+uFgR1H2Aqfgn/GRAWBxKo/bYL6fkCRJF
         laYoI1qStARxhucuOLYCi+ouEN2gLLjB7dNhhLMFy/aIsqF6XHRqnXzWWNKFEstyRPVu
         KB1eJnGRylP2lIwTHIePv2EtYlKrWTwnZ9ZjKzfkT5VlkTg1m0ikR26XvuqCIF/+ob/I
         ncJ08G/aBqtmR99s9VjbghUMTL203h+DXPIv5h6HPqcMY+HWXM4sgZwC8CmU7E+7oGUv
         Ovtg==
X-Forwarded-Encrypted: i=1; AJvYcCXPOZ6Yv4/fVTjGmHOvpgFO+mM7j0qNuiBwpj1UaFI3rCiWqkJdNOfSJyxMPnqp7QfsjYlq6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr822DqvCXk+KuSu62XbnFhSshhosOawR6Jv1SPMxlQrO1U/rN
	vblrk5CPORWhE6vGqEHnY+aHYQ3pA7le0AuqsZia3+H+wX+zWIcx5/93/rt5aOLmK/hG8Bu2q7J
	uqsf1zQJ2/MRPfQL/sxQ1pF/FO183AaA=
X-Gm-Gg: ASbGncuPiUdhVw1laFm4L51SycoPliyyus+eKrd/E8/SWUDGqAubksuRXwpKiT6O0b5
	977U2vGvSAfySZblZwvzMAT4GGMti2Gr6zHYZR0Lvp/akLfq8Rr4RqrA1Z/BN/z+GzH2hRUcERQ
	LjftQ+jtghZ8KEaFM1TfUhnKaD7DpX37faXAleL8w3bv710dlPLdetaCA7RiqjS4WkS4pskQz5D
	ovIeKY=
X-Google-Smtp-Source: AGHT+IEDLol32kwZanNgYwxdv2mlzock6ARZkJaYvaJ+31EKV4GmrEL64Zokee7BM+3DiafITMb2/+OAXFUxEFMYvpw=
X-Received: by 2002:a05:6870:55c6:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-30c20f1de91mr4817604fac.12.1754805054636; Sat, 09 Aug 2025
 22:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250809130756.637304-1-ekffu200098@gmail.com> <20250809174838.71485-1-sj@kernel.org>
In-Reply-To: <20250809174838.71485-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 10 Aug 2025 14:50:43 +0900
X-Gm-Features: Ac12FXxV2eNezNgvc_e4rqGAi29JIh7FFDT5Kj18LpEB1lM6Giec7lzpKEQ6NF4
Message-ID: <CABFDxMFzWyN-edgiEeWufZLOsHM4BWe6kU5x7erJYV79kJOztw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: fix commit_ops_filters by using correct
 nth function
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae

On Sun, Aug 10, 2025 at 2:48=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat,  9 Aug 2025 22:07:56 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> > iterates core_filters. As a result, performing a commit unintentionally
> > corrupts ops_filters.
> >
> > Add damos_nth_ops_filter() which iterates ops_filters. Use this functio=
n
> > to fix issues caused by wrong iteration.
> >
> > Also, add test to verify that modification is right way.
>
> As I mentioned on v1 thread, please drop the test part, for ease of
> backporting.

As I mentioned on the v1 thread as well, I'll separate them back.

> >
> > Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") #=
 6.15.x
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > Changes from v1 [1]:
> > 1. Fix code and commit message style.
> > 2. Merge patch set into one patch.
> > 3. Add fixes and cc section for backporting.
> >
> > [1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@g=
mail.com/
> >
> > ---
> > I tried to fix your all comments, but maybe i miss something. Then
> > please let me know; I'll fix it as soon as possible.
> >
> > ---
> >  mm/damon/core.c                               | 14 +++-
> >  tools/testing/selftests/damon/Makefile        |  1 +
> >  .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
> >  3 files changed, 86 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_br=
eak.py
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 883d791a10e5..19c8f01fc81a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n=
, struct damos *s)
> >       return NULL;
> >  }
> >
> > +static struct damos_filter *damos_nth_ops_filter(int n, struct damos *=
s)
> > +{
> > +     struct damos_filter *filter;
> > +     int i =3D 0;
> > +
> > +     damos_for_each_ops_filter(filter, s) {
> > +             if (i++ =3D=3D n)
> > +                     return filter;
> > +     }
> > +     return NULL;
> > +}
> > +
> >  static void damos_commit_filter_arg(
> >               struct damos_filter *dst, struct damos_filter *src)
> >  {
> > @@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *d=
st, struct damos *src)
> >       int i =3D 0, j =3D 0;
> >
> >       damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> > -             src_filter =3D damos_nth_filter(i++, src);
> > +             src_filter =3D damos_nth_ops_filter(i++, src);
> >               if (src_filter)
> >                       damos_commit_filter(dst_filter, src_filter);
> >               else
> > diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/sel=
ftests/damon/Makefile
> > index 5b230deb19e8..44a4a819df55 100644
> > --- a/tools/testing/selftests/damon/Makefile
> > +++ b/tools/testing/selftests/damon/Makefile
> > @@ -17,6 +17,7 @@ TEST_PROGS +=3D reclaim.sh lru_sort.sh
> >  TEST_PROGS +=3D sysfs_update_removed_scheme_dir.sh
> >  TEST_PROGS +=3D sysfs_update_schemes_tried_regions_hang.py
> >  TEST_PROGS +=3D sysfs_memcg_path_leak.sh
> > +TEST_PROGS +=3D sysfs_no_op_commit_break.py
> >
> >  EXTRA_CLEAN =3D __pycache__
> >
> > diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py =
b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> > new file mode 100755
> > index 000000000000..fbefb1c83045
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> > @@ -0,0 +1,72 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import json
> > +import os
> > +import subprocess
> > +import sys
> > +
> > +import _damon_sysfs
> > +
> > +def dump_damon_status_dict(pid):
> > +    try:
> > +        subprocess.check_output(['which', 'drgn'], stderr=3Dsubprocess=
.DEVNULL)
> > +    except:
> > +        return None, 'drgn not found'
> > +    file_dir =3D os.path.dirname(os.path.abspath(__file__))
> > +    dump_script =3D os.path.join(file_dir, 'drgn_dump_damon_status.py'=
)
> > +    rc =3D subprocess.call(['drgn', dump_script, pid, 'damon_dump_outp=
ut'],
> > +        stderr=3Dsubprocess.DEVNULL)
> > +
> > +    if rc !=3D 0:
> > +        return None, f'drgn fail: return code({rc})'
> > +    try:
> > +        with open('damon_dump_output', 'r') as f:
> > +            return json.load(f), None
> > +    except Exception as e:
> > +        return None, 'json.load fail (%s)' % e
> > +
> > +def main():
> > +    kdamonds =3D _damon_sysfs.Kdamonds(
> > +        [_damon_sysfs.Kdamond(
> > +            contexts=3D[_damon_sysfs.DamonCtx(
> > +                schemes=3D[_damon_sysfs.Damos(
> > +                    ops_filters=3D[
> > +                        _damon_sysfs.DamosFilter(
> > +                            type_=3D'anon',
> > +                            matching=3DTrue,
> > +                            allow=3DTrue,
> > +                        )
> > +                    ]
> > +                )],
> > +            )])]
> > +    )
> > +
> > +    err =3D kdamonds.start()
> > +    if err is not None:
> > +        print('kdamond start failed: %s' % err)
> > +        exit(1)
> > +
> > +    before_commit_status, err =3D \
> > +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> > +    if err is not None:
> > +        print(err)
>
> Adding more context would be nice, e.g.,
>
>     print('before-commit status dump failed: %s' % err)

Sure, I'll add that to v3 patch.

> > +        exit(1)
> > +
> > +    kdamonds.kdamonds[0].commit()
> > +
> > +    after_commit_status, err =3D \
> > +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> > +    if err is not None:
> > +        print(err)
>
> Adding more context would be nice, e.g.,
>
>     print('after-commit status dump failed: %s' % err)

ditto.

> > +        exit(1)
> > +
> > +    if before_commit_status !=3D after_commit_status:
> > +        print(f'before: {json.dump(before_commit_status, indent=3D2)}'=
)
> > +        print(f'after: {json.dump(after_commit_status, indent=3D2)}')
> > +        exit(1)
> > +
> > +    kdamonds.stop()
> > +
> > +if __name__ =3D=3D '__main__':
> > +    main()
> > --
> > 2.43.0
>
> Other than above two trivial comments, nothing stands out to me.
>

Sounds great!

> Thanks,
> SJ

Best Regards.
Sang-Heon Jeon.
