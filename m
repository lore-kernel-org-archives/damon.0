Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1E3D47AB
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704759; cv=none; b=RzML8GlWez/cfyHZ0B5X3wXMV/pAHDtL3PXDXb3vNAku2ugY3vmgHNPcdx4eehH4m2+8CLXY6PbVKg8d01MsHDTTF7Rsa6mmtslgPQ13nodpFYCaafreWHiGfuYBYA0fIN/uxNiiYMG18nGJtxYkDVx0iQiFNYsXYr6I+qAbDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704759; c=relaxed/simple;
	bh=JwBUWDGpe+odNmGnpbjKh4SwK4zcmQSu/4bkSoamB8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OzUbbqXDn9VGhNWoWPkYrmQKsMYTgWhKUn/iIUX3/lWW1VFtQN5z35afV/+weVzjpCjcJmYWhOWArhf6sQ6xw1BeMKaeztfMroqQiu4Iyt/ovPdXLwF0uwbB+n9Zq4BRR8jIiLG4r0PCbEVNHHdRV8hO347eXZXbkBvIqZUb1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhOsZYBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhOsZYBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5D71F000FF;
	Tue, 29 Sep 2026 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704757;
	bh=WzV378YIc7iFXlFRYJ22tT1viPH0hRWgAd7C8LMPPH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhOsZYBH6PDLJGYDerdzJ+GnWCg94+B2xKJQGpw0mlLtbI3FHyROnYzwgG7gPXGf/
	 EGobFiPIPJK4KUO4BHuAi0Y5gU3AV3bTxXVCwffEwSs+fEDgy50OA6a/7Ik6YSJM0l
	 IFlElWDgmLAVK2T19PxY6uK2DN8VHaFkuB+vOQ3w9uMxxgFCnuV/x6F2tQzXkqZFju
	 pKVANNHJQS0lwU8Yr8Bmpt8HHxB3ZtHBj8hMgkLJQLeXhAZ1+4es8o/acY8Zb3afIB
	 GDlvd1GpL3dvLoCvfnKHEesYID4K8+XpbJmSuduFYVWBXzLCtL3T1N7M8+90QkYOa3
	 OGlo70vLZseUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929174456.9251-1-sj@kernel.org>
References: <20260929174456.9251-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:59:16 +0000
Message-Id: <20260929175917.6E5D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/damon: removing min_sz_region clamp on esz breaks quota accou=
nting
--

commit f7906e90ad53cf62853b7b051dfd11b8012181f1
Author: Liew Rui Yan <aethernet65535@gmail.com>
Subject: mm/damon/core: allow esz to be set to zero

This patch modifies damos_set_effective_quota() to allow the effective
size quota (esz) to be reduced as much as possible when temporal quota
goals are achieved. It does this by removing the clamp against
min_sz_region when calculating esz.

Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6fa02025d2af1..facb1fa1f695f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -2212,8 +2213,8 @@ static void damos_set_effective_quota(struct damos_=
quota *quota,
>  							quota->total_charged_ns);
>  		else
>  			throughput =3D PAGE_SIZE * 1024;
> -		esz =3D min(throughput * quota->ms, esz);
> -		esz =3D max(ctx->min_sz_region, esz);
> +		esz_time =3D max(throughput * quota->ms, ctx->min_sz_region);
> +		esz =3D min(esz_time, esz);
>  	}

[Severity: Medium]
Will this break quota accounting when goals are over-achieved?

By removing the clamp against min_sz_region, esz can drop below the minimum
region size, for example to 1.

If esz becomes 1, does ALIGN_DOWN() in damos_apply_scheme() evaluate to 0?

mm/damon/core.c:damos_apply_scheme() {
        if (quota->esz && quota->charged_sz + sz > quota->esz) {
                sz =3D ALIGN_DOWN(quota->esz - quota->charged_sz,
                                c->min_sz_region);
                if (!sz)
                        goto update_stat;
                damon_split_region_at(t, r, sz);
        }
        ...
        quota->charged_sz +=3D sz;
}

If sz evaluates to 0, it jumps to update_stat and bypasses incrementing
quota->charged_sz.

Because quota->charged_sz gets frozen at 0, wouldn't this prevent the quota
short-circuit from ever being taken in damon_do_apply_schemes()?

mm/damon/core.c:damon_do_apply_schemes() {
        /* Check the quota */
        if (quota->esz && quota->charged_sz >=3D quota->esz)
                continue;
}

Can this also corrupt the qt_exceeds statistic since the same check
fails in damos_adjust_quota()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929174456.9251=
-1-sj@kernel.org?part=3D1
