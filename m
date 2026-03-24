Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAD239567;
	Tue, 24 Mar 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311947; cv=none; b=NHqj27Mm9nMydIrSpgkXpmcjmmi6ppLtSuvT9jDcv3yyB23I89M0PxBSfoLBqUfjCk2hD4DarxLKr/yBn6vZELPBGz/7iwZtDwBHBzgB35XutQF90Rr9U9vZdFljRKJ9CdDBSKTJNJRz/rFO7tAlfn8MelK/XFtYH+klP7VAvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311947; c=relaxed/simple;
	bh=K7+w1Fe9eVXYmmVzI1WINbAfUoX6r6BuzBux9UJ7NPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfCMfhCF1KhGFYimXas/kpFZzzBg+6DZ0D4wqP/HBtYWMDfwNzVgsBAbUTrxZor60drfuSKSoUwhecs4wYQ57ah5/WopDbF/7MKNkaqAluCnlwYZWRHHGPMf69Ym+NzPUTQwhMT81RhQrRtjGYtZoThbeXaYAEFh/ZlfufZtXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD3ueE6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD3ueE6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9B1C4CEF7;
	Tue, 24 Mar 2026 00:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311947;
	bh=K7+w1Fe9eVXYmmVzI1WINbAfUoX6r6BuzBux9UJ7NPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mD3ueE6mb1Bx2mCTdm6xu/sxfD3MhzSfGAhGevRfyBy5nSd/p7utIBitWgQiSitpJ
	 7Bqv9dXQjZYmLQzpShhTba0qFCUvYUiCmGwSbJo3JrfPrb0DTziobc2z482XQ/ka8X
	 jC4w9Han9+xoL1f/aq/skh4N1O64wlLm090GOvWeFIxh20hPHEQbA2fUTsCZPe8ILU
	 UcvJZ7dhc7JVJdLKImfVFqbPuH0I8vrwBpCvv0lJFCTUCTVPMnWIwBABiw1qxnccR5
	 FEmo1TMDmans/VWwQiAUYXchVAniYNKyIuGeUFE0NToPHe55fgNpuxd4r41hzQvSA8
	 nxTJ75J2aHVlg==
From: SeongJae Park <sj@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: SeongJae Park <sj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/19] mm: damon: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 17:25:45 -0700
Message-ID: <20260324002545.86416-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323160052.17528-19-vineeth@bitbyteword.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 12:00:37 -0400 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:

> Replace trace_damos_stat_after_apply_interval() with
> trace_call__damos_stat_after_apply_interval() at a site already guarded
> by an early return when !trace_damos_stat_after_apply_interval_enabled(),
> avoiding a redundant static_branch_unlikely() re-evaluation inside the
> tracepoint.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
