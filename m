Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFB74BE1;
	Tue, 24 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897214; cv=none; b=qajuRbiisdpWgHsflWXpWQ0kePWUFCWM1cjrRsX68a3B5Wq1JmIJxGANnxuTrhGr0DxN+VIhW4nyS1gnJwj7ARBbNkdhxp9UhEzawUxFPlSpFYLmQ8gGvvb9bv/sNxy1x70sYERAdeo88w6SWqevP7HLoe1UCh7V02lYBXLf0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897214; c=relaxed/simple;
	bh=RVsWdbVmMny33bwfq1wjdOBiqTKHCK+8VIVYGYGqQOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHeTsy0amuR+kjy8hImAbXkUT2iulE9jA8z33yBLvbyE0GAL9hm0FgFcJXsF3kNJ0pXdn1M9VC19nuDJXxcL8DDzp8eBrVne97U7TT859w8TlMx1FF7DYmCw2F14wBf1enl2Pdd/6HCbDT1o3tMeEi9CTY1NwHuNLfedVV/fB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoQWqwLg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoQWqwLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C8C116C6;
	Tue, 24 Feb 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897213;
	bh=RVsWdbVmMny33bwfq1wjdOBiqTKHCK+8VIVYGYGqQOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoQWqwLgvkqgXt/cw5N8bTjcYP+4SJSOo5Tf7LqZyhmzV1zL5Ag2IPPW2u1CKo/hr
	 CLGERRmA71w1M3MLKaSZvIPGc6x7msQLb3neIq6WzXXebYXILCYZvhvfvRjbiuGvI2
	 BFQemwneuh3RMa6JfhVnuu4urqEiOg7Cn1heC+Nv7VBDT82D+sOmOpfn0fZG2fOMnU
	 t1/YAREVgf8a7XVlyRqg4O0sd2QM1k/ltDHz//HbYi8qASdnzMn4+j/V5NQ4gnk56W
	 oU3v3ZjyJ9F4aDqCz4zDW72iDYttLEFMF3L760iA8jGQJu8hp32e7MdGVfS41ABz2G
	 gaBZoXWDNr5Eg==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v3 1/4] mm/damon/sysfs: set goal_tuner after scheme creation
Date: Mon, 23 Feb 2026 17:40:11 -0800
Message-ID: <20260224014011.56624-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223123232.12851-2-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Feb 2026 12:32:29 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> damon_new_scheme() always sets quota.goal_tuner to CONSIST (the default)
> regardless of what was passed in the quota struct. This caused the sysfs
> goal_tuner setting to be ignored.
> 
> The comment in damon_new_scheme() says "quota.goals and .goal_tuner
> should be separately set by caller", but the sysfs code wasn't doing
> this. Add explicit assignment of goal_tuner after damon_new_scheme()
> returns to properly apply the user's setting.
> 
> Without this fix, setting goal_tuner to "temporal" via sysfs has no
> effect - the scheme always uses the CONSIST (feed loop) tuner, causing
> overshoot when the goal is reached instead of immediate stop.

Thank you for catching this, Ravi!  So, this is a fix for the RFC patch series
[1] that not yet merged, right?  I think this fix is better to be carried with
the series, and squashed into the broken commit to not introduce unnecessary
regression.

So, if you don't mind, I will squash this into the sysfs-schemes part change on
my tree, with your Co-developed-by: tag.

[1] https://lore.kernel.org/20260212062314.69961-1-sj@kernel.org
[2] https://lore.kernel.org/20260212062314.69961-4-sj@kernel.org

> 
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/sysfs-schemes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index bbea908074bb..fe2e3b2db9e1 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2809,6 +2809,9 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
>  
> +	/* Set goal_tuner after damon_new_scheme() as it defaults to CONSIST */
> +	scheme->quota.goal_tuner = sysfs_quotas->goal_tuner;
> +
>  	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
>  	if (err) {
>  		damon_destroy_scheme(scheme);

To follow the order on the comment ("quota.goals and .goal_tuner should be
separately set by caller"), I'd prefer setting the goal_tuner after
damos_sysfs_add_quota_Score() call here, if you don't mind.  Let me know if you
prefer keeping the current order.  If not, I will just make the change when I
apply this to damon/next.


Thanks,
SJ

[...]
