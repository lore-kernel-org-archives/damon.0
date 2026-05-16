Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486ED223702;
	Sat, 16 May 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778952675; cv=none; b=aw9HVcDgAAmPKSLdRffex6PiOaIkkTQMtemUlUvw21KyTh3YRSck93D7OuWjwZhs1AJfNjXLtVCn34Eq6XxjG35YjJXGP/QRbYLRb27pEV9St9p2HHh4ThkaE1xTQ4DR3uum8wChh0Qm5xfigmeYdDjyfDGpdaMhZO81ZweGTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778952675; c=relaxed/simple;
	bh=SNjjBidjzGKmfFde6yETBzWsMij61VKv2/xFwvTci5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK0J3302Yz+iv3EvZGFbWfT5QwT+e0cY7sC9gWBk8AjTQfnG+uF+fE4mCYLpIOhSGZ67fAvypIS/Wvp5F2N6FmIC1blUDOInp2Giaug6ptxDj+fnPHlDjbBWoCHgSmn9dvrPP/nbZ9GOELW4TYs8lIq85GzJa2HGQhiUYxFzLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdVaVsiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdVaVsiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F966C19425;
	Sat, 16 May 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778952674;
	bh=SNjjBidjzGKmfFde6yETBzWsMij61VKv2/xFwvTci5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdVaVsiOs2AYfzYCT64op6Zw2Ix0z1WF45QeXlhK/Jp7zuJkH4WIptL9JveJwcZx1
	 Lv7+zYdDbReHDrQKj/NRqwOerCWJGINJHywQJuplNIQrwFQ8eYzWBlmm5R40IFxfzw
	 n4xtwkrf80pCahA+TLzOqvlalNaXSMqSVq57JBoPAGvdJ3Cy/LNbdFwMi4iapYR3V5
	 tWmiJUujo8xyYRQO8KkBtD8qFm6VRFQhvPFrSsr13KcHH8r3viH1/wDQeKT1PbdrJv
	 G5SWlNpaG1EhBARy5opvq+2ITZ7OoeWG9xzDFQfqIP77X5JPD/OljeyMm0ZVpldRsh
	 BiCik1NSgu2Dw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2.2 18/28] mm/damon: trace probe_hits
Date: Sat, 16 May 2026 10:31:06 -0700
Message-ID: <20260516173107.148242-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-19-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 17:44:19 -0700 SeongJae Park <sj@kernel.org> wrote:

> Introduce a new tracepoint for exposing the per-region per-probe
> positive sample count via tracefs.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/trace/events/damon.h | 38 ++++++++++++++++++++++++++++++++++++
>  mm/damon/core.c              |  9 +++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 24fc402ab3c85..ec1e317923fd3 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -130,6 +130,44 @@ TRACE_EVENT(damon_monitor_intervals_tune,
>  	TP_printk("sample_us=%lu", __entry->sample_us)
>  );
>  
> +TRACE_EVENT_CONDITION(damon_aggregated_v2,

I was thinking [1] about a better name of this tracepoint.  I will rename this
to 'damon_region_aggregated'.  And I will deprecate damon_aggregated, with
multi phase, like we did for DAMON debugfs interface.  The idea off the top of
my head at the moment is,

1. announce it as deprecated on the document, by end of 2026
2. rename it (e.g., damon_aggregated_deprecated) by end of 2027
3. removing the code by end of 2028

The deprecation might be done faster than the current idea.

As Steven commented [2], it should be ok to immediately removing it or
extending it to have probe_hits.  But I realize I'm quite lazy at DAMON
user-space tool development, and feel more comfortable on this approach for
now.  Please let me know if anyone has a different opinion.

[1] https://lore.kernel.org/20260514000611.147809-1-sj@kernel.org
[2] https://lore.kernel.org/20260513203237.3b1b3286@gandalf.local.home


Thanks,
SJ

[...]
