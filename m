Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0B2BE05A
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099490; cv=none; b=Gq6JmaoM6wns87Fnk43CI6kUoyo1mxHPIZzqQ7QpMt1AlkStAaMS8pCKIA3OgPx/upcvl0S3/Kw6p8RoqXQAgW9jTHiGnz69dPi/aS6GbeXe/hJ81IOjm4vVaRCbyptmGW+C2teAzZz91puIMnfczIT4OIVdEsD3avBtYhJQSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099490; c=relaxed/simple;
	bh=3jLsqaXHP6DD+aFQ7GN/O3gVCWhUHDR9zDJt0OfWuEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ru+wilRN8f7N0SJSPrw84tsbyTx2C4jqqB7rTp7Q//RTl5xRFyM0gGazaiudDN4TqixNc2Y2bnKwO3zkgKCtPMypYadOwv8yae1ERhSLScuwXZ2pb+WoV9pM6C24ZS+9Ju3WFEDXj64/s9UQYBGc4nAA/afH5xeSxwjujn/G6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWTUDfYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWTUDfYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE3C1F000E9;
	Fri,  3 Jul 2026 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099488;
	bh=CqFkXSCQojZo7sc+bH4xSRFK0UxQ4q5MugbS86E/cqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWTUDfYgOqQvfGXlil45+MtfMSOWL5hm7vEiscIcwv/tekTms6YNQ2mlsRrzFLSMH
	 0xHRPcNIMs8xGM50VX24xY2DVSZy+ib9LfDxte6Ec6PkTHQHa3UvIXXGR4+KNhl3ym
	 zuscmg1mIf2yvP4TZRkUfVcj8ynoNWmYjGc/8x+O0yH8dX/cfhW2NSag6KeSgTVQsG
	 HyYva7j36OmoXZaNonzURxsLGmSZs7LEaQMM/9ZoTLJi3PgrjKrWfMa1fPLAOwNIFl
	 XjFU/aTefbXmat9KmwqA8qcdG8M4ObAH3o3hdWfnXiMPPSSdypBlCwMMGZsyGMH+7K
	 Gw8MEeofiay+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon: add damon_region->last_probe_hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260703170605.94472-2-sj@kernel.org>
References: <20260703170605.94472-1-sj@kernel.org>
 <20260703170605.94472-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:24:47 +0000
Message-Id: <20260703172448.8AE3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] `damos_apply_target()` merges regions without validating or aver=
aging the newly added `last_probe_hits` array.
- [Medium] Missing reset of `probe_hits` when monitoring attributes change =
dynamically mid-aggregation corrupts the new `last_probe_hits`.

Pre-existing issues:
- [High] `last_nr_accesses` and newly added `last_probe_hits` are not updat=
ed or averaged when regions are merged in `damon_merge_two_regions()`.
--

commit 43369d5eda0b4a1301ca211bc77bce0681b92eac
Author: SJ Park <sj@kernel.org>

mm/damon: add damon_region->last_probe_hits

This commit adds a new last_probe_hits array to the damon_region struct.
It maintains fully accumulated probe_hits values from the last aggregation
interval in this new field.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 805e089ff4f2f..4f7e305b261c3 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -68,10 +68,10 @@ struct damon_region {
>  	unsigned int nr_accesses;
>  	unsigned char probe_hits[DAMON_MAX_PROBES];
>  	struct list_head list;
> -
>  	unsigned int age;
>  /* private: Internal value for age calculation. */
>  	unsigned int last_nr_accesses;
> +	unsigned char last_probe_hits[DAMON_MAX_PROBES];
>  };

[Severity: High]
This is a pre-existing issue, but does damon_merge_two_regions() also need
to average last_nr_accesses and this newly added last_probe_hits array?

In mm/damon/core.c:damon_merge_two_regions():
    l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
                     (sz_l + sz_r);
    l->age =3D (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
    l->ar.end =3D r->ar.end;

Because last_nr_accesses and last_probe_hits are left unmodified as the left
region's values, it seems this can cause spurious age resets in later loop
passes. If the left region's last_nr_accesses was 0, but the newly averaged
nr_accesses is non-zero, the condition ((r->nr_accesses =3D=3D 0) !=3D
(r->last_nr_accesses =3D=3D 0)) evaluates to true and spuriously resets r->=
age
to 0.

[Severity: Medium]
Should this newly added field also be validated in damos_apply_target()?

When damos_apply_target() iterates over regions, it merges adjacent ones if
their age, nr_accesses, and last_nr_accesses match:

    if (prev_r->last_nr_accesses !=3D r->last_nr_accesses)
        continue;
    if (prev_r->nr_accesses !=3D r->nr_accesses)
        continue;

Because last_probe_hits isn't compared, regions with different probe statis=
tics
might be erroneously merged, and the right region's probe hits would be
silently discarded.

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c6fc35be633b3..60be3e9d87887 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -2040,8 +2042,10 @@ static void kdamond_reset_aggregated(struct damon_=
ctx *c)
>  					damon_nr_regions(t), nr_probes);
>  			r->last_nr_accesses =3D r->nr_accesses;
>  			r->nr_accesses =3D 0;
> -			for (i =3D 0; i < DAMON_MAX_PROBES; i++)
> +			for (i =3D 0; i < DAMON_MAX_PROBES; i++) {
> +				r->last_probe_hits[i] =3D r->probe_hits[i];
>  				r->probe_hits[i] =3D 0;
> +			}
>  		}
>  		ti++;
>  	}

[Severity: Medium]
Could this copy un-reset, partial-interval probe_hits into last_probe_hits
when monitoring attributes change dynamically?

When damon_set_attrs() dynamically changes intervals mid-aggregation,
damon_update_monitoring_result() explicitly resets nr_accesses to drop the
partial state:

    if (!aggregating)
        r->nr_accesses =3D damon_nr_accesses_for_new_attrs(r->nr_accesses,
                                                         old_attrs, new_att=
rs);
    else
        r->nr_accesses =3D 0;

However, probe_hits is not reset. When kdamond_reset_aggregated() fires nex=
t,
will it populate last_probe_hits with mixed-interval garbage, violating the
fully accumulated semantic guarantee?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703170605.9447=
2-1-sj@kernel.org?part=3D1
