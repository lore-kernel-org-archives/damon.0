Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47AFC0A;
	Thu, 14 May 2026 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717220; cv=none; b=fg+Uyurz3UDcdxesOY/iIZAk+wTDxLuSIcdM39U2oF/8RzLam+2G1yfrReawifkR4ZZOf/sOSGVWRo1Bs+y/HpB8okhLhIV0C/uokGY1K486j62xAtPsXLeUW+9+G2zBRZYBzVpcQSZZX2tRShgdMDkbeYLDso16/4qRE2NY+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717220; c=relaxed/simple;
	bh=DWVNCpyyXtijugIs1t5TkZJG/znt8BoX/RA4gIbC7nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5FS+59/1sVbDsgC3kJpV33BHCJYkmkIfSmGWvnOSI9aMwOdoLRQHnxx6hr+JdNw1Td96v7MOS/jS887Stkg8xPZi0gIYgbtlQ5EpC/0MMs81qJcM3Qz376r356LvbY68STKgQq94xelFo0asms+R8ApfoYMNQBAzZff4CxJdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBq66Qra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBq66Qra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F3C19425;
	Thu, 14 May 2026 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717219;
	bh=DWVNCpyyXtijugIs1t5TkZJG/znt8BoX/RA4gIbC7nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBq66QraZzrbe5XdmdxhQXuV+x3xo87BOW5PwtTKnsZF5cZjBT0Dd0aFJPNxPc91s
	 HnbIdR4iAlzocR04Pr3jLgM58xMltMZP+RpCHN6PbkgGrH3sXkzeZ/yu3c6RRYXV9E
	 4o3PzZ/ctIr4yvs8dr2G+6YBOQ71cpUX3lJyvtyvl7Dk07z1t1wvXMk+85sdOYnATN
	 0u1pFzfC3HsWEpEY7yWC/DgtPoXPcPdqunQznk4hbuKEFPY9oMPlvLJx8d53BxuNWk
	 G2gyml0sZhOVP430eoyy6YawFbmTOlLMVd15w+pDwZjS80uK1tcHexVqpkFVpqasbr
	 BE9FwtRXq4R1w==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 18/28] mm/damon: trace probe_hits
Date: Wed, 13 May 2026 17:06:10 -0700
Message-ID: <20260514000611.147809-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513140732.2320c563@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 14:07:32 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 12 May 2026 07:36:33 -0700
> SeongJae Park <sj@kernel.org> wrote:
> 
> > Introduce a new tracepoint for exposing the per-region per-probe
> > positive sample count via tracefs.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/trace/events/damon.h | 36 ++++++++++++++++++++++++++++++++++++
> >  mm/damon/core.c              |  7 +++++++
> >  2 files changed, 43 insertions(+)
> > 
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > index 7e25f4469b81b..d7b94c7640217 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -130,6 +130,42 @@ TRACE_EVENT(damon_monitor_intervals_tune,
> >  	TP_printk("sample_us=%lu", __entry->sample_us)
> >  );
> >  
> > +TRACE_EVENT(damon_aggregated_v2,
> > +
> > +	TP_PROTO(unsigned int target_id, struct damon_region *r,
> > +		unsigned int nr_regions, unsigned int nr_probes),
> > +
> > +	TP_ARGS(target_id, r, nr_regions, nr_probes),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(unsigned long, target_id)
> > +		__field(unsigned long, start)
> > +		__field(unsigned long, end)
> > +		__field(unsigned int, nr_regions)
> > +		__field(unsigned int, nr_accesses)
> > +		__field(unsigned int, age)
> > +		__dynamic_array(unsigned char, probe_hits, nr_probes)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->target_id = target_id;
> > +		__entry->start = r->ar.start;
> > +		__entry->end = r->ar.end;
> > +		__entry->nr_regions = nr_regions;
> > +		__entry->nr_accesses = r->nr_accesses;
> > +		__entry->age = r->age;
> > +		memcpy(__get_dynamic_array(probe_hits), r->probe_hits,
> > +			sizeof(*r->probe_hits) * nr_probes);
> > +	),
> > +
> > +	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u probe_hits=%s",
> > +			__entry->target_id, __entry->nr_regions,
> > +			__entry->start, __entry->end,
> > +			__entry->nr_accesses, __entry->age,
> > +			__print_hex(__get_dynamic_array(probe_hits),
> > +				__get_dynamic_array_len(probe_hits)))
> > +);
> > +
> >  TRACE_EVENT(damon_aggregated,
> >  
> >  	TP_PROTO(unsigned int target_id, struct damon_region *r,
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fe6c789f2cecb..14b15c9876516 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1905,6 +1905,11 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
> >  {
> >  	struct damon_target *t;
> >  	unsigned int ti = 0;	/* target's index */
> > +	unsigned int nr_probes = 0;
> > +	struct damon_probe *probe;
> > +
> > +	damon_for_each_probe(probe, c)
> > +		nr_probes++;
> 
> Is the above logic needed when the tracepoint isn't enabled? If not, then you could add:
> 
> 	if (trace_damon_aggregated_v2_enabled()) {
> 		damon_for_each_probe(probe, c)
> 			nr_probes++;
> 	}
> 
> And change the tracepoint to be a conditional tracepoint:
> 
> TRACE_EVENT_CONDITION(damon_aggregated_v2,
> 
> 	TP_PROTO(..),
> 
> 	TP_ARGS(..),
> 
> 	TP_CONDITION(nr_probes > 0),
> 
> 	[..]
> 
> And then the tracepoint is only triggered if nr_probes is greater than zero
> (to handle races between the tracepoint being enabled in between the above
> check and where it triggers).

It is not needed when the tracepoint isn't enabled.  I will follow your
suggestion in the next revision.  Thank you for the nice suggestion, Steven!

Btw, if you don't mind, may I ask your opinion about the name having '_v2'
suffix?  I chose that as an RFC phase temporal name that doesn't break the
compatibility, planning to give it a better name later.  But I start feeling
just extending the original one might be another option because tracepoints are
not strict stable ABI to my understanding, and the change of the TP_prink
format should be simple enough (append the probe_hits= part) that the user
space could reasonably deal with.


Thanks,
SJ

[...]
