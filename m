Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD5403B0A
	for <damon@lists.linux.dev>; Sun,  4 Oct 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105887; cv=none; b=uTZ07l4llPycDwiCcXsMn6ulmxgBNrlJ35mZIa9QYgiEHQIz4Qjtzo5oCKYJLfSN7j6uNWbbIUvfVIA+Uia+6ZVbOmso8TmPRCUPscG1JD1mBrMgl03QxoUcMNhBIyVwxVoXQR8HRERc4vBGNzWDRKwlV9wzUi501IDs7IZSZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105887; c=relaxed/simple;
	bh=+J9cCeIO2vZjSIoP+Vt7+45zvy9SPpS6EtPIbmekiII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mceqmRBOoxmkxmlXwINc7svAmLYduSqpakwRpAQTxXx6KoJ51eX6BXcwErSfsQBh1eWbt+mXiCVtjxmTMFKlE5AjCrTwwnLO2dnHYyIPBQQWaPCzReKQfcjvkmoF187maRxZKRlci/F1pj+NEbDwwlRogh+mPviJ1ysTNGClN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=UaAwM2oO; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="UaAwM2oO"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 520041403DA;
	Sun,  4 Oct 2026 09:16:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 952BC2000E;
	Sun,  4 Oct 2026 09:16:35 +0000 (UTC)
Date: Sun, 4 Oct 2026 05:16:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SJ Park <sj@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>,
 Ajay Joshi <ajayjoshi@micron.com>, Honggyu Kim <honggyu.kim@sk.com>,
 Yunjeong Mun <yunjeong.mun@sk.com>, Akinobu Mita <akinobu.mita@gmail.com>,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Message-ID: <20261004051632.71726836@fedora>
In-Reply-To: <20261003202727.3673-1-ravis.opensrc@gmail.com>
References: <20261003202727.3673-1-ravis.opensrc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 952BC2000E
X-Stat-Signature: pdnhjatf6s6ij17ydsy69bt89bu8db99
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++plVshDREp1/65N9g55w+NMnmWqeBIxk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pcvJ+jCMAJmM0AnDK31466hqGai5ZVEENzn8YaAuejw=; b=UaAwM2oO6Vs0SeMXPz9kGc9q2fLKlKqmTw2H6rdSRsVD7Bo3aKpXTFvZwlh8zK+OBavXEnlpEi7YD/bU73MDV7p3sQWLPNmQGBupb04v0nderDm+bKHdQrtF9R0ql3HM0DJZerIz3v2no7DchRC2AEsGq0RF9wRsTHh9R7uqfVg=
X-HE-Tag: 1791105395-87746
X-HE-Meta: U2FsdGVkX1/sZ6OkXRl1d895imVbao+eFLq8ZGKTfRYFYqpekrSfk5wwPwGOUTd2Evu4vjL39RNPNr1q9lyU/bShTeEnB+bay1dplCDNECqxSPE0grBiXKG6VZWzuWaKoXV8/P7qmITFW4J+8W4GZlZ6oLk1M+ke2NLS1vWCusYRRVTXHVRGKXQIV3zxlFfP22BVG7l6crUFxIQtjMIEJFOW43D9ETpxzPqLu1stTZaZSZTgbNe24ZHoL6TasLei/52xnMp3KyhxuEDDyfXrvxEM0KPXCWRZyjjLkLcMKCke0GT95/Nvuu1kU50fq5uOSfUjuVm4exp3hZAh+V7TLSl2m7tUZL4H/fw6n1YdYVSUzkLx2DqIAw==

On Sat,  3 Oct 2026 13:27:27 -0700
Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> evaluation.  The tracepoint fires once per quota-score computation when
> the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> context_idx, scheme_idx, nid, target_value, and current_value.
> current_value is reported as the quota tuning sees it, after the goal's
> complement setting is applied.
> 
> The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> occupancy as basis points of eligible bytes.  This information is not
> exposed through any existing external interface (perf stat, /proc, or
> sysfs), so the tracepoint is the only way for userspace to observe the
> target and current eligible-memory basis point values at quota-scoring
> time.
> 
> Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> ---
>  include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
>  mm/damon/core.c              | 16 ++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 8851727ae162..2c7249cc7c88 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
>  			__entry->esz)
>  );
>  
> +/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
> +TRACE_EVENT(damos_node_eligible_mem_bp,
> +
> +	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> +		int nid,
> +		unsigned long target_value, unsigned long current_value),
> +
> +	TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, context_idx)
> +		__field(unsigned int, scheme_idx)
> +		__field(int, nid)

Can you move the nid after the two unsigned long values below. This
creates a structure, and on 64bit machines, this adds a 4 byte padding
in the middle of the ring buffer.

> +		__field(unsigned long, target_value)
> +		__field(unsigned long, current_value)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->context_idx = context_idx;
> +		__entry->scheme_idx = scheme_idx;
> +		__entry->nid = nid;
> +		__entry->target_value = target_value;
> +		__entry->current_value = current_value;
> +	),
> +
> +	TP_printk("ctx_idx=%u scheme_idx=%u nid=%d target_value=%lu current_value=%lu",
> +			__entry->context_idx, __entry->scheme_idx,
> +			__entry->nid,
> +			__entry->target_value, __entry->current_value)
> +);
> +
>  TRACE_EVENT_CONDITION(damos_before_apply,
>  
>  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b63e60ef8990..6ddd15dc4f55 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
>  		highest_score = max(highest_score,
>  				mult_frac(goal->current_value, 10000,
>  					goal->target_value));
> +
> +		if (goal->metric == DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP &&
> +		    trace_damos_node_eligible_mem_bp_enabled()) {

If you move the trace_damos_node_eligible_mem_bp_enabled() before the
goal->metric check, you will save yourself a branch when tracing is
off. As the trace_*_enabled() is a static branch (nop or jmp) it has no
cmp branch, but the above will keep the goal->metric still exposed. By
swapping the two compares, the goal->metric check will be hidder behind
the 'nop' when tracing is disabled.

-- Steve


> +			unsigned int cidx = 0, sidx = 0;
> +			struct damos *siter;
> +
> +			damon_for_each_scheme(siter, c) {
> +				if (siter == s)
> +					break;
> +				sidx++;
> +			}
> +			trace_damos_node_eligible_mem_bp(cidx, sidx,
> +					goal->nid,
> +					goal->target_value,
> +					goal->current_value);
> +		}
>  	}
>  
>  	return highest_score;
> 
> base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4

