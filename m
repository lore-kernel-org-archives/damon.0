Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A21F874C;
	Wed, 17 Dec 2025 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015552; cv=none; b=LoCQ04Nd2wcaYZU3uVjyWP3tylf7FZlYXqNZy/POarfabVSZ5i+0dfYqWhLfbP3NeoKJ6vLYwicBb9kLIS/T9skqtGZqGWYbNBeNxgV4kd3qrXyyKkRvExznCm7R0939LG4GZhZcmUza3lzRi1MLaViLfbrroZcQPQVl9KRdjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015552; c=relaxed/simple;
	bh=XT8meyHBHOL7oQLxt33J3A3bJJUsQVWtW+JbMwaJIwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8i8xwZnua5mbsCrqoyM8M0anA6txF9RvJ53I78Tpu5WdnSdX9ZpVlOU4zPWIGvSZpge3VsrvdpIlk/2nqdeH28TNcZyBZQeLmTxVUX9fJCeEVoaAp9zSOch2txlK6Tld4C9FKyA7FHf9h82cZ2DuMLD24qfD8c73S+PVv54FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxY0KrN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxY0KrN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C026AC4CEF5;
	Wed, 17 Dec 2025 23:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015551;
	bh=XT8meyHBHOL7oQLxt33J3A3bJJUsQVWtW+JbMwaJIwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxY0KrN/CWK4Xcio6Nf/3PIx+7iKCUBoGYm2WQFrc5T8ayzRzPy9ieGpFWs6TV6/y
	 5jGiCgMTU+5AvcyqMob7f4T325xnTmsVzEkdecj5/Byb83zq9bCioTSEK3Va+NFNef
	 6hlTmRW0H3CXr477ASBYpyg3Z4uHozV5Px783jsPhDg2rEAmwPh38OB1FkqaNNb+u+
	 DZJFq+lAKnoIYfoWPscPJpd4gQggUYJ4N8KdOW61A6U4d8ojPD9qmp+TC3YrGz/Zyp
	 hlysZWshFhFScj+7G/AlqGgPW8w8z9jsqYj5QweevH4c3F8zeiTFllGJ0Hi9Op4qFL
	 Bj2cDzR7RJK1g==
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
Subject: Re: [PATCH 12/12] mm/damon/core: add trace point for damos stat per apply interval
Date: Wed, 17 Dec 2025 15:52:18 -0800
Message-ID: <20251217235219.2750-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217174851.28e7c4e5@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Dec 2025 17:48:51 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 16 Dec 2025 00:01:25 -0800
> SeongJae Park <sj@kernel.org> wrote:
> 
> > +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> > +			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> > +			"qt_exceeds=%lu nr_snapshots=%lu",
> 
> Nit, but it's been stated that strings should not be broken up because of
> the column limit.

I also found checkpatch.pl shows warning for that.  I was ignoring that since I
was thinking that's just a recommendation.  But as I got more than one warning,
now I'd like to fix this.

Andrew, could you please add below attaching fixup patch?

> 
> > +			__entry->context_idx, __entry->scheme_idx,
> > +			__entry->nr_tried, __entry->sz_tried,
> > +			__entry->nr_applied, __entry->sz_applied,
> > +			__entry->sz_ops_filter_passed, __entry->qt_exceeds,
> > +			__entry->nr_snapshots)
> > +);
> > +
> >  TRACE_EVENT(damos_esz,
> >  
> >  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 8908aec6670f..68dd2f7acba2 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2256,6 +2256,22 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  	quota->min_score = score;
> >  }
> >  
> > +static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
> > +{
> > +	unsigned int cidx = 0, sidx = 0;
> > +	struct damos *siter;
> > +
> > +	if (!trace_damos_stat_after_apply_interval_enabled())
> > +		return;
> 
> Other than that, from a tracing POV:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you! :)


Thanks,
SJ

[...]

=== >8 ===
From 67a7762ee1ade258c53913ea4ecf9bafd4746ea9 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 17 Dec 2025 15:42:06 -0800
Subject: [PATCH] mm/damon: do not break the string for damos_stat tracepoint

The format string for damos_stat tracepoint is broken up to multiple
lines.  Strings shouldn't be broken up due to the column limit, though.
Update the string to be put on a single line.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 24fc402ab3c8..bf25ee07cb48 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -40,9 +40,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
 		__entry->nr_snapshots = stat->nr_snapshots;
 	),
 
-	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
-			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
-			"qt_exceeds=%lu nr_snapshots=%lu",
+	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu qt_exceeds=%lu nr_snapshots=%lu",
 			__entry->context_idx, __entry->scheme_idx,
 			__entry->nr_tried, __entry->sz_tried,
 			__entry->nr_applied, __entry->sz_applied,
-- 
2.47.3

