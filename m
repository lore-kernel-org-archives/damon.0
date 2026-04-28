Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF151F91E3
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400262; cv=none; b=fhwEqV/c4vd9fkRDPWsmELHLhgYfXR1afZ/vCPqnIAvGQdL/TOMq1FBYf7QqgFgffIdOT49Z7MAOVrqCuP9fyYKLRHzniOSvluuUuEKmvuENCqYcHGByx93jeblqH/PMxRb0JNZWlXXOm5+S0LK3Zg4f4UKdDLm6t4hXGyQnSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400262; c=relaxed/simple;
	bh=yeVIOEXWH/h8E/dAgplrYdddJ0r7xb6W8lVN0rTehos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMeYjry3jloLkVL23l49lUXKr1x20uWmfeWlUTx/RWDrIU4BOeTCThdwRcwwGVFxeWrzE4Oqibao92mbxt11Q7xcUMay7XfHLtzVizVe8AmMqjdcr6Eit+Sr8+dXDd2AXu/ZF7kMZCHjnzf16bkYpkhnSiz8OxsA9lpjzH5Z32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 96048A037B;
	Tue, 28 Apr 2026 18:17:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id B6A0A20031;
	Tue, 28 Apr 2026 18:17:30 +0000 (UTC)
Date: Tue, 28 Apr 2026 14:17:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 16/19] mm/damon: trace probe_hits
Message-ID: <20260428141745.2768ac4e@gandalf.local.home>
In-Reply-To: <20260426205222.93895-17-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
	<20260426205222.93895-17-sj@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B6A0A20031
X-Stat-Signature: e3i1brrmasxojtp1wgmca31nxz3q5k5x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2Osv/VST2loy+Q+wM/zb0ziB5zHmuJEc=
X-HE-Tag: 1777400250-143348
X-HE-Meta: U2FsdGVkX1+bOhY2GUWBxPcY0f3n9bSlRQ7NuAetINkmFXIEGE2P9gN5Ej4aestJw38OPx0baBgt/25PZZiE1VB7EyJyVdibhz94N2EKrHHHp6tuowqYE8VCZbpHEw/D0EOmMIBs4F9LubjByTQmJfZpgEBAo4NQJL+qDTomlf2ORvwaj7k0514hYstjvguJs4RyFO5EzIYxhv7JlyI9w70DByjAEA9oxNeEMIG3iBuxxVlP8yu++K+1gtiRHFsRN28XhBtorRFmqvQlBbm0Zr7Gr+UXH3Kc5VeMY62oeRXqhRkY8tM6U/zxDAwuGlXgJNvyApVE9pf/3HSXPetovkIPwD6fR8kx

On Sun, 26 Apr 2026 13:52:17 -0700
SeongJae Park <sj@kernel.org> wrote:

> Introduce a new tracepoint for exposing the per-region per-probe
> positive sample count via tracefs.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/trace/events/damon.h | 41 ++++++++++++++++++++++++++++++++++++
>  mm/damon/core.c              |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 7e25f4469b81b..121d7bc3a2c27 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -130,6 +130,47 @@ TRACE_EVENT(damon_monitor_intervals_tune,
>  	TP_printk("sample_us=%lu", __entry->sample_us)
>  );
>  
> +TRACE_EVENT(damon_aggregated_v2,
> +
> +	TP_PROTO(unsigned int target_id, struct damon_region *r,
> +		unsigned int nr_regions),
> +
> +	TP_ARGS(target_id, r, nr_regions),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, target_id)
> +		__field(unsigned int, nr_regions)

Move the nr_regions to after "end" as on 64 bit machines, this creates a 4
byte hole.

-- Steve


> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
> +		__field(unsigned int, nr_accesses)
> +		__field(unsigned int, age)
> +		__field(unsigned char, probe_hit0)
> +		__field(unsigned char, probe_hit1)
> +		__field(unsigned char, probe_hit2)
> +		__field(unsigned char, probe_hit3)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->target_id = target_id;
> +		__entry->nr_regions = nr_regions;
> +		__entry->start = r->ar.start;
> +		__entry->end = r->ar.end;
> +		__entry->nr_accesses = r->nr_accesses;
> +		__entry->age = r->age;
> +		__entry->probe_hit0 = r->probe_hits[0];
> +		__entry->probe_hit1 = r->probe_hits[1];
> +		__entry->probe_hit2 = r->probe_hits[2];
> +		__entry->probe_hit3 = r->probe_hits[3];
> +	),
> +
> +	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u %hhu %hhu %hhu %hhu",
> +			__entry->target_id, __entry->nr_regions,
> +			__entry->start, __entry->end,
> +			__entry->nr_accesses, __entry->age,
> +			__entry->probe_hit0, __entry->probe_hit1,
> +			__entry->probe_hit2, __entry->probe_hit3)
> +);
> +
>  TRACE_EVENT(damon_aggregated,
>  
>  	TP_PROTO(unsigned int target_id, struct damon_region *r,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fe14971d72747..54834b74efef4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1924,6 +1924,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  			int i;
>  
>  			trace_damon_aggregated(ti, r, damon_nr_regions(t));
> +			trace_damon_aggregated_v2(ti, r, damon_nr_regions(t));
>  			damon_warn_fix_nr_accesses_corruption(r);
>  			r->last_nr_accesses = r->nr_accesses;
>  			r->nr_accesses = 0;

