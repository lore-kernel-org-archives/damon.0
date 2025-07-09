Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD4239085;
	Wed,  9 Jul 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085727; cv=none; b=V6xzRt5ygVtOgURnQJim7w4UMzn8hkCYkrzIueWc4a6xXYnEXZBj95GaGgH6jtlLGE+ZaM7NGIja/6FQz8U40ilwXxhxfIN5rnKENSn7nFcxLmUS1TvlUIXQH7rJTCWM14R1EDcBy92o5cmS+YB6NX9mHIBEY3hRtoQ53OtegYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085727; c=relaxed/simple;
	bh=9fdOdgXFqFowyzNU5tXxjS4uhBhKB/MS4gO9Omh2uak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPxzGhz5z0lMi33B+A9mKgCHFGF0XCP2jMgu9lspOeY4y7GVH7Maf8l2c2xq4I0iSTktRTJveiWgJqkEliCN9rz0i6asST58I86FILLz7LsFQMLuQilEoDwYYfNWgWXoVxqzEf3TR8rgI6u/K+bp23BFSgt4ltoTnN0P99UHGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQe5hD/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQe5hD/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBBFC4CEEF;
	Wed,  9 Jul 2025 18:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752085726;
	bh=9fdOdgXFqFowyzNU5tXxjS4uhBhKB/MS4gO9Omh2uak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQe5hD/Xy2KnOs/bQB0lEgW4j3mQDC4PfqWXL07vLm2IdbrLSoh1i8OS5yTv9I69G
	 HentD9Mbh4/GyVFaO/5UGpCitKYz2zIWnFvM4LdA2j0hnbCKTiN5vn78vF3oEtn57r
	 WUOC+ZjrXr6CgsbnSUxBMl80DM28klUBJYS8bcz6Q5/pHvC6BQS8DMMR3vFUOcyMA1
	 wnZZ3O2mR8i+1phLiwuqaOMhZ8rYXW5zDvcys/+O7fuyqaE7jdbOmN1bZE/9Nf5CTW
	 y/7u14FN1rLcV4/BNFXA1892o6y4j2x+hXZt9/4zChKhrW90fV5Z2a8ikf8XlO9a8g
	 NW4bbjPKdSiiA==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon: add trace event for effective size quota
Date: Wed,  9 Jul 2025 11:28:43 -0700
Message-Id: <20250709182843.35812-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709122123.779c874f@batman.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven,

On Wed, 9 Jul 2025 12:21:23 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  4 Jul 2025 15:14:08 -0700
> SeongJae Park <sj@kernel.org> wrote:
> 
> > Aim-oriented DAMOS quota auto-tuning is an important and recommended
> > feature for DAMOS users.  Add a trace event for the observability of the
> > tuned quota and tuning itself.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/trace/events/damon.h | 26 ++++++++++++++++++++++++++
> >  mm/damon/core.c              | 20 +++++++++++++++++++-
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > index 32c611076023..36b2cdf47dce 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -9,6 +9,32 @@
> >  #include <linux/types.h>
> >  #include <linux/tracepoint.h>
> >  
> > +TRACE_EVENT_CONDITION(damos_esz,
> > +
> > +	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > +		unsigned long esz, bool do_trace),
> > +
> > +	TP_ARGS(context_idx, scheme_idx, esz, do_trace),
> > +
> > +	TP_CONDITION(do_trace),
> 
> Please explain to me why you are using a conditional here?

There is no reason to make this conditional.  Maybe I was out of my mind.

[...]
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2011,12 +2011,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  	quota->esz = esz;
> >  }
> >  
> > +static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
> > +		struct damos_quota *quota)
> > +{
> > +	unsigned int cidx = 0, sidx;
> > +	struct damos *siter;
> > +
> > +	damon_for_each_scheme(siter, c) {
> > +		if (siter == s)
> > +			break;
> > +		sidx++;
> > +	}
> > +	trace_damos_esz(cidx, sidx, quota->esz, true);
> 
> It's set to true, so it's not even a conditional anymore. The compiler
> will likely optimize it out!

You're right.

Andrew, could you please add below fixup patch?


Thanks,
SJ

=================== >8 ======================
From 13975534cad603410837c5eca299f0a24ad802a1 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 9 Jul 2025 11:22:39 -0700
Subject: [PATCH] mm/damon: make damos_esz unconditional trace event

It has no reason to be conditional.  Make it unconditional trace event.

Fixes: 9a365a71b830 ("mm/damon: add trace event for effective size quota") # mm-unstable
Closes: https://lore.kernel.org/20250709122123.779c874f@batman.local.home
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 8 +++-----
 mm/damon/core.c              | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 2e4d7d281fa7..fc2c61ccc887 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -9,14 +9,12 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
-TRACE_EVENT_CONDITION(damos_esz,
+TRACE_EVENT(damos_esz,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
-		unsigned long esz, bool do_trace),
+		unsigned long esz),
 
-	TP_ARGS(context_idx, scheme_idx, esz, do_trace),
-
-	TP_CONDITION(do_trace),
+	TP_ARGS(context_idx, scheme_idx, esz),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, context_idx)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0f7d8b37c91d..775e097b6538 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2223,7 +2223,7 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 			break;
 		sidx++;
 	}
-	trace_damos_esz(cidx, sidx, quota->esz, true);
+	trace_damos_esz(cidx, sidx, quota->esz);
 }
 
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
-- 
2.39.5

