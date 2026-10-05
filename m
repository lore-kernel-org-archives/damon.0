Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758B45A288
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194692; cv=none; b=ZIWSrfGNFDvNeYpGMypZaguae+wYP3jjTBGT4UNK6a+oUiNpNzqSE4mKrVKfSfhNuCHQjFAzchOK+ziL30SoNL47z3mDd6zlg4kVZh1ylbhm0VG3T2ZuSebKnlaUqX/TdNkBwJSRDaEsDYa0KF9cWZKwUig1k0lNtcCtp+lGujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194692; c=relaxed/simple;
	bh=PmYaT0zZh5OYZT8BBZqIL+F0mR+bv6a4Ebmxc1vaLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlmp2liRp25H9/aK0cNGIGhO6xPrGygpT1SF8WSEmhC5uNt6498KQb3Z3oo0rmV/dcDbTg2pWlU7EziWYl3RF3+BfoCazF0g8RZ4If1v4jTKac7OSQ6UhHrmFsqHlnYkVIbTWIV2RGtd6c47hnwQoqtsulJHpUxRr7VRnJ05MEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/mmi0q6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/mmi0q6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a7d7287703so877745a91.2
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194685; x=1791799485; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndTgZQw5uRGHNOH8AqWMxH2rBGXg/PpSxnD0ym+93as=;
        b=N/mmi0q6XpOQtfdp6er8unGTX3DjxO6ZT0eaaOP+UFG+SSH1CiuluN6BPUo90og8ku
         kr99913kITfWuEd1tT9TIjkrwH5+ewlbvpNeE82cwBJgjNfz9t6kiiDDU3o0RC/4vUBf
         QNHDtqG/W9ieqqTTgezPijtMGJ+TTmYoTo6Z26J7htVa+M7xsmjtdUyIgf8o22Snbini
         4LH2EVFUWH+cLaGkiMi2W8xGSDgG7QrhR/V3XezHL54HS82dX7DLIiX2rmuZwhgljUc4
         rNnb5AR3yccYpVQ/ZFeSM6SjnGrb/oaR/73299db/tblPTaM1dkjzK7g1hSlltLZsu8n
         Vxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194685; x=1791799485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndTgZQw5uRGHNOH8AqWMxH2rBGXg/PpSxnD0ym+93as=;
        b=izFDh/GVX9yQb0qwVYMlXu+9dq1flT307E2MmTszvsPhkyr75TzTqpl1BewFkoGAec
         rtqA/OI9m/AOc2sXpoaEVRltiHREDToD+cU0xcSRTpEYUhsNMevdSLq8bB6+5Y2mYOzi
         siWaD40YTrKS3kzNq2ljJJhVuak/NIpurK6hG7wv3kfAyLagKR69Yaq+10baumpNdrtE
         q1uioQGdynBhV2qQ7wlVgKKxdIQ6AAutjrlJwjPBWQi6hPh73OfsOM7EbJEcuplzTUyf
         qrUQKuQrIrznINIzqRBjnjv7zw/+R3Y/TxfpzKeUTsTw+DO4yueqnOyH5YC9UJoTO3WS
         5OMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTrJcaBjMwPP3ieEQhWLstQZhwEyuD1CRmd1vutc+bqutTNh2W+nyJQI3gE7kaD9wFVtnmBA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKdtVtZYUCTOINeK7DktNJbsiIvAonireTT5jnPOhHS1fAVvnPM
	e9XYoupcyERCH+hs+UwLeHqaPWxKPWTk1iIzt6jwS+VMy8dVMq1ROKbC
X-Gm-Gg: AYBFou0SnCE5unn9dXrjyuaufNruwWJmqKsfhV7b2ZLy4Zvrai2oh4kuWCjtXkXQZvQ
	er/VQIJqIeupV4jjkjKqMQSI3/BWVk4YafS6V9a3EefwGVZXHsZVstHiE5Ev6GZGf+wvNrphkep
	poUTEmiNbX5fwTjhpjoGLW8Bttc00f/OArZ1Y7c85rz71WDmTBvFsCtsjKPToP9e1rbsESPFsqq
	3Vm1vhclOc0xuLyti6ds7AAnXU/Iuhh9upNeUVqenQ8JKXMqj1KWG1JUW2awHwTPW4y7Ni9+BnI
	fkSG7AqGkgzk0OV/4h24N8jcvOLwWjxVKbgJkNB8W3iU0L5/bAxp3saQWrDU/pOQA7AbLb6I+Ty
	56HHJuTyXvZx9z1KdR8atKHRDseASk6OhzDqdlZ2BJj6j0RBPogV4+s7Xe+VQ4wfb4Lozl4cGXm
	vih3ALRE8W22FGoxnCXJEKR4BMEYDPwCB7JDV11RGoQEYHE6JujSW8ZZ1CJaQ6grgnz4EZRrZUW
	qwH6Em4fbtC+usWUDk19g==
X-Received: by 2002:a17:90b:2752:b0:3a4:b0b9:6b3e with SMTP id 98e67ed59e1d1-3a7873d9565mr5545486a91.36.1791194684453;
        Mon, 05 Oct 2026 03:04:44 -0700 (PDT)
Received: from gmail.com ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4cd01asm10487467a91.14.2026.10.05.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:04:44 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Mon,  5 Oct 2026 18:04:29 +0800
Message-ID: <20261005100435.1211485-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003202727.3673-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Ravi,

I agree with SJ that this would be more useful as a general quota-goal
tracepoint rather than being specific to NODE_ELIGIBLE_MEM_BP. The
target_value and current_value fields are not metric-specific.

On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

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

The comment says "Per-tick", but the event is emitted for each matching
goal in damos_quota_score(). "Per quota-goal evaluation" would be more
precise.

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
> +		__field(unsigned long, target_value)
> +		__field(unsigned long, current_value)

Also, context_idx is currently always 0 here, since
damos_quota_score() only has struct damon_ctx * and no context index.
If this tracepoint is generalized, it may be worth considering how the
context/scheme are identified rather than introducing another tracepoint 
field that is currently always 0.

Thanks,
Kunwu

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
> -- 
> 2.54.0 (Apple Git-157)
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
