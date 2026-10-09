Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E6399CE9
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557818; cv=none; b=a9CzO/yA4TRddhpfDsW4GrfNaP7p3d/EDlftNfIB9oIfPx+n6qlHXiNOaqU6XbxBPU93QOryBr2eIPf+YKbA4s6jCjkZvJnUI3HCPIt83qivVxskWRb1Z9BHmPAA6yKC9kSC1HVfrS+e3Q7ya02gW8SDiIVbCypPWZSh0ji9IS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557818; c=relaxed/simple;
	bh=fUd7WIbSd8Q+vf0OHIN4AniDoYfI5yx8cZ8hASXHPOc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aP7BG3MTGWwo5zYcRvqBcKGn72mSOCKeJcnUBgT7/G0Uh98n0P1KbTkKfSobi2wGzJ3XpBgmvuXHr6d+aRQ36v14zgE44bu5v698sjZt6+L9AyZErzTffgJTWUrxoFEa/7ihsOJRhzat7BmsIXA6U3K3NXW4Vz0l90Q1wDRh2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1BeQWth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1BeQWth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF21F000FF;
	Fri,  9 Oct 2026 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557817;
	bh=kcMytBa8f+aZdl9V7J+A2aWakxQUisTjsxk/DpQb6q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y1BeQWthGZKyXVSuEj16mm6+zo+fegWBAsAmVfUn03IQZqd2j1Flhwduqq97SgehN
	 AGt6ljW1/TDQLeVa2U3pi/g+sCV/76gTD7hGFkfpHINe2HCTrbVrHxWphnIlxh8AoD
	 gZMd82zm0J275O/0andoNldX+/+SVkficPLK3vuuwSnpC1XW3uVLbFPPPSQH016N1y
	 fFzbFXdJS7uF5NHsqp21IpJmVb7VigIpuQuwsBxpioS6GwAgDLT4BD0Hm7N1i9Df6Y
	 zOxsvkk1nzOYX51cv6Kn3W7u9TiIwEni/dpVJDcbmT5OEYfYE6u3goacGp/hSgDLsn
	 pwbu98h13kMyg==
Message-ID: <sashiko-outbox-165747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y v2 1/2] mm/damon/core: do non-safe region walk on
 kdamond_apply_schemes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261009144808.18317-2-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261009144808.18317-1-sj@kernel.org>
 <20261009144808.18317-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:56:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/damon: double processing and skipped regions due to broken back=
port
--

commit 18797502eb0b5cf3a96dbf53e3e238e6ea4158ce
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

This commit replaces the damon_for_each_region_safe iterator with
damon_for_each_region in kdamond_apply_schemes. This change ensures that
newly split regions from address filters are properly processed during the
iteration.

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7afbc20833ea4..c65d2cbeea6b5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -912,7 +912,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	}
> =20
>  	damon_for_each_target(t, c) {
> -		damon_for_each_region_safe(r, next_r, t)
> +		damon_for_each_region(r, t)

[Severity: High]
Does this change result in regions being skipped and double-processed?

The commit message mentions dropping the workaround in
damos_skip_charged_region(), but in this stable kernel version, that helper
does not exist yet and the workaround is still inlined in
damon_do_apply_schemes(). Since the inline workaround wasn't removed in this
backport, it appears to conflict with the new loop iterator.

If a scheme's quota->charge_addr_from check triggers a region split in
damon_do_apply_schemes(), the local pointer is advanced:

mm/damon/core.c:damon_do_apply_schemes() {
    ...
			if (quota->charge_addr_from && r->ar.start <
					quota->charge_addr_from) {
				sz =3D ALIGN_DOWN(quota->charge_addr_from -
						r->ar.start, DAMON_MIN_REGION);
				if (!sz) {
					if (damon_sz_region(r) <=3D
					    DAMON_MIN_REGION)
						continue;
					sz =3D DAMON_MIN_REGION;
				}
				damon_split_region_at(t, r, sz);
				r =3D damon_next_region(r);
				sz =3D damon_sz_region(r);
			}
    ...
}

Because r is reassigned locally within the inner scheme loop, subsequent
schemes will apply their actions to the newly created second-half region,
completely skipping the first half.=20

Then, when damon_do_apply_schemes() returns to the outer loop in
kdamond_apply_schemes():

		damon_for_each_region(r, t)
			damon_do_apply_schemes(c, t, r);

The iterator will advance naturally to the newly split second-half region.
This causes damon_do_apply_schemes() to be called a second time on the exact
same region, leading to DAMON actions being applied multiple times to the
same memory, double-charged quotas, and corrupted statistics.

>  			damon_do_apply_schemes(c, t, r);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009144808.1831=
7-1-sj@kernel.org?part=3D1
