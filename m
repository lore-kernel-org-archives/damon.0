Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEA146A72
	for <damon@lists.linux.dev>; Sat,  9 Aug 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721596; cv=none; b=Z8lP0EFEuq6w4GNm8UDzS3mz5KKnp2GD6RzZSehPumznYcawkUdXKvNG3XEpygXIXS3WhCrK0bK+mJ6oMIOy/uMY+gou24uNhwuWfZYNDgCy83T2Xi4TaAt+cxgEFBo9nM3VhzXfNt67JArt7xON6JKoTguWLjfELD1CEzY66dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721596; c=relaxed/simple;
	bh=zNAempxyygrDavryPLCZSufUjuckYzL8fADqptFikg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw/kkdXppRwAyFDRSUzbM8lWvamOMo6E0ufViI4DnlL+ZBpzPxtF2LqwykVr7JO6To43tqQPwXER6O901rGXzPMxA+XTQcwo6s5dsixWGxzzIN2/ymnEO5oqDpzYVJ7z3CrX26tC1KCC3efGp4Zda2UaekkuTXpRkuTc3MC6AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiGfLOnL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiGfLOnL"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-619b00a9256so626679eaf.2
        for <damon@lists.linux.dev>; Fri, 08 Aug 2025 23:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754721593; x=1755326393; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veV+M239TKy4G3gr61ocAU8YtRih4s6PgN9gAB5Yo7E=;
        b=kiGfLOnLMTaxzNV2yI124A/ZYz8AEcfCM6/WKq4fCxA+303JS9iE5NinOZ6YxU0WZP
         rrSexDnv+ZoJIMeX9g+xr+uQYYuzvBu/7lot7laUlDuzT7jUlOQQ729WQ4jr+uX5hZzu
         d7cZ+7dASuigE36bEdyt3uXeaqYEWeBVcZpKnwrzCGrMFE7ILj/Nc6iAvW9Zbz1deh6T
         QBm1D1g2Cu2FoHbX/n44dkrWu0uGnUH/E9fqaKQy366ja0y0nk2uvNq+SiRrazZn5T7Z
         v/b1bkrSKNlf0TeIHSWNUEEkGpdMWpYnhB1HVkC5CgSumBkaBHK2od1Us0DvcfAXOJb5
         4BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754721593; x=1755326393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veV+M239TKy4G3gr61ocAU8YtRih4s6PgN9gAB5Yo7E=;
        b=rMGVitq3WXa4zKiSXIxTGwBSUhHuO+gwBllowF+/BlyT+MqSBJ7ZAeTJ2LmVUOjWAC
         Xc3QtAHv8776bBrr2QmBc5q/g/TzPi1h/A2tUjp3w2gj+HKYRxA73uUjDu9Niqj7HjS5
         B9YHxoV2Zozh50ub3U5z2NvUxbRxMPfQQUMVsXSkHPxo2eqgelD92+FQhtdqRESN8+yO
         fPWgMKDDKGD5FBXqzedmmw8JiufdW7tSopnq7oJJkQyVLCgOFmLhwkLIMz3sxq00epws
         6FVnYvOqCrgxzNZe02cIkXnyh+p/ZwIqZYzc3NYy6n4AS6wm+szfrtKGie1ju6ICVfhT
         V3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcxt5hDOyRMBNnZtxqmFQIt2rRwBkL/y3IzEwscrcFLvWEP2isyx4Umf3ekS8qt7rmho8SKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfU2nHq94mN3JozNsk0A9ZPysYfvrPnIlAmbKv81kWMTClCQZb
	wTbAMzC5jJ/r3EwHR3PuqwW6k3DnMNYsardDA/FDByJPHUhu+WX12jC7oJWoX96p/cQ+Oqmk9JV
	hkOUJbU85X0/E355vbPWV8En2O0xmZ+c=
X-Gm-Gg: ASbGncvnRp3514M83QKtl8eokAmeQMgdR///MGDbacSqFEFzcxyAczIwvQSL4YXwQ9K
	MDFZWuFW0jJPgJkVmxilWzFwnn5EB/9ulNH6KSDcsoBXHlkZbYGq35rFoyEKZjxzxoYVdf+fcZK
	5UlJ6Q0ylWiMig6eudIaAOlgyOE9ZVm0EF2l37IVN5N7WX4+H7hKqmK7apcIr5Qwu8Qnqgb/KpQ
	8dE
X-Google-Smtp-Source: AGHT+IGJd6d5iQ+IAgCBUGEHC07giPLKhEeoKHtoKrti76CPTOW7eWcPtYT1PnqpDMkVDsJg6TSVe1NAbWrjqgN8sHk=
X-Received: by 2002:a05:6871:5b21:b0:30b:9750:3085 with SMTP id
 586e51a60fabf-30c20f8d5f8mr4072412fac.10.1754721592943; Fri, 08 Aug 2025
 23:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250808195518.563053-2-ekffu200098@gmail.com> <20250808220526.49546-1-sj@kernel.org>
In-Reply-To: <20250808220526.49546-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 9 Aug 2025 15:39:41 +0900
X-Gm-Features: Ac12FXxLSMV9ojkBvMIF5dWN25ReJEbVQLVtmtN-3sVjXP8LH_0UgKFz2cGvtgc
Message-ID: <CABFDxMH0LDLLdJf-t2DEHCD40EJDfcq35cJM-HS5GkLX7KqsHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/damon: test no-op commit broke DAMON status
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae

