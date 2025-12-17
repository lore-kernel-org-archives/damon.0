Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6532E757
	for <damon@lists.linux.dev>; Wed, 17 Dec 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766011641; cv=none; b=TgpZZ4sRsdk2Lx/GfDzHSMeiwrsFf+ISWrMzoe3WthD8WoCeZiSRh+stbM0jOaw+F4VxpE6F/NFx8MQsm52VI1uMqFsqfkcn/qTbNGJti/rgVeJumMoxKGNI8snpXjP7dGjjj0PFOVaoD1FQ1PZeZZ/I8OgxJ4h+Ay2TPixBK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766011641; c=relaxed/simple;
	bh=mBDmvo/UgpbWiiG8tW6YeREcwgT6/ObiUeTIf2Cwb7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGZ73e2OE4ToINkSTRilum41pnP2lWT+KTOq9CsgTXI5eL7D7Oqv3gJTh4Xs+pfa0soEHB64jXkYcaXhAERgFhtQ8h1wna3YulL441t1s30jQ+lgzX2lPxW8TMI6mLrkkkAAGS5p+jAfNkSAtQYJ7G1o07yY0pk8VKa659mdVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E185CC0B70;
	Wed, 17 Dec 2025 22:47:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id DF9666000F;
	Wed, 17 Dec 2025 22:47:14 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:48:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/damon/core: add trace point for damos stat per
 apply interval
Message-ID: <20251217174851.28e7c4e5@gandalf.local.home>
In-Reply-To: <20251216080128.42991-13-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
	<20251216080128.42991-13-sj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 31nyrdsgbyo3jc4qijpnjctk1ajppz5e
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DF9666000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bc+vDXAMiNWjhwd8WTXdVmvD70vBch1k=
X-HE-Tag: 1766011634-141987
X-HE-Meta: U2FsdGVkX18mvS6jbpgv0E5a2gSLRq6NLU55D3C9EWyncyzvoX0mKuL02jKKo58zakJhkQ7o+AgV+P5jmb12/3c/lY5m6m6FGYrY7atlrnNtuwsAcQ7S0+o0dQ1OZxpyJ9k6vfRrgo4LQt6/BrfpvgRSiuBlJD+NdEgJ2vIEJrfzJok/dmnmxPR9jd2xuL/yM2kQmlaEzfRr/X5L0k4X4YYDeYV6CGFV4YXKHaiG9w+yEfcACHcD6/A96nfysseo8oQwFEmE3EkYLl5PhxIOALv3zw+osDvuBsPzil6CNXu2gxTuzMU4qSIrVBABNFzFUElPx4vM21qw5OigF3Jtd5SWOA9znJQ3gBlVxrnHcv+revjO1HKrG6B8ax0JQwjFCapC7uqtCyALpyv/K88TKQ==

On Tue, 16 Dec 2025 00:01:25 -0800
SeongJae Park <sj@kernel.org> wrote:

> +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> +			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> +			"qt_exceeds=%lu nr_snapshots=%lu",

Nit, but it's been stated that strings should not be broken up because of
the column limit.

> +			__entry->context_idx, __entry->scheme_idx,
> +			__entry->nr_tried, __entry->sz_tried,
> +			__entry->nr_applied, __entry->sz_applied,
> +			__entry->sz_ops_filter_passed, __entry->qt_exceeds,
> +			__entry->nr_snapshots)
> +);
> +
>  TRACE_EVENT(damos_esz,
>  
>  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8908aec6670f..68dd2f7acba2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2256,6 +2256,22 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  	quota->min_score = score;
>  }
>  
> +static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
> +{
> +	unsigned int cidx = 0, sidx = 0;
> +	struct damos *siter;
> +
> +	if (!trace_damos_stat_after_apply_interval_enabled())
> +		return;

Other than that, from a tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> +
> +	damon_for_each_scheme(siter, c) {
> +		if (siter == s)
> +			break;
> +		sidx++;
> +	}
> +	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
> +}
> +
>  static void kdamond_apply_schemes(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
> @@ -2297,6 +2313,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  			(s->apply_interval_us ? s->apply_interval_us :
>  			 c->attrs.aggr_interval) / sample_interval;
>  		s->last_applied = NULL;
> +		damos_trace_stat(c, s);
>  	}
>  	mutex_unlock(&c->walk_control_lock);
>  }
