Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6023B638
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479946; cv=none; b=L4uvBdxSDGc03xnBsNtMHSfQfqCKCVdcyowpal5+Db5+yURjEIbqDRNHhPH5dcBn1phWIjBckRRUjq8Pu8ERX2VPhiebrRSv5eWDo9Zt9qZxAV9ICNI4sSubBTOZz7v0cZsUmyUeHsXgy2dpZfymwZFKlA3mTv4MKWJ9AA40N1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479946; c=relaxed/simple;
	bh=aXIesHrhQZPE3T5HIs5EW0LL1e+TCEHH/QyQ9TKGB34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5Jf9kWUrik65JZ7MKSJ7QONGL8v+QXwK9111glbW5B7raSTGSu6ltuK74igc8ZVkplDVBRsgDPKReQ2fNvDBwUysBMi0/+YeFEnEfwBLdZmalqQrlYtAgr1KG8AV9UkT+ew72vEYoXsq0RdMaz/kgU2GBp0ZZt9qsEDv3cYjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWH+pU9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWH+pU9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBC61F000E9;
	Wed,  8 Jul 2026 03:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783479944;
	bh=B6UCTi85VZxkuZ5JTafzXut4FanYgYZ0amaWg/kNzR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWH+pU9Q0sXM8EorkyuxiX99g5HFh6qTmNWRHMFoNM+9j88woERn7RxV1aTU5YcH6
	 yb3xJ3MZm9eFmZX1LPxFPFGDzxxG4cC5Ezfp3nt1kOu+yNiE8kPwDDZThb4lobd06F
	 81S961w2ITXG5XYVCQCqMH+IBhngfTW1u8iui7yWLug+DLaNlZdu9uaI4LClasXenq
	 ET9gWrM+0Y2lyadMA9El5ucGKiEFaeRLP9M5a/wW/TQf4dcegNARWOelhl2x03OXod
	 cIZiWqfhEMrJzWiKmN1Zk/X8OgoHxblAEufnkmyLyTc7ZXkoKYRO1b8Ac3dslJW3O9
	 mKbdFbtLYyokA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 6/7] mm/damon/core: update probe hits for new
 parameter commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708024855.116614-7-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
 <20260708024855.116614-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:05:43 +0000
Message-Id: <20260708030544.6EBC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded iteration over `ctx->probes` list writing to the statica=
lly sized `probe_hits` array can lead to buffer overflow.
- [Medium] Scaling `probe_hits` and `last_probe_hits` using `damon_nr_sampl=
es_for_new_attrs()` assigns an `unsigned int` to an `unsigned char`, causin=
g silent truncation and data corruption when the scaled count exceeds 255.
--

--- Patch [6]: [RFC PATCH v1.3 6/7] mm/damon/core: update probe hits for ne=
w parameter commit ---
commit 5d7c7277de18e07d88cf49d1f16d870a9dfc0f23
Author: SJ Park <sj@kernel.org>

mm/damon/core: update probe hits for new parameter commit

Users can update DAMON parameters at runtime.  If the samples and/or
aggregation intervals are updated in this way, monitoring results
depending on the intervals should also be updated for a more accurate
snapshot.  The age and nr_accesses are properly updated, while
probe_hits are not updated in the way.  Do the update.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 800ff6b6d2473..15d31285515d6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -897,10 +897,32 @@ static unsigned int damon_nr_samples_for_new_attrs(=
unsigned int nr,
>  			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
>  }
> =20
> +static void damon_update_probe_hits(struct damon_region *r,
> +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> +		bool aggregating, struct damon_ctx *ctx)
> +{
> +	struct damon_probe *p;
> +	int i =3D 0;
> +
> +	damon_for_each_probe(p, ctx) {

[Severity: High]
Does this loop overflow the r->last_probe_hits[] and r->probe_hits[] arrays?

The probe_hits and last_probe_hits members are defined as fixed-size arrays=
 of
size DAMON_MAX_PROBES. Since there is no bounds checking on i, if there are
more than DAMON_MAX_PROBES in the ctx->probes list, this will write past the
end of the arrays and corrupt adjacent fields in struct damon_region.

> +		r->last_probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +				r->last_probe_hits[i], old_attrs, new_attrs);

[Severity: Medium]
Will this assignment cause silent truncation and data corruption?

The last_probe_hits and probe_hits arrays are declared as unsigned char
(8-bit) in struct damon_region, but damon_nr_samples_for_new_attrs() return=
s an
unsigned int (32-bit).

If the scaled count exceeds 255, assigning it directly will truncate the va=
lue
to a meaningless modulo-256 wrapped value rather than clamping it at a maxi=
mum.

> +		if (!aggregating)
> +			r->probe_hits[i] =3D damon_nr_samples_for_new_attrs(
> +					r->probe_hits[i], old_attrs,
> +					new_attrs);
> +		else
> +			r->probe_hits[i] =3D 0;
> +		i++;
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708024855.1166=
14-1-sj@kernel.org?part=3D6