On Sat, Aug 9, 2025 at 7:05=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hello Sang-Heon,
>
> On Sat,  9 Aug 2025 04:55:17 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Add test to verify that DAMON status is not changed after a no-op
> > commit.
>
> Thank you for this patch!  I have some comments below, though.
>
> > Currently, it is failing. but after fix the bug it should be
> > success.
>
> To keep bisecting goes smoothly, let's introduce failing tests _after_ th=
eir
> fixes are landed.

I see. As mentioned in another comment, I'll merge this patch set into
one patch. I think this comment will be resolved then.

> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  tools/testing/selftests/damon/Makefile        |  1 +
> >  .../damon/sysfs_no_op_commit_break.py         | 78 +++++++++++++++++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_br=
eak.py
> >
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
> > index 000000000000..300cdbaa7eda
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> > @@ -0,0 +1,78 @@
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
> > +        return None, f'drgn fail : return code({rc})'
>
> Let's not add a space before ':', for the consistency.

I see. I made so many mistakes like these; (I worked this very late
night...) I will fix them all. Thank you for checking this moment.

> > +    try:
> > +        with open('damon_dump_output', 'r') as f:
> > +            return json.load(f), None
> > +    except Exception as e:
> > +        return None, 'json.load fail (%s)' % e
> > +
> > +def main():
> > +    # We can extend this test to change only the Given and reuse the W=
hen/Then.
>
> Above comment seems unnecessary to me, since that's obvious.

I agree. As you said, it is obvious. I'll remove all pseudo like comment.

> > +
> > +    # Given : setup filter with allow =3D True
>
> Again, I don't think the above comment is necessary.  And this looks like=
 a
> pseudo code more than a formal comment.  If you think it is necessary, pl=
ease
> use more formal tone.
>
> Also let's not add a space before ':', for consistency.
>
> > +    proc =3D subprocess.Popen(['sleep', '10'])
> > +    kdamonds =3D _damon_sysfs.Kdamonds(
> > +        [_damon_sysfs.Kdamond(
> > +            contexts=3D[_damon_sysfs.DamonCtx(
> > +                targets=3D[_damon_sysfs.DamonTarget(pid=3Dproc.pid)],
>
> Can't we start this kdamond with paddr ops, and drop the 'sleep' process
> invocation?

I just referred other tests. And i think we can remove unnecessary
targets and sleep process. I'll fix it on v2 patch.

> > +                schemes=3D[_damon_sysfs.Damos(
> > +                    ops_filters=3D[
> > +                        _damon_sysfs.DamosFilter(type_=3D'anon', match=
ing=3DTrue, allow=3DTrue)
>
> Let's keep 80 columns limit[1].

Oh, I thought it only applied to 'C' related codes. I'm wrong. Thank
you for reminding me. i'll fix it.


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
> > +    before_commit_status, err =3D dump_damon_status_dict(kdamonds.kdam=
onds[0].pid)
> > +    if err is not None:
> > +        print(err)
> > +        exit(1)
> > +
> > +    # When : No-op commit, it should not break anything
>
> Again, I don't think the above comment is necessary.  And this looks like=
 a
> pseudo code more than a formal comment.  If you think it is necessary, pl=
ease
> use more formal tone.
> Also let's not add a space before ':', for consistency.
>

ditto (wil be removed)

> > +    kdamonds.kdamonds[0].commit()
> > +
> > +    # Then : Check value with drgn
>
> Again, I don't think the above comment is necessary.  And this looks like=
 a
> pseudo code more than a formal comment.  If you think it is necessary, pl=
ease
> use more formal tone.
>
> Also let's not add a space before ':', for consistency.

ditto.

> > +    after_commit_status, err =3D dump_damon_status_dict(kdamonds.kdamo=
nds[0].pid)
> > +    if err is not None:
> > +        print(err)
> > +        exit(1)
> > +
> > +    before_commit_dump =3D json.dumps(before_commit_status, sort_keys=
=3DTrue, indent=3D2)
> > +    after_commit_dump =3D json.dumps(after_commit_status, sort_keys=3D=
True, indent=3D2)
>
> Let's keep 80 columns limit[1].

ditto.

> > +    if before_commit_dump !=3D after_commit_dump:
>
> Can't we jsut compare before_commit_status and after_commit_status?

Yeah, I think i'm just confused. I'll change it.

> > +        print("[TEST FAILED] : no-op commit break damon status")
>
> Let's not add a space before ':', for consistency.  In this case, I think=
 ':'
> is not necessary at all.  Actually, since this test is for the single tes=
t
> case, and kselftest framework will say this failed, I think the above pri=
nt()
> is not necessary at all?

So, kselftest framework identifies whether the test was successful or
not by exit code. Then, i'll remove this one.

To be honest, I didn't use kselftest framework while making these
patch set because I don't know how kernel developers use it.

If you are okay, could you share how you use it? I just build kernel
with custom patch, and execute output images by vm, and setup env,
then just execute tests(it's so raw.. i know)

Maybe is there a kernel build option that automatically includes tests
to output image? Or just a general or smarter way to execute the whole
test?

> > +        print("=3D=3D=3D=3D=3D before_commit =3D=3D=3D=3D=3D")
> > +        print(before_commit_dump)
> > +        print("=3D=3D=3D=3D=3D after_commit =3D=3D=3D=3D=3D")
> > +        print(after_commit_dump)
> > +        exit(1)
> > +
> > +    kdamonds.stop()
> > +
> > +if __name__ =3D=3D '__main__':
> > +    main()
> > --
> > 2.43.0
>
> [1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines=
-and-strings
>
>
> Thanks,
> SJ

Thanks for reviewing! Have a nice weekend. I'll do this job after my
personal schedule finishes.

Best Regards.
Sang-Heon Jeon
