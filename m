Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87D2264CD;
	Thu, 18 Dec 2025 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027057; cv=none; b=TNv742oAV1mCKlfN6kkNlBg+t5gxioQXiuY420uBn22x7KE0h6jGeuwd6gfw/71sieJnT17Pm1oZseoUxMxHLcYnYuJSxxECS13Mrvd0c7yOMieSjnpgqVFTtx8ghLOxK34O1kNDu3ioiA4xLGwLge/FYfFhSf9Fwo0upVmnEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027057; c=relaxed/simple;
	bh=fIOlKKCnG/5B5Z3soMSjJpqMLZXmgSydiOBzsThgWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXXxhYKTYXATaobNl8W6ExaNceB0mGs/ZDlCLr/H59ADXHMTR36NLCxSK1oeMUzAS61C7xJxsIR8nmvXmGG8GGtPF4lQcvpAPN63HNZmITmfNMgJt8TVcVKtzVCPlJM8M02mpPmLDZfh2ymABxM9YyZ9YzyfMGCZu4eKGIotDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0/U53yT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0/U53yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0752FC4CEF5;
	Thu, 18 Dec 2025 03:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766027056;
	bh=fIOlKKCnG/5B5Z3soMSjJpqMLZXmgSydiOBzsThgWAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0/U53yTSDyUYyG5Mbm/KrpRxeea/kzHgl/WvWWjpuYFgjLcssAzMIB6LNJdxsOq9
	 6XhHprjY6ckdMunFWf8k0dpIjYDz1e7FXpUYaC5DMk9GBDViDhpXuqO+v7xgyJYtHx
	 DOrZovSU9EQO4nK12mrfWTvOs7vq/g7M6wfQKeJ+//PmC+G8fC5hlj8KE9tg0crcAi
	 H6UyF7nVPTbfg72NRovBNGsU95pe4p/W6CxKIBjwrxQITI3wxw/p1wZleoSvyRYpWo
	 kQdH5ykILJoAIiS5ev6DLuWxrAQQLij6JdorJWK2BDeLhbTUw7KU2NNRQDYrPkox0h
	 59PohI9Bb8flg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] mm/damon/core: add trace point for damos stat per apply interval
Date: Wed, 17 Dec 2025 19:04:11 -0800
Message-ID: <20251218030411.42049-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217182915.5284d66b58ac7b744b8dcf7f@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Dec 2025 18:29:15 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 17 Dec 2025 15:52:18 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Wed, 17 Dec 2025 17:48:51 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Tue, 16 Dec 2025 00:01:25 -0800
> > > SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> > > > +			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> > > > +			"qt_exceeds=%lu nr_snapshots=%lu",
> > > 
> > > Nit, but it's been stated that strings should not be broken up because of
> > > the column limit.
> 
> screw the rules
> 
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -40,9 +40,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
> >  		__entry->nr_snapshots = stat->nr_snapshots;
> >  	),
> >  
> > -	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
> > -			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
> > -			"qt_exceeds=%lu nr_snapshots=%lu",
> > +	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu qt_exceeds=%lu nr_snapshots=%lu",
> >  			__entry->context_idx, __entry->scheme_idx,
> >  			__entry->nr_tried, __entry->sz_tried,
> >  			__entry->nr_applied, __entry->sz_applied,
> 
> because that's just crazy.  Let's use some judgment here!

I'm fine with either direction.  So I understand you want to just keep the
original patch without this fixup, and therefore no action is needed from my
side?  Let me know if I'm getting anything wrong.


Thanks,
SJ

[...]
