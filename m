Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB71361DA6
	for <damon@lists.linux.dev>; Sun,  4 Oct 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105036; cv=none; b=ciYymeF+ONMbg2cxZzBh2sAOevkmYYz/eGdJwXnx874ydWCf1wbo1cv22eoOYGBxF3aGi9mtV04xO6Awv/jcYOp3RiUtgFHhoKnmWjGtiGB42MobvT8gbqGYF7dVO8p9DLO9MdGzQicoJm7CuRcmygTeHg0vzRWZWIaoXXc/Sg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105036; c=relaxed/simple;
	bh=z094i4HwymZDFDjVYu2c8pz9wi8tggyQHLFBSq9quEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqO1gd2SNdv12FpzzLRVCKLq8+f3vJA1E9W/3iX1VcVw5kKOHZ+cQiiiw88w2oEvQcVWGnpnipkNjm5sPZF25GiraYnPzr9AqHoYmzqxqvAGSKoj15imqFpH3Rk3Fba8SF0EZJKLmqbHNOru0WC27NohhxFbOpqsGv69atSDSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0zoFdCH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0zoFdCH"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88b7d853b11so329271b3a.1
        for <damon@lists.linux.dev>; Sun, 04 Oct 2026 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791105034; x=1791709834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn1knN0Ne9g7tVudusR3tVlb1NSZVYCjpb+Hy/EfMyI=;
        b=X0zoFdCHku9Ht2KFycC44o7gurPnNuPfyKKyqGhpBxn0UolyFpXQOQ+J8EAJGDp6O9
         pDTPS1fUeotYtjh6A1YqPLG+gkNiQ2hh0yjmnUqlytTvzcv0gMmVQsW2QjyjYIKHdKWI
         0ZxaOixRMxLLafcJr4IADCQUh+ubhltrFf52xelB3D3KzFjvL32NYK76m8Q+OnXEInCf
         LnzKLZ2AngG+DdAuGM3ND5J2BcJLuRzqz/wGrALsIf2PlDF5q0iZ6RPelNwQzsRsGM8q
         AtGVPS7dJ1WKx3yOnict+ipQ2PYwD12+7RAd/CYyKTP6Ynw6Xzn+xr2kjNW45em0b6yU
         RgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791105034; x=1791709834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hn1knN0Ne9g7tVudusR3tVlb1NSZVYCjpb+Hy/EfMyI=;
        b=JnxI66U1fS2UIQtUtJlqbXjZj28fdNqyKtFB3oKhQowmlDXDDc8egO8qtEtFqwAHPQ
         CH5rWu2zueFBFLq4dUcetTMcwSpA3TfBz4TwRun8OPmOPn4wCjU2QQzww8ScquVeYVP3
         FDppYAvgNNBIfDOFcUPjekoM3/n/rs3JJye5N2YQaF6+FBSadGDro97DrxE4S+SgidGq
         rugl0WwN9nFteqW3tKZ3nM0iovq39PzmENoVoct1LmIxWqepkE4/Ehav4mItk9P/wpdn
         tiXzR5H4f60r71zKYdIY8jkeh8OyWOOMoK4Vzsln6lxc0yLkxV0joYpBPct9fD0tPDWo
         9piQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEXXg86Wr5cCBIWzWgtM6SjllRtbSv7KULTbjzsIbLlrKDpVmn//Pw7FcJZDjjMtnBSYYfsw==@lists.linux.dev
X-Gm-Message-State: AFuF++mXa33X9H8XNR7yCaXEiZay3RVXhQoz0NPiaBMc7d9+pgFhsxsR
	8XlotrOBpGsN1a72k+/n0xOpVfsDaKKaigTd/v+tqMkfxitBGAvguQ73
X-Gm-Gg: AYBFou32vNd5uo+nOgJ3pRe1AwptxEcwiCQ0LpAQY6JNJN66O809E+U2cTZXvqC8eiZ
	eu/UfCTl/4DZ66D4BmsfkmaYFhS0lS8cX5SBnl28QaFxtfSrsw44AKNOJFo273UeT/oReUaQ45t
	4HJDUMLSVMx9xp5wsCgzgmgga90aKUs3eIdp3Xw6dLjHHJ5vfV03AMrFLKaBkf827qoSpXtGEuD
	m0mDcpHErhduvy9i9Pix+y+BrmZ1OF+a2qzH7x3KWJhF4fywfyp0NklM+nVzuRrK3lNUmNmc0jf
	kDXog7BJ/vCiONeXiRi8oqqSJuh3k6T5hvJBnVJUgXcJbxfr6xcEhBkPjIa/jb0YPrBXpsbVoh1
	LWGWMIxn8cVfRsHhdk7LM2bt7TixDA5c/BHeYMqZIQG7lFZZH02AzmIlqMhu+1T1pssz3QBkQYF
	iPsAgFxVh360jPRUlMh02LFyWYxGQ7NtW+cufmIHlLo9Tx0tFWQbiBkslR1AmAVuK8TH1g
X-Received: by 2002:a05:6a00:14d0:b0:88b:af3d:2891 with SMTP id d2e1a72fcca58-88c628fca60mr3777134b3a.22.1791105033760;
        Sun, 04 Oct 2026 02:10:33 -0700 (PDT)
Received: from gmail.com ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0ca7c6b7sm2374693b3a.44.2026.10.04.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:10:32 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	David Rientjes <rientjes@google.com>,
	Wei Xu <weixugc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report buffer with per-context rings
