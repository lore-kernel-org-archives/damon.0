Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBF3A641D
	for <damon@lists.linux.dev>; Wed, 13 May 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696220; cv=none; b=bwxLBpHrcPM/gK94/7Wy3gEN6OAIuF6xRurbdE/9ezCtXZBsi+f72ziiautXQxMxPmjHVWaYx6JCrwEEYQgqOiNqIiUr/BkhrYf8I+V8w6RjzygIwCoIUwHB4YRqhqHv38qDFo7sVUZ8U2J58eBpPKbrTd76TNjkEH5tRWLik4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696220; c=relaxed/simple;
	bh=3eu9Hg1j+FAo9YvctV0nbejroN4dG4a8dt3M+wCUcng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEuvolnxDvp+eggY2uS7ctD83UTJAmQhas4M7jkK4gheT0gGslKhwn9e/iM9TpuT411wlHnj33VgNws2Sy29JInxTjO3qAjZPk+SzMSBA6U8YknVnGP2R4FxwrJ16eE6F5OzJEMQ6n1FZFzric0lkbi5Uy0ydCC9JD8k8NGvkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8304B4041D;
	Wed, 13 May 2026 18:07:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9F6C220029;
	Wed, 13 May 2026 18:07:28 +0000 (UTC)
Date: Wed, 13 May 2026 14:07:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 18/28] mm/damon: trace probe_hits
Message-ID: <20260513140732.2320c563@gandalf.local.home>
In-Reply-To: <20260512143645.113201-19-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
	<20260512143645.113201-19-sj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9F6C220029
X-Stat-Signature: 19k3hjixp4ddabd59xf647tdn9ssb7x4
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XR4QBARvilo/iw685qO7EjLUbgY33/3Y=
X-HE-Tag: 1778695648-519701
X-HE-Meta: U2FsdGVkX1+ztHJmbfencz8xskODMPGeCvM+5KKPEYCOFkZBK3DuVA72UQFXfLA2XiaCC1Lrd1TX827gLdPa0yRorEbvVLdnpgaP2F6PcYA57+G4DIsUo7ibScB41ACkwFPSMhmAucYTH00cudknJWH82uLgSDwtPpeXU/Pj4tC+S2F9GUC+0Mv+7Ta3YfAIhlYEMpS0vOK/oevVn/aRifCol3JS+mYZCoMZETyhMcyLWwaV5oT8PfG6LVCWLAHVKsG2gBZvSvI+/RzaE3AkdWg1hUsxpeVQfdTpEWUS0oQwAc84hFbgw8SZW3sCglk3BduJb90ng6hopBuHSDsK1pjZFYjAOl8d

On Tue, 12 May 2026 07:36:33 -0700
SeongJae Park <sj@kernel.org> wrote:

> Introduce a new tracepoint for exposing the per-region per-probe
> positive sample count via tracefs.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/trace/events/damon.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/damon/core.c              |  7 +++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 7e25f4469b81b..d7b94c7640217 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -130,6 +130,42 @@ TRACE_EVENT(damon_monitor_intervals_tune,
>  	TP_printk("sample_us=%lu", __entry->sample_us)
>  );
>  
> +TRACE_EVENT(damon_aggregated_v2,
> +
> +	TP_PROTO(unsigned int target_id, struct damon_region *r,
> +		unsigned int nr_regions, unsigned int nr_probes),
> +
> +	TP_ARGS(target_id, r, nr_regions, nr_probes),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, target_id)
> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
> +		__field(unsigned int, nr_regions)
> +		__field(unsigned int, nr_accesses)
> +		__field(unsigned int, age)
> +		__dynamic_array(unsigned char, probe_hits, nr_probes)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->target_id = target_id;
> +		__entry->start = r->ar.start;
> +		__entry->end = r->ar.end;
> +		__entry->nr_regions = nr_regions;
> +		__entry->nr_accesses = r->nr_accesses;
> +		__entry->age = r->age;
> +		memcpy(__get_dynamic_array(probe_hits), r->probe_hits,
> +			sizeof(*r->probe_hits) * nr_probes);
> +	),
> +
> +	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u probe_hits=%s",
> +			__entry->target_id, __entry->nr_regions,
> +			__entry->start, __entry->end,
> +			__entry->nr_accesses, __entry->age,
> +			__print_hex(__get_dynamic_array(probe_hits),
> +				__get_dynamic_array_len(probe_hits)))
> +);
> +
>  TRACE_EVENT(damon_aggregated,
>  
>  	TP_PROTO(unsigned int target_id, struct damon_region *r,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fe6c789f2cecb..14b15c9876516 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1905,6 +1905,11 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
>  	unsigned int ti = 0;	/* target's index */
> +	unsigned int nr_probes = 0;
> +	struct damon_probe *probe;
> +
> +	damon_for_each_probe(probe, c)
> +		nr_probes++;

Is the above logic needed when the tracepoint isn't enabled? If not, then you could add:

	if (trace_damon_aggregated_v2_enabled()) {
		damon_for_each_probe(probe, c)
			nr_probes++;
	}

And change the tracepoint to be a conditional tracepoint:

TRACE_EVENT_CONDITION(damon_aggregated_v2,

	TP_PROTO(..),

	TP_ARGS(..),

	TP_CONDITION(nr_probes > 0),

	[..]

And then the tracepoint is only triggered if nr_probes is greater than zero
(to handle races between the tracepoint being enabled in between the above
check and where it triggers).

-- Steve

>  
>  	damon_for_each_target(t, c) {
>  		struct damon_region *r;
> @@ -1913,6 +1918,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  			int i;
>  
>  			trace_damon_aggregated(ti, r, damon_nr_regions(t));
> +			trace_damon_aggregated_v2(ti, r, damon_nr_regions(t),
> +					nr_probes);
>  			damon_warn_fix_nr_accesses_corruption(r);
>  			r->last_nr_accesses = r->nr_accesses;
>  			r->nr_accesses = 0;

