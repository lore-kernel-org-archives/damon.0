Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31548384
	for <damon@lists.linux.dev>; Wed, 13 Sep 2023 02:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CD3C433C7;
	Wed, 13 Sep 2023 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694571544;
	bh=njmsIlOnk+gidOj5TYyhHjoryn9sBCUbcma0uf7HMBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSvHS/hye/UJjDrLEPyZf5DnYoDMd+K15naBeARtblPyCUgjhrfh2PCit5cCqr5Ve
	 pOPhlqy/YNeXw0rBYgbnRGe5IVh2wkl0m3qiZvlZtSlTWqaEYmUxz53wo1oP7eQy56
	 Kquv7UkhxQFtT8V2sS4sO1t/4MRg/TncpvJMpTyDUhXlYRfLFIZRZpmEeT6lYpt9ic
	 iruUZJ2N1p74cygzEEEshZCempXyhZN4sHsU72WApgk2CMuNamGJty0jJoGlGe19n8
	 T4b8nSZrMt6pNbaLyBoXrRPtA5V+8G+qk0hNBomgDyfHp3P/denTlE0EoOVlszQxyY
	 vIC46VLlEW4Xg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (no title)
Date: Wed, 13 Sep 2023 02:19:02 +0000
Message-Id: <20230913021902.1993-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912183559.4733-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 12 Sep 2023 18:35:57 +0000 SeongJae Park <sj@kernel.org> wrote:

> Date: Tue, 12 Sep 2023 02:24:11 +0000
> Subject: [PATCH v2 0/2] mm/damon: add a tracepoint for damos apply target regions

I added a blank line in the header of the original patch, and it resulted in
this weird no-title mail, sorry.  I will rebase this on latest mm-unstable and
resend.


Thanks,
SJ

> 
> Changlog
> --------
> 
> From v1
> (https://lore.kernel.org/damon/20230911045908.97649-1-sj@kernel.org/)
> - Get scheme/target indices only when the trace is enabled (Steven Rostedt)
> 
> From RFC
> (https://lore.kernel.org/damon/20230827004045.49516-1-sj@kernel.org/)
> - Fix the 4 byte hole (Steven Rostedt)
> - Add documentation
> 
> Description
> -----------
> 
> DAMON provides damon_aggregated tracepoint to let users record full monitoring
> results.  Sometimes, users need to record monitoring results of specific
> pattern.  DAMOS tried regions directory of DAMON sysfs interface allows it, but
> the interface is mainly designed for snapshots and therefore would be
> inefficient for such recording.  Implement yet another tracepoint for efficient
> support of the usecase.
> 
> 
> SeongJae Park (2):
>   mm/damon/core: add a tracepoint for damos apply target regions
>   Docs/admin-guide/mm/damon/usage: document damos_before_apply
>     tracepoint
> 
>  Documentation/admin-guide/mm/damon/usage.rst | 37 +++++++++++++++----
>  include/trace/events/damon.h                 | 39 ++++++++++++++++++++
>  mm/damon/core.c                              | 32 +++++++++++++++-
>  3 files changed, 100 insertions(+), 8 deletions(-)
> 
> 
> base-commit: b67dc18d1406be3598248d2cc78904a81176fa13
> -- 
> 2.25.1
> 
