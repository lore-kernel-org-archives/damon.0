Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8F3128D9
	for <damon@lists.linux.dev>; Mon, 24 Nov 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997311; cv=none; b=W+9iN8O0XmegSScbB00YxDN/7H/VMuNKsiIAOOr2CgM4sPkKVxlmNaT4Nv1JL3NJJZUhKnKHXPZ59/A1alc4GzfaXYVIRDSm7IhO61EXtHOmYaThs4YDLCwy0zmxovGmG53zGNcmTp/nMdcl6xIMvPDpwmimVXzyeF2OtAhhILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997311; c=relaxed/simple;
	bh=wbsUIStRu/I8l+W7EEAADPQP6bZYzpJBz5TxnbpLenw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJYoaH8Z6H48gO6XRA5vTyCOL0vAnqvHd94/Xr8hatb/IxUeH3odPPo4lN+LG8hjtVciKmaPxMZ8tKD3xk/m2S8Clb3vp76BJOjHDCVCC3Cy6vYvA+ZGgzWa3qOR5dHgXlKtG5N90W3ExTzRQQl5hQWLWKe4oWckmYXnwAZ1hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9D7021305FE;
	Mon, 24 Nov 2025 15:15:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 916DB2001C;
	Mon, 24 Nov 2025 15:15:04 +0000 (UTC)
Date: Mon, 24 Nov 2025 10:15:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 12/12] mm/damon/core: add trace point for damos stat
 per apply interval
Message-ID: <20251124101545.0250445c@gandalf.local.home>
In-Reply-To: <20251123184329.85287-13-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
	<20251123184329.85287-13-sj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 916DB2001C
X-Stat-Signature: amgdopewak89z9b311nn95u1tetxutom
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mhiH+8yhU3rLNz0uC4XgLk5UTtfo2JA0=
X-HE-Tag: 1763997304-799272
X-HE-Meta: U2FsdGVkX1+nRZEW3e6XwJCJw6tJDlTKHwyHh7MykKmgcEJOcruyi41RFB+KBqDeklnJ8td/Dao+47YI27tMFW18xY7bwX7sLkzK1IIT689x9RsrYeGaP3UUFuTL04sSMlYXa+Ce41PehX79Q2WGOMbgNtPvvxOoMp44prXMClJZ/utaM5/rtQ+wkE6fnJrcCI9aEnee8FIgEtEENWxsH5teOKLh3CVKGD/PL3jKQqaWrRw7umcNDuXejN0GQqre+e1tsMIxI05twQiF+lCh0mdon2sr4k8AasnaZvGoSJwdgQPnGF5WkCU20LW7Ab7EQAjo9K9647YCoQYb7jX9ckSn+MjKVbGw

On Sun, 23 Nov 2025 10:43:26 -0800
SeongJae Park <sj@kernel.org> wrote:

> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2256,6 +2256,19 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  	quota->min_score = score;
>  }
>  
> +static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
> +{
> +	unsigned int cidx = 0, sidx = 0;
> +	struct damos *siter;
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
> @@ -2294,6 +2307,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  			(s->apply_interval_us ? s->apply_interval_us :
>  			 c->attrs.aggr_interval) / sample_interval;
>  		s->last_applied = NULL;
> +		if (trace_damos_stat_after_apply_interval_enabled())
> +			damos_trace_stat(c, s);
>  	}
>  	mutex_unlock(&c->walk_control_lock);
>  }


I wonder if the above would look better (and still produce good assembly)
if it was:

static inline void damos_trace_stat(struct damon_ctx *c, struct damos *s)
{
	unsigned int cidx = 0, sidx = 0;
	struct damos *siter;

	if (!trace_damos_stat_after_apply_interval_enabled())
		return;

	damon_for_each_scheme(siter, c) {
		if (siter == s)
			break;
		sidx++;
	}
	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
}

static void kdamond_apply_schemes(struct damon_ctx *c)
{
	struct damon_target *t;
> @@ -2294,6 +2307,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
			(s->apply_interval_us ? s->apply_interval_us :
			 c->attrs.aggr_interval) / sample_interval;
 		s->last_applied = NULL;
		damos_trace_stat(c, s);
	}
	mutex_unlock(&c->walk_control_lock);
}


I have no real preference. I just think keeping the "if ()" statement out
of the main code as a more aesthetic look. But the above should be
equivalent in actual functionality.

-- Steve
