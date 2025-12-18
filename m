Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B62F7ADE;
	Thu, 18 Dec 2025 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024957; cv=none; b=a1FM1SukQiJofy4yBshepDA1tssKzZqCwS4uoJzCc4wmFTuZpkBjA0atNjfOQCUgLCvtXzSgmoaWb/HzAe7Degoy7mDWHZjCZkzKZi12slS6FseDlDaDmQnh895gQK/Rn+h2Wr+6028tHQosA/TV8AGSny2m2tQWMBpn/60r5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024957; c=relaxed/simple;
	bh=Ld07Vda6IixwRcRyakjPgYDvAjrVt2F9zTBIS04BOdY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KzKHEWW363F8BljTnyMLu9o12OJQuc3Hk9eulSB9phYt/uABstL22f+FXe6lbbpJmd9M1imcnNkUxbWK0FQm1kKR/koOY1NX32JhLA8AAiOmLVYBEjoJhtu9DD6cBP+DQBym8GIzSWVWpzYWgYXdhbYFk5xF3p7IruQ+1inhXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y1ikC2bI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y1ikC2bI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5579BC4CEF5;
	Thu, 18 Dec 2025 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766024956;
	bh=Ld07Vda6IixwRcRyakjPgYDvAjrVt2F9zTBIS04BOdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y1ikC2bI7zSdD4HUu5+e0WzHBTNPqUeFbYw2cjjAdX6LTJ8GH0U/PAYyDjUpBbpB+
	 5B+9gpClhr4QU/npEMxzNrCmTj1NPKjuaVqmyALxB91fEQ1f21FJWQpU4W+rRwc05a
	 n4xiIDZQEodQNF9YXi1vGsVTe84Q4nwSZXlqUUiM=
Date: Wed, 17 Dec 2025 18:29:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/damon/core: add trace point for damos stat per
 apply interval
Message-Id: <20251217182915.5284d66b58ac7b744b8dcf7f@linux-foundation.org>
In-Reply-To: <20251217235219.2750-1-sj@kernel.org>
References: <20251217174851.28e7c4e5@gandalf.local.home>
	<20251217235219.2750-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 15:52:18 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 17 Dec 2025 17:48:51 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 16 Dec 2025 00:01:25 -0800
> > SeongJae Park <sj@kernel.org> wrote:
> > 
> > > +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> > > +			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> > > +			"qt_exceeds=%lu nr_snapshots=%lu",
> > 
> > Nit, but it's been stated that strings should not be broken up because of
> > the column limit.

screw the rules

> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -40,9 +40,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
>  		__entry->nr_snapshots = stat->nr_snapshots;
>  	),
>  
> -	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> -			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> -			"qt_exceeds=%lu nr_snapshots=%lu",
> +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu qt_exceeds=%lu nr_snapshots=%lu",
>  			__entry->context_idx, __entry->scheme_idx,
>  			__entry->nr_tried, __entry->sz_tried,
>  			__entry->nr_applied, __entry->sz_applied,

because that's just crazy.  Let's use some judgment here!
