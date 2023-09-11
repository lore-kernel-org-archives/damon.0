Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4120EB
	for <damon@lists.linux.dev>; Mon, 11 Sep 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34974C433C7;
	Mon, 11 Sep 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694464604;
	bh=yVeFYLRhbU/RAZJ0Yo6GGmsolJbZL5KOh1ydQnNikFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n++o38YD9g0rkZTjGjoVS58Qce5RnDBBcRebGc0mzehPYzDGSOiYt3Ys8E7B6nEpV
	 grKF4Nv+NwZT1fhq1p+sIcuCTnWuzv39djNo42NCbCw+rnoWEzsmGqWS1CFyZtsOQq
	 XnCh4D5D7T4/iPOMCPScod5ytfDZ6NcGDKPVN2606C9QJ5fjEnFDiI3PRVGI87wu8B
	 +6dyKlGlZt78voQotkICd2ZNBXBwMgBGzZW6w5Sx34ztgX/fd3nKGUVL9WtvSrj9Sq
	 Y7Qiq9jBmy/Va3KfEBeO5v62EffRy94l8v8ZufAyDKODCVpg5bgwSenh8SaKeM5gSO
	 aOK/e3snuyX+g==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date: Mon, 11 Sep 2023 20:36:42 +0000
Message-Id: <20230911203642.1788-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911163127.167dccc2@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Sep 2023 16:31:27 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Sep 2023 19:05:04 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > > Also, this if statement is only done when the trace event is enabled, so
> > > it's equivalent to:
> > > 
> > > 	if (trace_damos_before_apply_enabled()) {
> > > 		if (sdx >= 0)
> > > 			trace_damos_before_apply(cidx, sidx, tidx, r,
> > > 					damon_nr_regions(t));
> > > 	}  
> > 
> > Again, thank you very much for letting me know this awesome feature.  However,
> > sidx is supposed to be always >=0 here, since kdamond is running in single
> > thread and hence no race is expected.  If it exists, it's a bug.  So, I
> > wouldn't make this change.  Appreciate again for letting me know this very
> > useful feature, and please let me know if I'm missing something, though!
> 
> The race isn't with your code, but the enabling of tracing.
> 
> Let's say you enable tracing just ass it passed the first:
> 
> 	if (trace_damos_before_apply_enabled()) {
>    
> 		damon_for_each_scheme(siter, c) {
> 			if (siter == s)
> 				break;
> 			sidx++;
> 		}
> 		damon_for_each_target(titer, c) {
> 			if (titer == t)
> 				break;
> 			tidx++;
> 	}  
> 
> Now, sidx and tidx is zero (when they were not computed, thus, they
> shouldn't be zero.
> 
> Then tracing is fully enabled here, and now we enter:
> 
>  	if (trace_damos_before_apply_enabled()) {
> 		trace_damos_before_apply(cidx, sidx, tidx, r,
>  				damon_nr_regions(t));
>  	}
> 
> Now the trace event is hit with sidx and tidx zero when they should not be.
> This could confuse you when looking at the report.

Thank you so much for enlightening me with this kind explanation, Steve!  And
this all make sense.  I will follow your suggestion in the next spin.

> 
> What I suggested was to initialize sidx to zero,

Nit.  Initialize to not zero but -1, right?

> set it in the first trace_*_enabled() check, and ignore calling the
> tracepoint if it's not >= 0.
> 
> -- Steve
> 


Thanks,
SJ
