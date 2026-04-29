Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2240DFC4;
	Wed, 29 Apr 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421622; cv=none; b=ZHrjx31ZsccqpukvncfZPiWeGfiEgxI/BkhDuWbwHYemAmGBt0uKOAcfDCN+9Z4pgDOoizaChIPCO0Gj1YnXQCDpsZw2dBvbCPGuXC1SCl4cM4lTluS8c/lf8B7oNsu3qW6h5eAXp9TKgmlbpf1h7baqrM3s9ExQwjossW9kSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421622; c=relaxed/simple;
	bh=OxmIeCCg0CwmYbh/3fPPpRuqH6P3pcR0ENAMgCFSCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8oHxWIGD60zDf8jFJd7sw/8JCOqGfVuGAGGsArlHeL/nwUeqq9jP7O0XsOktTLYJRWzO5RzcpqMgsyiDYGK6HRn7LBWdDVLlWtQURCZ9vapRVq7RkQuQavcZ1X6cobm309h8JUGcYlfrNGOR1brHrrD0GzG/7dX76BQO6PnPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwuCmpdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwuCmpdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46380C2BCAF;
	Wed, 29 Apr 2026 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777421621;
	bh=OxmIeCCg0CwmYbh/3fPPpRuqH6P3pcR0ENAMgCFSCzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwuCmpdIFTQLWCOwVJwEStk/0AxZ0Cq/yTDCN/4bjXHY00QJqzyCxY5h+CdjvC5ib
	 8YEGg2H0+fbl/63Dclp5eE9LM9C/pi4QiHiWGHiydf8El+gBHt9lUq1LGIy1Wdpepa
	 KCeU5gSakA3ZhorIhXZlJWi0iCuj3rVNHlt2lVcgwhxZ/XclmvedPQaJAuylQ+mSV5
	 ESG3RAP5HlvUFmb3MngOOgkaFNkuKGVCzZGCrndw9e/U6vRr+PxzoQJjNUbMkaqL/m
	 zhQYXjq+wZRA36l6yWZo4ycDWrMNsENbPiwlEtVRE+fcLIsBiBgNqziobYUBRz9adT
	 4IQnv60M9O6Fw==
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
Subject: Re: [RFC PATCH 16/19] mm/damon: trace probe_hits
Date: Tue, 28 Apr 2026 17:13:31 -0700
Message-ID: <20260429001333.87439-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428141745.2768ac4e@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 14:17:45 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 26 Apr 2026 13:52:17 -0700
> SeongJae Park <sj@kernel.org> wrote:
> 
> > Introduce a new tracepoint for exposing the per-region per-probe
> > positive sample count via tracefs.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/trace/events/damon.h | 41 ++++++++++++++++++++++++++++++++++++
> >  mm/damon/core.c              |  1 +
> >  2 files changed, 42 insertions(+)
> > 
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > index 7e25f4469b81b..121d7bc3a2c27 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -130,6 +130,47 @@ TRACE_EVENT(damon_monitor_intervals_tune,
> >  	TP_printk("sample_us=%lu", __entry->sample_us)
> >  );
> >  
> > +TRACE_EVENT(damon_aggregated_v2,
> > +
> > +	TP_PROTO(unsigned int target_id, struct damon_region *r,
> > +		unsigned int nr_regions),
> > +
> > +	TP_ARGS(target_id, r, nr_regions),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(unsigned long, target_id)
> > +		__field(unsigned int, nr_regions)
> 
> Move the nr_regions to after "end" as on 64 bit machines, this creates a 4
> byte hole.

Thank you for the nice suggestion, Steven.  Will do so in the next version.


Thanks,
SJ

[...]
