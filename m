Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED242365A1D;
	Tue, 24 Mar 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315684; cv=none; b=LGyq4OHUPwYj3wXRqQrvpKc30rP4ZaFuiegWr09+TcRCZ/NfBsx8uOOinuc3BdxNGg7SMEWzNmLlWelFkRBowQjQFjbZdlPMdZy5JJpsCuWfSqs2EPixs3coUD4nd29eWoGhYIH1bLS5Lx4ME7s5aiG4jskyYeXQcM4iKkmJR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315684; c=relaxed/simple;
	bh=eqylb9ckWMaPu/WMDobYdxMaubmdEZF8Q47h4e0euw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwdT77LT6Ohk4QiqMkPXXotz+QAwlgseBanE5DtXcNMcpfH2pBdPhx/2v69KtsTgdcnUFt7HbSJlLfYAe5ZzLLamfShNPv7O+1fJVk1kAj4qQ7UK9OyGRo01Is3C2ftsIUIUPTMfouBLUXw2cZKI6/FyzeIv1LHGRuvOaxxcHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3PTBLJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3PTBLJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F9C4CEF7;
	Tue, 24 Mar 2026 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774315683;
	bh=eqylb9ckWMaPu/WMDobYdxMaubmdEZF8Q47h4e0euw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3PTBLJ0tr/5dYtdejvyq6qK8nICiwmTZHdSARl+o1UpwOhCC+s7mKbJO1Yt97vKz
	 Nq1n5RhECGqijkU7Rk3VMoPbTvOL8cird4Uf3HkW89QCtkf2q9A7hC+pzPlfmHcqW2
	 r3FRk7Vvy72XfrgsK5TO/O+HnDhPSvsrdSrL54agk2kSGVuDxl6QUKRJDu7Hv082Zp
	 SxX3Moa+TmVkHUs69d88pXfyeB5qnAgQJ8aFTWRI6bUOpxZ6G/ajOXnezhaLY8hftM
	 45fdm5Vn1WrUAsBHm4++i1fCK5gzg3fL7RL9Y4wEW6VIUf3QERH8XhCdziJ/p1O92s
	 WlL61576BGggw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Mon, 23 Mar 2026 18:28:00 -0700
Message-ID: <20260324012801.42930-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260323231538.84452-2-sj@kernel.org
# start of sashiko.dev inline review
commit 011f7b451b6e4a657677ee09eada15a7980e8480
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: introduce damon_ctx->paused

This commit introduces a pause parameter to the DAMON context, allowing
the kdamond main loop to be paused and resumed without losing its
self-trained internal data.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..0ab2cfa848e6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
>  		kdamond_call(ctx, false);
>  		if (ctx->maybe_corrupted)
>  			break;
> +		while (ctx->pause) {
> +			damos_walk_cancel(ctx);
> +			kdamond_usleep(ctx->attrs.sample_interval);
> +			/* allow caller unset pause via damon_call() */
> +			kdamond_call(ctx, false);
> +			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
> +				goto done;
> +		}

Since this loop is located after ops.prepare_access_checks(), kdamond_usleep(),
and ops.check_accesses(), does this unconditionally perform a full monitoring
cycle before honoring the paused state?

If a context is started with pause set to true, or if pause is enabled while
waiting in kdamond_wait_activation(), it appears it will still execute one
complete active sampling cycle. Could this cause unexpected disruption, such
as clearing PTE accessed bits, when the context is explicitly configured to
be paused?

Additionally, when the context is paused, kdamond_fn remains in this sleep
loop and skips calling damos_adjust_quota(), which means quota->charged_from
is frozen.

If the pause lasts for more than LONG_MAX jiffies (e.g., about 24.8 days on
a 32-bit system with HZ=1000), will system jiffies wrap past the half-range
limit of the unsigned long type relative to the frozen timestamp?

If this wraparound occurs, time_after_eq(jiffies, quota->charged_from +
interval) would evaluate to false when unpaused. Would this cause the quota
window to not reset for another 24.8 days, accumulating charged_sz and
blocking the scheme from being applied?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260323231538.84452-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260323231538.84452-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
