Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B181A9B48
	for <damon@lists.linux.dev>; Thu,  5 Jun 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137115; cv=none; b=VAYufqhduA6kZJypJ4mTRKXD546+TfR7fIAA6QzZTEsObNUUu6Gev+plLzCtXATH3BPXqXiwxyKQR6Zzfw7ty4570gJxM09ZWxGtyy4+olIoCedHFH6LEbzqG4qIB48d7eD+aLcqwfqTyjogPhJBjKKATxsmuvQtlDJLZ+kpopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137115; c=relaxed/simple;
	bh=loOlydsc2oqR1PmkPJcTiOSrXoBbZcznqk/ta78EMF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+gqsXMnOH+/CyR+SeCrejY+2KkawXqO3Ts5kwUf/we1PbLw8ttKAenADAknCd7CL/MixcLgtli3Vk9nsn0cOMxZ9iEyI2sHs2oTLtNZUDEMVzUiNBpqYq3VWYj0wXjVLeo2rLTiLNA0palV8o7QRWrjQRjUeBy0yYAKFsDfnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkV53kY5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkV53kY5"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e302191a3so9613807b3.2
        for <damon@lists.linux.dev>; Thu, 05 Jun 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749137111; x=1749741911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hywIa1C5VWmiWv5K8Y4aCyROkM0KVWGznJdti4Qv9UY=;
        b=PkV53kY55LieNOzxoYr5mxkN+X91xk7R1ps5c/Ht6Vuv1EadC/d1y8xw18cq7EI/o2
         NEgG9Bih7YRSY0VYfflwvb0LL9R86YsqEN4xJHUTK5wWUh6zSz7IsNv7Ao5s8+j3gZgh
         P0p9Oq7HcNnviRdYQIsJisSzS8BUjUMMxJISlRhdZM7VSRg556ymIQoFUJKmIBU/7Xkl
         P120O3SojeG6emSKaDXTD3+BBWw33z1EHdZAtajVdOOHihgDQb0O27ttEN2PzQFmNfLA
         AOaqDQ1fBko/iep/Uoct6ZcitHhLJY0adXcqR1Y0eisSDAxtDKWjmahaoH2kD8n/PIIB
         7rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137111; x=1749741911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hywIa1C5VWmiWv5K8Y4aCyROkM0KVWGznJdti4Qv9UY=;
        b=LAR1VdZLzjw4yLaCJLAdjDHJ4btSyxq7uIBkcNR9bFr4B0dXQEKZF1ianBGFr5dku2
         JPvgAnLBjz3tf0tuxmi90cBd1lA/B53KlffSVbGkyTcdcvE66FOmdCkpAg37QJB3UQ+P
         e6k1JpjEbuome3oyvuI4SLB5GRbCsE2bRV9P/DaepO+BOFK91q4oKfNf7DWUPPPM1dmP
         kC/9lY9qiV2NizgHF1I6KwmbmY8rzu/ZDnqVaA2b6cvzyfcbKCHW4t1Op01LlovuFXJd
         9B+O+6gRFmq7eecxrfAxmDpdwt6aA0NKZLYLh2akMIB+D8xDKmy9paLhtpeR3FzjXNif
         AjDA==
X-Forwarded-Encrypted: i=1; AJvYcCXes7I3ktxkfGxCXk2A64daomVRI9eQA/2gjJ9k2IDmOQV/BqfHq8/2TZwu4KFR7payw3vU+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLkZoR1yfaWfShyIKsi1LRX6MGwy+Fx6ocFC2coGP31AlyV1Nt
	/+jXNlb04F3Uziu4RDEqMP/6t9B/cek6JgZhp+HOQ/S4y6Ct2U8or39+
X-Gm-Gg: ASbGncvOBNww6CLRESSovS6PE/g+7bxpfrsnS5Nb09cYJReB6Cgp9hzmGswp/USlsHN
	8KgdPOMcq7lM895mLjHGwsnxcbflKm4bqWacLxjRPxEt7qOV1Zi6I1/7onRWDZ5Cjy4ZiekxsB6
	IjQ7JeixkX3J4PlnPgXmPnjrcCK4v3xu3wNyRicRIDwrdgCvHO1wvtJonV5WzieF82LnU+I63RD
	51DuKxJSt3jwqkoym6pSLcCwN/BdNMeMOTUnbOfayPcb65vDWE4r44xbU0RhcAirzJU1N8qUwIg
	Kx91l6Vx6tJ7ZAg5R6eNdEk++AzSJQRmEKxmyfvj1/Z5tDBjDw==
