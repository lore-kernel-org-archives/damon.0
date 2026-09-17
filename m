Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488864973B4
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661378; cv=pass; b=UJDP0YMWVNOrkoW46+vCMAF7/W3G92MTpjWFr4ZRRMyqKRetjCZOVO5tu4A7nKXv1fZyVl+WRbj9tY20JQstMzfKeNbqivQ+riLUnmJ9yz+IS/IrhS49zEmVPUoof8Qon+QGA8QmVxP9OQ4I1HgDw6G4MHFE/AvJ5F3qq0HvzPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661378; c=relaxed/simple;
	bh=RgL79Lnzncx8mghSjwh58S2gtWUM52THqisj17I1bc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPgNTFENcDQFR584VtX4UUKcuiR4uu9/mW/c6C6tvxwETNJz6Q8QmByeR1o7GHj4dLqIcXqoqklC6onNY/lZhkBM76lr8exOfzqR2xlYNH+8oePPUHeq8AN9g4fmVvo3jbJgxc6EUO8w6LQJnt9+1hQJ/BNhvxYZ+LqrNi/9bbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRHaZVFf; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRHaZVFf"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20f4bso1004365d50.0
        for <damon@lists.linux.dev>; Thu, 17 Sep 2026 09:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661376; cv=none;
        d=google.com; s=arc-20260327;
        b=G2OEzhsV9DMaMQiZUTm2xUYMSn1qhBSdkwMLgbHs5jSYygv++y5SH13gWr7D8oPP4t
         RZwOvnXF/siKJ8O57RgRAqcVqvyaY/onkWXwceA+VzTQn5GClDnaSZNsHFK40KlUWDoy
         fXQLqMAsshY7/oW4uE+SFRpkDAR5EVzhlJ66/lS5q7JH0W+Rfolqt4QTbA/7vthteHux
         FFnDUqf39T7VTRsUrbe92FjF4dXKOrSZpMLjxkUqYzUR+9UCeYlrlMq3GCpWvqMsQuN0
         6vii6NfzCUf1Nxe8vP6zkCjtTgOkP54aSf1zM+DYPUacBbPwtpvzVmwODShEcKIBplrK
         qfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Utnj2BUg2wgBn65CQTDS0GpKi8jE06RpdxKfTfpq1t4=;
        fh=+oVtggD84ZfFTtudLbEbmIRo6c56HGvUGuOAPUHvXfw=;
        b=NXnwIC5XnZrbfEtbtvZ8JyJyuHIW+wM2c6Jv3unSK/mdxzImu5ZdCjrrMb8a4iaH3r
         lC0UPYLTDPKCxD0OpJcsw+qe5BloAWr2VIXzvCz+tojDKslO51T7j6R4BrjX7e4AzttB
         /yerOGj9mP7hs5WQjHy7uraWEybn1ZpAzsOkDg72O4WTfejbV5daW6cRgCFOP90AuEpM
         bRgTZt93bZrvOMk7bgtElDXFWxDmnNITpTJQuvesu8z60X5ZxPF94SotYVZqDQdNOAsa
         BzZNQJf7XkV0LEfAXdAB2Qj3Mk3DFIb5iLxHrRsFavXMN7fln6YrjjKCSODiAeuviJ9W
         Z3JA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661376; x=1790266176; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Utnj2BUg2wgBn65CQTDS0GpKi8jE06RpdxKfTfpq1t4=;
        b=BRHaZVFf/5blMCP80PEFeLclHzpLHr3/jZBUTKIn1JVt9W9smdo8YsFw1S65RMk1at
         r9hBzD54M9S1JzBDU0rgWhF2qiN8zrd7gDTmA8ohvXzPASt1yMg1I6r0eu7AU/qPP1/z
         OxO6rGaVMDD/vRqmd0zMtrNqj+tCKD4axYjk0QKzFtpaGp/RnDm4jGb0VL79cxthgWPC
         l+urHCsqJN1Tm5bcYzlkIqfJBBak+4ZzQT1rvwaKjKaDxvFWujAh06v2BChqPvNvf8RD
         1ylHDfJIcr0SlzCxT4cqJWuXAf0S9X7Kj1ZwbUTObATv+PrLyyOllj8qOza0YvQIviQx
         2B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661376; x=1790266176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Utnj2BUg2wgBn65CQTDS0GpKi8jE06RpdxKfTfpq1t4=;
        b=p9x5gsuKRw9ugivWs+RSECaxEQ1Rik0dlFymRWeunE4PZ6+lM6uDCTvJ9OmTZ3pSeU
         ETEvUH1arjlQGOqn77x6E4bYItbnAW8qwIt9MuLWGDodMOj1czgaP0OqIeZm1Lc2zg62
         aJ2kXNIbPZiuBEoY8q9y7BdPHq4DKaqQpW7KpD+dzGrRUpOfzi8Beb8wDEtq7SsYbqbA
         7bVEGMqgimvrT0bIFb2ok+BYHsGmGyMEBwHG1H8J9xCCKrKF8V405NRb2iRKb/fc+AO7
         5jIk8EpzCCFITOryxdS5MwMnbt5B8C2yewhv6zKsEVSsKgjn/r0d6k+ErKRa17GhvgZL
         XVhg==
