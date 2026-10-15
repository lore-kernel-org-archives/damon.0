Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481F52D2BC;
	Thu, 15 Oct 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073435; cv=none; b=Cq1fktmuiRu9if/rquPE1aCgMMwfEW/FgB8Mu09Xq5Kw9naOsG2K9bv/KfBl0m+N+vflBiUQElD+x3wBwTR11XtxC7irRxRhVC9z71EXFLeIedEb5GTdUIymvBAbD1XVKY8JO3T/oVGfoysH9uPprllnSBY0cveBhVz16w+GO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073435; c=relaxed/simple;
	bh=/rRNvbyBKx/ONVB+rr8Kp8zapP5zgWCD5/ujc1KNYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHYIS4D4cLmiM/A6BIfHO5dIF6ha/i8ZizpC2OEmMSxob/FR87jXdeEAJGLoRzCFX3qEYP4l/ZxsaYi9NLuxLVSI4VyAVnYv4G23neo5+UV2EMG6g0L0oDvtAQJ2H0MCJd9IVyzT+V56Jqyr967ELx4yDJ7l85QD5d0+wnVgkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMCS2YTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMCS2YTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB30F1F000C4;
	Thu, 15 Oct 2026 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073434;
	bh=SnejWl8mRfWCD5JUDxQovY6ZIaJqGSRZlxKQNmpxKmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMCS2YTkoe7BKnA15EF+5Ouqg+UGP8EXI/UmIwlG7kZH47vSKuIbWwLOYBdN/yWr/
	 2Ci0WE4eT61jRLjAnNOi+Jsi1vhsvOINexjtV9gL/FFTByv44w8VSAMyljmKIoJlJq
	 2pdKUmDH87tN4fgsrNnrSV3CSvm8K9IBzFj5UUseztEEJmPy+Tdwbw8AMPAIwxj7Kr
	 /GEIZrjfcSWWd1gCkHv1sIs2hdEWqzoAawfA69A6sbDmYbh3NeHrEzGbzVhzjHHBkX
	 7jP7PPcHZ+UdI7bWavdZve6qwFHZn4gEFWo0cFd51vX/U23IrOpM3T+bik/p3Im6Zc
	 kYTyo7plDoxJw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON: 32-bit overflow selects wrong sampling interval
Date: Thu, 15 Oct 2026 07:10:26 -0700
Message-ID: <20261015141027.88149-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmFkTQMEpR10sxjoB+8XMsk=m9DAJVnyxguwV2LLYCg09A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Avelin,

On Thu, 15 Oct 2026 07:24:08 -0400 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi,
> 
> In an unmodified i386 QEMU kernel built from mm-new commit
> ad9f2d463666, an intervals goal selected a 2500 us sampling interval
> after the first aggregation.  The same trace inputs give 2812 us with
> full-width arithmetic.
> 
> The kernel has CONFIG_DAMON_VADDR, CONFIG_DAMON_SYSFS, and tracing
> enabled.  The guest monitored a 1 MiB VADDR range as four contiguous
> 256 KiB regions, with sample_us=5000, aggr_us=100000, access_bp=400,
> aggrs=1, and min_sample_us=2500.  The default minimum of 5000 us would
> hide the difference.
> 
> At the first aggregation boundary, the four damos_before_apply records
> for kdamond.0 showed nr_accesses=1,1,1,3.  The next
> damon_monitor_intervals_tune record showed sample_us=2500; sysfs then
> reported sample_us=2500 and aggr_us=50000.  The records cover the same
> four 262144-byte regions before the first tune.
> 
> For that aggregation, the inputs to damon_get_intervals_score() are:
> 
>   max_access_events = 4 * 262144 * 20 = 20971520
>   access_events     = (1 + 1 + 1 + 3) * 262144 = 1572864
> 
> On 32-bit unsigned long, max_access_events * access_bp wraps before
> division by 10000.  This gives a target of 409364, a score of 38422 bp,
> and the observed interval of 2500 us.  With full-width arithmetic, the
> target is 838860, the score is 18750 bp, and the interval is 2812 us.
> The later mult_frac() remainder multiplication does not overflow in the
> observed 32-bit path, so the difference here comes from the target
> multiplication.
> 
> The affected expression is in mm/damon/core.c.  Widening only the
> target product would make the later 32-bit mult_frac() remainder
> multiplication overflow for these same inputs.  The 2812 us result
> requires sufficient width throughout the score calculation.
> 
> The 2500 us interval was measured on the unmodified kernel.  I
> calculated 2812 us from the trace; I have not tested a patched kernel.
> The i386 config, guest init, serial/trace log, and build/run steps:

Could you share more details of your use case that this setup is needed and the
overflow becomes a problem?


Thanks,
SJ

[...]
