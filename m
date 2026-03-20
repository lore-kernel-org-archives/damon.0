Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771521AA1D2;
	Fri, 20 Mar 2026 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974896; cv=none; b=UippSSp+SXn8ob5v7JHMvmRjNxG0Cnq5PFHlibWQNYAjvUWPNH5nuq6YWBbUrItubUoXbISLBAkyJQFongLm5LvMLRw0c7Gf43Sx5Q1fgbaj9SfrGH5UlFmlLt9pyfW/bi4R4vv0wyL49iH8WrGAPhuvpP1hLARSFVY4oNNgzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974896; c=relaxed/simple;
	bh=/MJZfpkxLYSLTMw4fqVA5bUBJsT3txP8IPH/KELwiHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdXOwUf493q7OQISSuf1SPVoaYoBky586QY0J2mCx5xBkvTe+4u6MykLNJa/GGWW/Mod6znpqXx/W2OBWhi579Di8pchDGR5JnhP/bqeiCngPJGST2TNgmhda60+az4nAdErmtjoiJwcDE7sm1+olautnKPrHBkYRrX79xZyyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G89sXyH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G89sXyH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40ACC19425;
	Fri, 20 Mar 2026 02:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773974896;
	bh=/MJZfpkxLYSLTMw4fqVA5bUBJsT3txP8IPH/KELwiHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G89sXyH2fDZVtSEe3H+47YIQSJXtr8wIa23HCK5ebn/1zfTX0RypRyrkcpga9Qnvd
	 R6eibAaBpV0yUuru4tddKxWNRXmANQZW5/mR80XMZju8EZ3hmVpgJmCbOKYz4WjYry
	 WQF9pEvwp1CpJqfa8lHq/y7y6XUn1uUTZyXh29/CZgiXBMEhg5tnT/H3W9NH0dGsKW
	 jYUv0LQqd13BxAd86okQORVbgGKHG0Lg5qlDZ2NEpRYW+HPlFp76GCoE0xYhcAaoDB
	 Gbv2JdLj4MbK0srj1EZB3iMxBfvPDHeComtOzFW31PGiOUH+LFnO8qDzrf1wtJktKY
	 TjAwQABq/0A2A==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/reclaim: fix min_age_region truncation from unsigned long to unsigned int
Date: Thu, 19 Mar 2026 19:48:13 -0700
Message-ID: <20260320024814.1922-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319161620.189392-3-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 16:16:20 +0000 Josh Law <objecting@objecting.org> wrote:

> min_age / aggr_interval can exceed UINT_MAX with extreme but valid
> module parameter values, silently truncating min_age_region and
> lowering the cold-page age threshold below what the user intended.
> Clamp the result to UINT_MAX to match the field's type.

I believe the issue is not making real issue in real life.  But fixing this
makes the code cleaner to read, so I think this is better to have.  Thank you!

> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/reclaim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 9b55df304e51..303c64a56073 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -170,8 +170,8 @@ static struct damos *damon_reclaim_new_scheme(void)
>  		.min_nr_accesses = 0,
>  		.max_nr_accesses = 0,
>  		/* for min_age or more micro-seconds */
> -		.min_age_region = min_age /
> -			damon_reclaim_mon_attrs.aggr_interval,
> +		.min_age_region = min_t(unsigned long, min_age /
> +			damon_reclaim_mon_attrs.aggr_interval, UINT_MAX),
>  		.max_age_region = UINT_MAX,
>  	};

Sashiko comment.
# review url: https://sashiko.dev/#/patchset/20260319161620.189392-3-objecting@objecting.org

: Could direct access to damon_reclaim_mon_attrs.aggr_interval result in a
: division by zero? If a user writes 0 to the module parameter concurrently via
: sysfs between the validation step and this division, it appears the interval
: could be zero here.

Makes sense, but orthogonal to this patch.  I will work on this.

: 
: Also, since both min_age_region and max_age_region are now clamped or set to
: UINT_MAX, the target matching condition becomes exactly UINT_MAX. In
: mm/damon/core.c (kdamond_merge_regions), a region's age increments on each
: interval via r->age++ without bounds checking.
: 
: Does this mean a region's age will hit UINT_MAX, match for a single interval,
: and then wrap around to 0, effectively defeating the "reclaim if older than
: X" logic?

Good point.  But such case may be too rare to consider...?  Anyway irrelevant
to this patch.  I will take more time to think about this.

: 
: Finally, should similar clamping be applied to other DAMON modules? For
: example, in mm/damon/lru_sort.c, cold_thres and hot_thres are computed from
: unsigned long parameters but typed as unsigned int. Similarly, in
: mm/damon/sysfs-schemes.c, damon_sysfs_mk_scheme assigns unsigned long
: boundaries to the damos_access_pattern fields, which could also result in
: silent truncation.

Yes, similar issue may exist in DAMON_LRU_SORT.  But definitely it is
orthogonal to this patch.  Also, as I mentioned above, I think this change is
good to have but not really fixing real critical issue.  If a nice person send
a patch for this, I'd appreciate.


Thanks,
SJ
