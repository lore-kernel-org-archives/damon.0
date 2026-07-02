Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCE385D74
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029078; cv=none; b=MWmEoQaNDaNbqSAm5PcYYqDKACHFS9kF+F+FgPlIiWdQzRI+5XMjhbu6cUYv3gc/YkbBsnkTlGbHJWEbr9ATWzKNlK8m5FA7rXh24et5FFmxF/i7ZMvyNrAgOnysp6ZGBMBQvUL57LuPeFvcnYr6WVPnTkzhTTeqkKiPR9wsbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029078; c=relaxed/simple;
	bh=MiS5VIa2k6dG5uM7xT6iJ6OO9XLywGYAljMhqCgGvCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBvwvXvvlATR93ACUaB6Q9OVYemmZNb9IBT6wLI7LKT9nMqR3MvrcL1f2LWSZLH8r2bglFgqGFTgwaQ0GO4ODsl7YroSpr96eQxOsV4qtNUPdetmXMaDKJO42Nla4J298q2kTTy49AWom7c6Qx6A4y9dcAmG3BE/rwUVDq6RYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMVUruDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMVUruDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E81F000E9;
	Thu,  2 Jul 2026 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029076;
	bh=N1NBRlbuw7aD7sED7xbPU57Y5kAfNHukHwMzA/Wm2io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMVUruDDn1DfrkesHN8O3ikg486Esz3eSLMfnRO7ISeMYbHNau82pm8LG/jkCDRub
	 fHxK3Yi8PmlPkibghwJ+AR9rgRada0F9b8Jr9K/MVJRD8oBno+TUnRGNrx+VpOo7+D
	 B66/a4QFmj7CZ3PPhFfQwYzqOB9kEIO62DL4XaUHyUHcs2WN2BGJrRYy3piYSn+2HS
	 /6EF0FBvhprjNjcsswKTcmjiwkSV4Z/iSBW4rNcjQTp4izFBVKy3KeelokrPEVcACj
	 rBGsLpLPTPb6t3WIQL5cP/k0bn57cF2qoTcgaVsE7f4EdbBtjycTdTMW6SLDytnaFO
	 x9HmwQwAlxk8A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 7/8] mm/damon/core: remove start, end check in damon_set_region_system_rams()
Date: Thu,  2 Jul 2026 14:50:59 -0700
Message-ID: <20260702215059.97387-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702211652.A17B51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 21:16:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the explicit `*start > *end` check introduces inconsistent input validation, allowing inverted or zero-size ranges to be silently accepted.
> --
> 
> commit ad7c7a8a7766992d5ad4dbe1c23874e807f45071
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove start, end check in damon_set_region_system_rams()
> 
> damon_set_region_system_rams() validates user inputs to avoid creating a
> negative size region.  But DAMON core avoids zero size, too.  The check
> is incomplete.  The complete check is done inside damon_set_regions(),
> which is eventually called from damon_set_region_system_rams_default().
> Drop the incomplete and unnecessary check.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 179ce6b0a542d..dba53a41a1025 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3812,9 +3812,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
> >  {
> >  	struct damon_addr_range addr_range;
> >  
> > -	if (*start > *end)
> > -		return -EINVAL;
> > -
> 
> [Severity: Medium]
> Does removing this check allow invalid inverted or zero-size unaligned bounds
> to be silently accepted?
> 
> The commit message claims that a complete check is done inside
> damon_set_regions(). However, looking at damon_set_regions(), the validation
> acts on aligned values:
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
> 	for (i = 0; i < nr_ranges; i++) {
> 		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> 				ALIGN(ranges[i].end, min_region_sz))
> 			return -EINVAL;
> 	}
>     ...
> }
> 
> If unaligned invalid bounds are passed (for example, start=4095 and end=20,
> or start=20 and end=20), they are rounded to valid blocks (e.g., 0 to 4096)
> by ALIGN_DOWN and ALIGN.
> 
> Because they evaluate to a valid positive range after alignment, they escape
> the >= check and are silently accepted.
> 
> Should this explicit check be kept to ensure unaligned invalid bounds are
> correctly rejected before alignment?

Both are no issues.  Refer to my reply to patch 6 Sashiko reply for more
details.


Thanks,
SJ

[...]