X-Forwarded-Encrypted: i=1; AKwUvBxVeZqlr3atbyKwpxEoT/2gChbvibt6P0l7ypSXMhuMC7ML89ZkHovbpjHL3KGCXuRnYILzvw==@lists.linux.dev
X-Gm-Message-State: AFuF++lnhShVWf4heh00UvJNM9pq8rqgtBizYQK9R2kvqRlt4REAyCPy
	XdgyTm8YVXO8ZSiSb95UKB7Kbod+2vbrCJ7BeD5YqpeN+r6vhw32FvhaVJsm3vXyLtap/GV/3vv
	0/xvthBHG9koE5CQ/g283+orRUOP/Eag=
X-Gm-Gg: AYBFou10m7aHpR+4FrHFuY2CHUa0R3n+NHhGAYXgGNnEjDY7c0h7XMPJs6bSW/xbtdY
	HLaM+5u78f88U2+dEix2YjPxADMc20kYWevE32y8yXRnU5GB+7Qq01pTD74SfD9J7jnVmRjT/BM
	yjvywAcEKrWJsNET6TQt9ogSThiXwnreVNr6dNVYsq+/cZGhoVnOMBHB96kK4F76iVP9BzM0zct
	rQeTVgJ10Pc2ozrpLn0EXHEqnGzhHkGCS9lbpxtuTCTdepnjiWQVrmgm29OiqccJsx0ZXwikFRL
	sC86+8XCwgSfrJr2OY/OyK1HwgCDFHf0PqAT8KaM9gmpUEBtkduC
X-Received: by 2002:a05:690e:454e:10b0:671:4099:2195 with SMTP id
 956f58d0204a3-6716321104dmr1607824d50.26.1789661375920; Thu, 17 Sep 2026
 09:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260917150631.1138698-1-karthiproffesional@gmail.com>
In-Reply-To: <20260917150631.1138698-1-karthiproffesional@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 18 Sep 2026 01:09:24 +0900
X-Gm-Features: AcwNN1Uk9UpyoJUob1Iy_YX5RVhaLvh8gpmUhgIMopwOfP5aLXWiHdFhc1xctuM
Message-ID: <CABFDxMHjbQhzvrQmRjo_F9Tf0_zQ20FxaSHFEQN8nfN+VgsF2Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: reject zero sampling interval
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 18, 2026 at 12:14=E2=80=AFAM Karthikeyan KS
<karthiproffesional@gmail.com> wrote:
>
> damon_set_attrs() already rejects inverted intervals (sample_interval >
> aggr_interval) and invalid region counts, but it accepts
> sample_interval =3D=3D 0.
>
> A zero sampling interval is not a valid monitoring period.  Sysfs "on"
> and "commit" both install attrs via damon_set_attrs(), so kdamond then
> calls kdamond_usleep(0) and busy-spins.
>
> Return -EINVAL if sample_interval is zero.

I think SJ already commented on a similar patch. please refer to [1]
If this happens a lot, maybe should we document or add a comment about this=
?

[1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> ---
>
> Hello,
>
> I recently started reading DAMON and just found this one.  This
> change only tightens damon_set_attrs() validation, in the same place
> as the existing sample > aggr and min_nr_regions checks.  It is not a
> crash, UAF, or race.
>
> sample_us=3D0 is accepted today, so kdamond_usleep(0) busy-spins (about
> one core).  Sysfs "on" and "commit" both go through damon_set_attrs();
> one check covers both.
>
> Checked on v7.3-rc3 (238650ef6c7c):
>
>   unpatched: echo on with sample_us=3D0 succeeds; kdamond uses ~97% of
>              one core.  echo commit of 0 onto a running kdamond also
>              succeeds and it starts spinning.
>
>   patched:   both on and commit return -EINVAL.  Valid sample_us=3D5000
>              still starts.  After a rejected commit the same pid stays
>              on and does not spin.
>
> aggr_us=3D0 with a positive sample_us is already -EINVAL from the
> ordering check.
>
> Thanks,
>
>  mm/damon/core.c             |  2 ++
>  mm/damon/tests/core-kunit.h | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a1656..376c3e2cbe00 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1060,6 +1060,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct d=
amon_attrs *attrs)
>                 return -EINVAL;
>         if (attrs->min_nr_regions > attrs->max_nr_regions)
>                 return -EINVAL;
> +       if (!attrs->sample_interval)
> +               return -EINVAL;
>         if (attrs->sample_interval > attrs->aggr_interval)
>                 return -EINVAL;
>
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 4a536d41cdb2..ec8ef71956c8 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -658,6 +658,19 @@ static void damon_test_set_attrs(struct kunit *test)
>         invalid_attrs.aggr_interval =3D 4999;
>         KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL=
);
>
> +       invalid_attrs =3D valid_attrs;
> +       invalid_attrs.sample_interval =3D 0;
> +       KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL=
);
> +
> +       invalid_attrs =3D valid_attrs;
> +       invalid_attrs.aggr_interval =3D 0;
> +       KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL=
);
> +
> +       invalid_attrs =3D valid_attrs;
> +       invalid_attrs.sample_interval =3D 0;
> +       invalid_attrs.aggr_interval =3D 0;
> +       KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL=
);
> +
>         damon_destroy_ctx(c);
>  }
>
> --
> 2.34.1
>

Best regards,
Sang-Heon Jeon
