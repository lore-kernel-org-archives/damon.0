Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067B181334
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013347; cv=none; b=jHND4eg9U8/m3pdBcUJXe4YmbOUZCK7LAFD+Vj78LppgGlBBntDEt4ms7HfHw29GanNJz7hCWz4k2VYkhLndCSl1lDysXzzCSAsnPK/oPeMkh1YGTUUlMQ6qC4YH/RJF5ugU96dwzEmD4t4Palbux+s4tFF4vZSKvqqjfXMLi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013347; c=relaxed/simple;
	bh=4ToMK4fwoT9Lhoza39c/wlcDi8nsM/k501N47kT9iYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHldqc5h4ZVrKwxisGEtPMkLMqq9hi2eRgStEMP3Mum1+KbzGF63+XGXXpgRPfzgTeOaHcfAakOdp3UZHGjf3Uo32e2vRmmjCp/04u2pGuUVZHD0dt+BRqqERdEWDfKufBKCHOr4FGZ3ZcUje39QeXBLUV2mPV7CvYFZQJjQny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UemkytAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UemkytAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403FC1F000E9;
	Thu,  2 Jul 2026 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013346;
	bh=0ER7uT0vbVzPsAtVtXSXeG+1Q+OAOfKAkTX476drpho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UemkytAHkSb+RgnYVrAyVXpeenR4fOUeNv8GRCAscySk7p43IbMsNLPJ38cfQrrXE
	 jJd4KoEJIGPMztWhjsBKRcMYlhhdXzpFe5LuI4WSXqhKpkV2m88k7qk1FBHhAsrH4x
	 lA2kpO0GBrQAB1gDFS/XPfsCvypvmB8wb/54eeMPLIfIEyPu/hg7CxoaEkgHLSNJQd
	 JXzwBJk/NpYb7AAql6J7N3vWKNgzXa18aAnei54t8leILuNL4tmJP+2jo5feR8ErVQ
	 Rgh8ClswU94Z2XANiQ6DUnnRSq2ajgP0Tcqdr/eqC8ukyC8yyat8W51CZbsdNJ4lFM
	 /ufuyN8Fx+64w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/3] mm/damon: add
 damon_region->last_probe_hits
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702171714.88278-2-sj@kernel.org>
References: <20260702171714.88278-1-sj@kernel.org>
 <20260702171714.88278-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:29:05 +0000
Message-Id: <20260702172906.403FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] When `damon_update_monitoring_result()` is called to apply new a=
ttributes mid-aggregation, it resets `r->nr_accesses` but fails to clear `r=
->probe_hits`. As a result, accumulated probe hits leak across the aborted =
interval boundary. Furthermore, the newly introduced `r->last_probe_hits` f=
ield is completely ignored by this function=E2=80=94it is neither scaled fo=
r the new interval attributes (unlike `last_nr_accesses`) nor protected fro=
m the `probe_hits` leak. This causes the newly introduced moving sum statis=
tics exposed to userspace to become artificially inflated and mathematicall=
y incorrect after an attribute update.
--

commit c9f161ddb2f122eeb9bddfba63cb77e65fe86f9c
Author: SJ Park <sj@kernel.org>

mm/damon: add damon_region->last_probe_hits
   =20
Add new damon_region field, last_probe_hits. Maintain fully accumulated
probe_hits values from the last aggregation interval in the field.

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
> =20
>  /**

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

[Severity: Medium]
Is there a regression in how statistics are updated when attributes change
mid-aggregation?

If damon_update_monitoring_result() is called to apply new attributes, it
resets nr_accesses but doesn't clear the probe_hits array:

mm/damon/core.c:damon_update_monitoring_result() {
    ...
	if (!aggregating)
		r->nr_accesses =3D damon_nr_accesses_for_new_attrs(
				r->nr_accesses, old_attrs, new_attrs);
	else
		/*
		 * if this is called in the middle of the aggregation, reset
		 * the aggregations we made so far for this aggregation
		 * interval.  In other words, make the status like
		 * kdamond_reset_aggregated() is called.
		 */
		r->nr_accesses =3D 0;
    ...
}

This appears to completely ignore the newly introduced last_probe_hits arra=
y.

Since last_nr_accesses is scaled for the new interval attributes, should
last_probe_hits also be scaled to maintain accurate moving sum statistics?

Also, should probe_hits be cleared for mid-aggregation updates to prevent
leaking accumulated counts into the aborted interval?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702171714.8827=
8-1-sj@kernel.org?part=3D1
