Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014737A831
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320284; cv=none; b=OKIKD1IhMvpCRZ6+/cwRQ+QBMpvCV+rkyYJSQzhQpBLnzUOJSGig/fvZ0gWJNR2EwvLYJfoSpEsCKMqfPZLC5BHvVxxFHZP617L+HJeCjCMcI8TRtjgtOa70IaJxpYZt2DzcMfXxtfczXpScLA6qXBp8FuqT/OpoE36A7hB5L/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320284; c=relaxed/simple;
	bh=mbHtOY9YO7f5hc2Ig56aWRuetWK722BeUzKWZStiPM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ncel6vc3i4Rzzgc2ix2Aq/XR0vE/DSO3tQkOuF9UaB7z9m8DkvVqIAIWFpDy410YMPmkn4mRpszf0SLemQDKT+w9ex5+q4V2cUth287rsA5+S94GNMsqcbuDXtuyuq//AHarig+sG595RNXitPEPMzchKTfJDtTXZrkUehybJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTs5I9OR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTs5I9OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF911F000FF;
	Sun, 13 Sep 2026 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320283;
	bh=6uEiJfIGZ3W3xgDSLQW+W3ft7fjpoZin8+aoeQqLIdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTs5I9OR5japEINnuTGdO421PK1isDXkypcKy05yshDTOyZ4MQPqif0C5Utdt/r2K
	 IETseqk8XpAdWRH+X9h7js2MdNHu7ZL2LGJ618pnt9toNE5rFk/ho5yobx26Pb/r6+
	 E/Cy3b1AY6Cv9rYTmf8ofv2Da8jAdu2hLnRYYY05beh9vm8nLnmAcDWWTClwNt8wLs
	 fiDDbTQJlEyy/Hm+70ymT/+N9LPJO0P0NDFdpvqdyg4CcAnu51PN9gWet3VHzEcclA
	 4beSOpYZl3vopddgNkicOCX/yL3YkHc3snKFKxPpfH3PHH749L+Fw4QJ4T/gL1WzIo
	 s4xYueqGK4gDg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] mm/damon/ops-common: support hugepage_size
 damon filter matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-4-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:24:42 +0000
Message-Id: <20260913172442.EBF911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] damon_commit_filters() leaves range_min and range_max uninitialize=
d for appended hugepage_size filters.
--

commit 377608c283881250a794879309e80b931825b0d3
Author: SJ Park <sj@kernel.org>

mm/damon/ops-common: support hugepage_size damon filter matching

Update ops-common data attribute filter matching logic to support
hugepage_size filter type.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index c36cc39cd2c70..77366f42b3e5b 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c

[ ... ]

> @@ -558,6 +559,15 @@ bool damon_ops_filter_match(struct damon_filter *fil=
ter, struct folio *folio)
>  			matched =3D filter->memcg_id =3D=3D mem_cgroup_id(memcg);
>  		rcu_read_unlock();
>  		break;
> +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> +		if (!folio) {
> +			matched =3D false;
> +			break;
> +		}
> +		folio_sz =3D folio_size(folio);
> +		matched =3D filter->range_min <=3D folio_sz &&
> +			folio_sz <=3D filter->range_max;
> +		break;

[Severity: High]
Does this new filter type need to be explicitly copied when a newly appended
filter is committed?

When userspace adds a new filter to an existing DAMON probe via sysfs,
damon_commit_filters() in mm/damon/core.c invokes damon_new_filter() which
allocates memory without zeroing it. The attributes are then copied in a
switch block:

mm/damon/core.c:damon_commit_filters() {
	...
	new_filter =3D damon_new_filter(src_filter->type,
			src_filter->matching, src_filter->allow);
	if (!new_filter)
		return -ENOMEM;
	switch (src_filter->type) {
	case DAMON_FILTER_TYPE_MEMCG:
		new_filter->memcg_id =3D src_filter->memcg_id;
		break;
	default:
		break;
	}
	damon_add_filter(dst, new_filter);
	...
}

Because DAMON_FILTER_TYPE_HUGEPAGE_SIZE is missing from this switch block,
range_min and range_max will be left uninitialized for appended filters. Th=
is
could result in the filtering logic using garbage memory values.

Should DAMON_FILTER_TYPE_HUGEPAGE_SIZE be added to this switch statement
so the range boundaries are properly copied to the new filter?

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D3
