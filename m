Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB72DF138
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692081; cv=none; b=uZRWxrYUPAt+ZC8VpIWyTsw2OzSBBiuYODtLC7FsAsXnA5cWLEF6NxWX+HaBRfM3aEjCOpCuWBSzL/h4ZenBAyfvNyFdbhyAE0s1a0ZfV5VZ5S+SZWXfxNQjdJwaRXvw8yMb8PXs62zuPRhjMspeiLbh584526ZMa0u1ugs34JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692081; c=relaxed/simple;
	bh=mXh1eFpoV/WRoKlbnIB/M0bLPzFZ/93FxLyxi4Z+Gu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RIZimCLfSBIgnEBjs9gPOu0WSKaRCDQmvIsXZQ/uLn+dWtI4ajpW3mNml8CI4zjZ4LAuWWBxOUg7AcJyKkv5ZnNtLT7M51x5LDSupk46BIivDiy+axPEuN/5dNpKT2+Xit+ayTpMk9phZRh/+ua7qHL6F9ozdSYaDsTN+cSsl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX2HtDzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX2HtDzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C919F1F000E9;
	Fri, 10 Jul 2026 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692080;
	bh=gjEz5tGCM2HZzw6WvgjsdZE0svyIu2HhFMgXNpTqXJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BX2HtDzzz9+FGpHIbCwiAC/2Irx542zC8FAfaaOkQgEnANqtiMjp01IREMkc5mkBJ
	 LL0nOm+SQS66TyuuGI7p4/NYwknu1T4GpWQRKE8NpeKjg8BZrdXQ40cmpAzQjtFxtR
	 SoA0e6OMg5PJanL6MeFi7yZ7Wn86dXJbRuoVGapi9ZXulAmTNj3ukkHh+ROQcsYcXx
	 3sPImhEldKOdUBvBk5F7AA2/JJr7w2czwsj0Q/b0aObKeSc37/vRfZ0DIX3cW+/HY3
	 GIagE5izupsoqzQEXLdLxzV8YmKSt5GfYgUGL6/wBVUsYIFOjGvdZl4Ss8B3S+kzhX
	 /BWUm9sV1XhVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/19] mm/damon/core: ask apply_probe() to return max
 probe hits weighted sum
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260710134651.18084-5-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
 <20260710134651.18084-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:01:19 +0000
Message-Id: <20260710140119.C919F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The apply_probes callback fails to calculate and return the maxi=
mum probe hits weighted sum, unconditionally returning 0.
--

--- Patch [4]: [PATCH 04/19] mm/damon/core: ask apply_probe() to return max=
 probe hits weighted sum ---
commit bb862935a31b8d93d0e79b24c1d5bb92b5faf39a
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probe() to return max probe hits weighted sum

This commit updates the DAMON operations protocol to allow the apply_probes
callback to calculate and return the maximum probe hits weighted sum. It
modifies the function signature to take a return_max_wsum parameter and=20
updates the existing implementation in damon_pa_apply_probes() to return=20
an unsigned int.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index aee28b05acc6c..e7acd8e610a64 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[ ... ]
> @@ -649,6 +649,8 @@ enum damon_ops_id {
>   * @apply_probes should apply the data attribute probes to each region a=
nd
>   * accordingly update the probe hits counter of the region.  It should a=
lso
>   * set &damon_region->sampling_addr of each region if ``set_samples`` is=
 true.
> + * It should also return maximum probe hits weighted sum of regions if
> + * ``return_max_wsum`` is true.
>   * @get_scheme_score should return the priority score of a region for a =
scheme
>   * as an integer in [0, &DAMOS_MAX_SCORE].
>   * @apply_scheme is called from @kdamond when a region for user provided

[ ... ]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index ff4fcca949660..3eba3564a31fc 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
[ ... ]
> @@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, stru=
ct folio *folio,
>  	return pass;
>  }
> =20
> -static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_sample=
s)
> +static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
> +		bool set_samples, bool return_max_wsum)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r;
[ ... ]
> @@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *c=
tx, bool set_samples)
>  				folio_put(folio);
>  		}
>  	}
> +	return 0;
>  }

[Severity: Medium]
Will this unconditionally return 0 even when return_max_wsum is true?

The struct documentation states the callback should return the maximum probe
hits weighted sum of regions if return_max_wsum is true. However, the
implementation in damon_pa_apply_probes() simply returns 0 at the end
without computing the weighted sum.

Should the maximum weighted sum calculation be implemented here to fulfill
the updated protocol?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134651.1808=
4-1-sj@kernel.org?part=3D4
