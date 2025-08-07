Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F580125D6;
	Thu,  7 Aug 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525968; cv=none; b=fCRR/+WtTJ//QWPbA1O7OHm8bTSCxFAzhl7zv3IraiwUxJ9CQ4CivDqXWhj2c+ArrkcVaGoPy1O7z0AwMoNg9dDhp7Zf1XWiR3djsEMV+dsSAvj7H/oT4ao8MSLsDM4pE06egpnYp9bAIJeAbqVKdQq3KGWsx4dgdPwC2GZHWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525968; c=relaxed/simple;
	bh=d+AthCl+27uwwUegwgI7OVtC0RLeunbYLIjyUmAKL5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgnInfEKbIBrVnynAnCj9iQbPZrNsElMlCWJBiP/bEN953RMiC9gm85WgsmLCCML91OHFrhQTzbfmRmFFV9lZB9ecbOb7n5lLe3KWUZGovyOapAe0YzK8HLZ1abXxAO58OzzidfWz1Iq300NFRbvJY5kxHwMGiHpBkqs+k9beJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWMHD7WA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWMHD7WA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777F1C4CEE7;
	Thu,  7 Aug 2025 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754525967;
	bh=d+AthCl+27uwwUegwgI7OVtC0RLeunbYLIjyUmAKL5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWMHD7WA2fsa31FPyzFfAtSSQPM+Ofdy+XivkqkQTv+Ems0ieAI6rvQbRIUNDdj41
	 /CMZRn00i57EZLpXjRIBLBG92352EKss7kA9djfBnAlLjGL0sg0fCtAJKBpNXKKbgW
	 +n3CyD4SvX5+l8G3maitFejW/syN1n2XJ1IG4zwOS10Vj0mAYPvlVLF9+OEaWWZ5th
	 R7pf2bboXgjXpBJt5UB773Y0xZSfg3BQGIG2HjYJZZTRdzEaahRqQjzfvQFiJ2e6qY
	 j49i2htRnrnPezr+kVcbzpPnpo3rQQ/2db3TKC2H9+oG2hhcbUkMASp78CoBbqPMOW
	 w0VKJC+g8zhsQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
Date: Wed,  6 Aug 2025 17:19:24 -0700
Message-Id: <20250807001924.76275-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806234254.10572-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  6 Aug 2025 18:42:54 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> Currently, damon_commit_ctx() always calls damon_set_attrs() even if the
> attributes have not been changed. This can be problematic when the DAMON
> state is committed relatively frequently because damon_set_attrs() resets
> ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
> update operations to be needlessly delayed.
> 
> This patch avoids this by only calling damon_set_attrs() in
> damon_commit_ctx when the attributes have been changed.
> 
> Cc: Bijan Tabatabai <bijan311@gmail.com>

Maybe above line is added by a mistake?

> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I have a trivial comment below, though.

> ---
> Changes from v1[1]:
>   - Compare entirety of struct damon_attrs
>   - Apply logic in damon_commit_ctx() instead of damon_set_attrs()

Thank you for doing this!

> 
> [1] https://lore.kernel.org/all/20250806164316.5728-1-bijan311@gmail.com/
> ---
>  mm/damon/core.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 6a2fe1f2c952..80aaeb876bf2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -570,6 +570,24 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
>  	kfree(ctx);
>  }
>  
> +static bool damon_attrs_equals(const struct damon_attrs *attrs1,
> +		const struct damon_attrs *attrs2)
> +{
> +	const struct damon_intervals_goal *ig1 = &attrs1->intervals_goal;
> +	const struct damon_intervals_goal *ig2 = &attrs2->intervals_goal;
> +
> +	return attrs1->sample_interval == attrs2->sample_interval &&
> +		attrs1->aggr_interval == attrs2->aggr_interval &&
> +		attrs1->ops_update_interval == attrs2->ops_update_interval &&
> +		attrs1->min_nr_regions == attrs2->min_nr_regions &&
> +		attrs1->max_nr_regions == attrs2->max_nr_regions &&
> +		ig1->access_bp == ig2->access_bp &&
> +		ig1->aggrs == ig2->aggrs &&
> +		ig1->min_sample_us == ig2->min_sample_us &&
> +		ig1->max_sample_us == ig2->max_sample_us;
> +

Unnecessary blank line?

> +}
> +
>  static unsigned int damon_age_for_new_attrs(unsigned int age,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
> @@ -1198,9 +1216,11 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
>  	 * 2. ops update should be done after pid handling is done (target
>  	 *    committing require putting pids).
>  	 */
> -	err = damon_set_attrs(dst, &src->attrs);
> -	if (err)
> -		return err;
> +	if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
> +		err = damon_set_attrs(dst, &src->attrs);
> +		if (err)
> +			return err;
> +	}
>  	dst->ops = src->ops;
>  
>  	return 0;
> -- 
> 2.43.0

Other than the above trivial things, looks good to me.  Thank you again!

Andrew, I assume you would prefer resolving the above nits (removing
unnecessary cc and blank line) on your own?  Pleae let us know if not. :)


Thanks,
SJ