Date: Sun,  4 Oct 2026 17:10:21 +0800
Message-ID: <20261004091023.630362-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 14:07:55 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

[...]
>  
> @@ -2519,30 +2662,107 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
>   * damon_report_access() - Report identified access events to DAMON.
>   * @report:	The reporting access information.
>   *
> - * Report access events to DAMON.
> + * Report access events to DAMON via a per-context per-CPU SPSC lockless ring
> + * (ctx->perf_rings).  Producer is the local CPU (typically NMI from a
> + * hardware-sampling backend); consumer is the kdamond drain in
> + * kdamond_check_reported_accesses().
> + *
> + * The destination ring is selected by this_cpu_ptr(), i.e. by the CPU calling
> + * this function, not by @report->cpu, which is sample metadata used by the
> + * drain-side filter.  The two coincide for a sample delivered by an interrupt
> + * on the CPU that produced it.
> + *
> + * A backend whose PMU writes a record stream into a memory buffer instead of
> + * raising a per-sample interrupt, or one reading a device counter table, must
> + * therefore decode CPU N's buffer on CPU N -- for example by queueing per-CPU
> + * work with queue_work_on() -- rather than calling this function in a loop
> + * from one thread.  A single-thread loop puts every report in that thread's
> + * ring, which caps machine-wide capacity at DAMON_REPORT_RING_SIZE - 1
> + * reports per drain regardless of the number of producing CPUs, and does not
> + * satisfy the single-producer invariant if the thread can migrate.
> + *
> + * Context: any (NMI-safe).  An NMI nesting on top of a process-context
> + * producer on the same CPU would otherwise stomp the same entries[head]
> + * slot; the busy guard detects and drops in that case.
>   *
> - * Context: May sleep.
> + * If the ring is full, the sample is dropped and the per-CPU ring-full
> + * counter incremented; a busy-guard drop increments the busy-drop counter.
>   *
> - * NOTE: we may be able to implement this as a lockless queue, and allow any
> - * context.  As the overhead is unknown, and region-based DAMON logics would
> - * guarantee the reports would be not made that frequently, let's start with
> - * this simple implementation.
> + * Return: true if the report was queued, false if it was dropped.  A producer
> + * holding a single report may ignore this.  A producer decoding a batch out
> + * of a hardware buffer should stop on false and leave the remainder in that
> + * buffer for the next round, since a report released from the buffer but not
> + * queued here is not delivered.
>   */
> -void damon_report_access(struct damon_access_report *report)
> +bool damon_report_access(struct damon_access_report *report)
>  {
> -	struct damon_access_report *dst;
> +	/*
> +	 * Only perf-event reports (probe_idx >= 1) have a ring to feed: the
> +	 * global page_fault ring this dispatch also fed has been removed.
> +	 * A probe_idx == DAMON_PROBE_IDX_NONE report has nowhere to go and is
> +	 * dropped here rather than at each caller.
> +	 */
> +	struct damon_report_ring *ring;
> +	cpumask_t *pending;
> +	int __percpu *busy_pcpu;
> +	unsigned int head, next;
> +	int busy;
> +	bool queued = false;
> +	struct damon_ctx *pctx = report->ctx;
> +
> +	if (report->probe_idx == DAMON_PROBE_IDX_NONE)
> +		return false;
>  
> -	/* silently fail for races */
> -	if (!mutex_trylock(&damon_access_reports_lock))
> -		return;
> -	dst = &damon_access_reports[damon_access_reports_len++];
> -	/* just drop all existing reports in favor of simplicity. */
> -	if (damon_access_reports_len == DAMON_ACCESS_REPORTS_CAP)
> -		damon_access_reports_len = 0;
> -	*dst = *report;
> -	dst->report_jiffies = jiffies;
> -	mutex_unlock(&damon_access_reports_lock);
> +	/*
> +	 * A perf report must carry its owning ctx (set by the overflow handler)
> +	 * and that ctx must have an allocated per-ctx perf ring.  If either is
> +	 * missing (e.g. an overflow racing teardown after the ring was freed, or
> +	 * a report raised before the ring was allocated), drop the sample rather
> +	 * than touch NULL/freed storage.
> +	 */
> +	if (!pctx || !pctx->perf_rings || !pctx->perf_ring_busy)
> +		return false;
> +
> +	/* Pin to a CPU so the SPSC invariant holds for preemptible callers. */
> +	preempt_disable();
> +	busy_pcpu = pctx->perf_ring_busy;
> +	busy = this_cpu_inc_return(*busy_pcpu);
> +	if (busy != 1) {
> +		/* NMI nested on a process-context producer; drop. */
> +		this_cpu_inc(damon_report_busy_drop_perf);
> +		goto out;
> +	}
> +
> +	ring = this_cpu_ptr(pctx->perf_rings);
> +	pending = &pctx->perf_pending;
> +	head = ring->head;
> +	next = (head + 1) & DAMON_REPORT_RING_MASK;
> +
> +	if (next == READ_ONCE(ring->tail)) {
> +		this_cpu_inc(damon_report_ring_full_perf);
> +		goto out;
> +	}
> +

Hi Ravi,
 
I noticed that ring overflow drops reports and updates an
internal counter.

Since hardware sampling is used as an access observation source,
could userspace get any indication that reports were lost during
an aggregation window?

Without such visibility, users cannot distinguish an aggregation
result affected by report loss from one collected without loss.
This may make it difficult to evaluate the reliability of the
observed access information.

Thanks,
Kunwu

[...]

Sent using hkml (https://github.com/sjp38/hackermail)
