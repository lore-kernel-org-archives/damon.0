Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081B83A14;
	Wed, 25 Mar 2026 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401422; cv=none; b=DUZ6plWIPHFaEpzRva0NbNPvnxgJDheBqVWA2s45irR6bNw4SmS/YTAtAAJ6JkYleEAFk1axJ1FlWYf+KioAVQ27FY6z9XLvVS0x45tN5a1havdscOexcLPbYGBUIxDu/Z3fPNk8kL6K8drj9dWsqIevyLbdFd6pX/VIWXNsVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401422; c=relaxed/simple;
	bh=nbpn1HlNS+cTXXOL5D8pJ35n5ChNxTXKV92YCz9TAoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWhS9KMwQq+oeRbhm8G/7aem+soykBSvXnSMq6V3OC3Zt0j9CIZhHtigq1IWL29HHbe2/s/i1emPRsOq7kADyRVvBjjtQ/4g6iFGL/k/PAOiKynrDiVfXK5zqs6GXVhCmACngK9AU9taCd/bfUU7TiOJhHZ8gtmXVpLFdHijpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDebcREA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDebcREA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD2CC19424;
	Wed, 25 Mar 2026 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774401421;
	bh=nbpn1HlNS+cTXXOL5D8pJ35n5ChNxTXKV92YCz9TAoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDebcREAm/zGVG4vNA/rTt/xIPC1Jn6idgfjKVKuop5NLhgbCt/C+Vu+dz2smYnGM
	 nCJnd4KBuiHOsNY2ugsIlopjvgIEdwcYdPzi4RYgF5tx82MO+TF6VzKORgv8INEYn3
	 eUkWkIAm1X9845uVt/Yay+0AKqdT9ClNfMXuQxIKpumvRa+QU/Hr1wc/O4J+HD34De
	 sWarPv8f6bXsBY/BWzAi1mTWH0uY5XcZe8nw/KK3uAQp3rcCAsQO6Set1cI7z05M73
	 Y+Tdb8PqNDLYsjllOr5GnL1DZTQk7eO6n8xifCDk8xMqjx+7qXQ+lfvqA+ibyAmwpd
	 7Lgg9nETqZvrw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Tue, 24 Mar 2026 18:16:52 -0700
Message-ID: <20260325011653.85502-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324154005.83651-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260324154005.83651-1-objecting@objecting.org
# start of sashiko.dev inline review
commit ff5e227a18cd69435749b0aae0dc2c762c4f0a47
Author: Josh Law <objecting@objecting.org>

mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
    
Hardware integer division is slow. The function damon_max_nr_accesses(),
which is called very frequently, performs an integer division.
However, the struct damon_attrs already caches this exact ratio in the
internal field aggr_samples. We can eliminate the hardware division in
the hot path by simply returning aggr_samples.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index d9a3babbafc1..04c8a052fcfb 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -978,8 +978,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>  {
>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> -			(unsigned long)UINT_MAX);
> +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
>  }

If an administrator dynamically updates aggr_interval via sysfs and commits
the inputs, will attrs->aggr_samples be correctly recalculated?

If aggr_samples becomes stale, kdamond_fn() will compute the real aggregation
loop count and allow r->nr_accesses to increment up to the new bounds (for
example, 80 loops). Meanwhile, damon_max_nr_accesses() will return the
stale aggr_samples cache (for example, 20).

When evaluating schemes, damon_hot_score() normalizes r->nr_accesses against
this stale maximum, producing a freq_subscore that severely exceeds
DAMON_MAX_SUBSCORE. This causes the calculated hotness to exceed
DAMOS_MAX_SCORE.

For DAMOS_PAGEOUT actions used by damon_reclaim, damon_cold_score() returns
DAMOS_MAX_SCORE - hotness, yielding a highly negative score.

Could this negative score cause an out-of-bounds write on the
kernel heap when used as an array index?

mm/damon/core.c:damos_walk() {
    ...
    c->regions_score_histogram[score] += damon_sz_region(r);
    ...
}

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..afb058f7da5c 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -587,6 +587,7 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->attrs.sample_interval = 5 * 1000;
>  	ctx->attrs.aggr_interval = 100 * 1000;
>  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
> +	ctx->attrs.aggr_samples = 20;

Since this value is cached here, but not updated when intervals change, does
it remain permanently stale during dynamic updates?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260324154005.83651-1-objecting@objecting.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260324154005.83651-1-objecting@objecting.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