X-Google-Smtp-Source: AGHT+IFKgP5b3rRmeu100Vg2csRRR2cxN4MyQ8g5gK0KVrLhsIwOxgu/whtgrI5JrALBQh9eixFOvA==
X-Received: by 2002:a05:690c:84e:b0:710:e9b1:485f with SMTP id 00721157ae682-710e9b15030mr33158717b3.20.1749137110770;
        Thu, 05 Jun 2025 08:25:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ad25be6sm35189437b3.122.2025.06.05.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:25:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/damon: introduce DAMON_STAT module
Date: Thu,  5 Jun 2025 08:25:07 -0700
Message-ID: <20250605152508.3275113-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250604183127.13968-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Jun 2025 11:31:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> To use DAMON for monitoring access patterns of the system, users should
> manually start DAMON via DAMON sysfs ABI with a number of parameters for
> specifying the monitoring target address space, address ranges, and
> monitoring intervals.  After that, users should also wait until desired
> amount of time data is captured into DAMON's monitoring results.  It is
> bothersome and take a long time to be practical for access monitoring on
> large fleet level production environments.
> 
> For access-aware system operations use cases like proactive cold memory
> reclamation, similar problems existed.  We we solved those by
> introducing dedicated static kernel modules such as DAMON_RECLAIM.
> 
> Implement such static kernel module for access monitoring, namely
> DAMON_STAT.  It monitors the entire physical address space with
> auto-tuned monitoring intervals.  The auto-tuning is set to capture 4 %
> of observable access events in each snapshot while keeping the sampling
> intervals 5 milliseconds in minimum and 10 seconds in maximum.  From
> a few production environments, we confirmed this setup provides high
> quality monitoring results with minimum overheads.  The module therefore
> receives only one user input, whether to enable or disable it.  It can
> be set on build or boot time via build configuration or kernel boot
> command line.  It can also be overridden at runtime.
> 
> Note that this commit only implements the DAMON control part of the
> module.  Users could get the monitoring results via
> damon:damon_aggregated tracepoint, but that's of course not the
> recommended way.  Following commits will implement convenient and
> optimized ways for serving the monitoring results to users.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---

Hi SJ, thank you for this patch! I have been looking forward to it : -)
I had a few questions about the init function:

[...snip...]

> +static int damon_stat_start(void)
> +{
> +	damon_stat_context = damon_stat_build_ctx();
> +	if (!damon_stat_context)
> +		return -ENOMEM;
> +	return damon_start(&damon_stat_context, 1, true);
> +}
> +
> +static void damon_stat_stop(void)
> +{
> +	damon_stop(&damon_stat_context, 1);
> +	damon_destroy_ctx(damon_stat_context);
> +}
> +
> +static bool damon_stat_init_called;
> +
> +static int damon_stat_enabled_store(
> +		const char *val, const struct kernel_param *kp)
> +{
> +	bool is_enabled = enabled;
> +	int err;
> +
> +	err = kstrtobool(val, &enabled);
> +	if (err)
> +		return err;
> +
> +	if (is_enabled == enabled)
> +		return 0;
> +
> +	if (!damon_stat_init_called)
> +		/*
> +		 * probably called from command line parsing (parse_args()).
> +		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
> +		 */
> +		return 0;

I was hoping you could educate me about how damon_stat_init_called works here.
I think my confusion comes from my lack of knowledge about kernel modules : -)
In the cover letter, you wrote that DAMON_STAT is a static kernel module.
My understanding was that this would mean damon_stat_init would always be
called, so I was wondering under what condition it would not be initialized.
I see the comment you wrote above, but was still a little bit confused.

Also, should we perhaps call damon_stat_init() if !damon_stat_init_called?
That way, the first caller would just eat up the time it takes to run
damon_stat_start().

One other thought I have is that if this config checks for whether
damon_stat_init was called, this can be moved to the beginning of the function
before the other checks are run, but that is just my thought : -) Feel free
to keep the input check first, since having this at the beginning of the
function would mean incorrect inputs would be silently ignored.

Thank you SJ! I hope you have a great day!
Joshua

> +	if (enabled)
> +		return damon_stat_start();
> +	damon_stat_stop();
> +	return 0;
> +}
> +
> +static int __init damon_stat_init(void)
> +{
> +	int err = 0;
> +
> +	damon_stat_init_called = true;
> +
> +	/* probably set via command line */
> +	if (enabled)
> +		err = damon_stat_start();
> +	return err;
> +}
> +
> +module_init(damon_stat_init);
> -- 
> 2.39.5
