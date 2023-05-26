Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF22CA9
	for <damon@lists.linux.dev>; Fri, 26 May 2023 21:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61467C433D2;
	Fri, 26 May 2023 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685135674;
	bh=sFVJeNDGSRnmSp5P8Iti+S0l7ZgKTimSNErApLz72Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=LLchCgTdfd5zpsTOrL4HBZuqRDdohvbMFTfGuCqqDaXj6jFxLdW+7wLNl6Ni41T6b
	 fkToFwrnhyIRReD48NWy1yJ9Ga5ozCM3U8qs5BdU4vx1FnMKGch48KUWHNDngbveHs
	 O3aO5z9E1lnOTIZXdKIxmK7myoFAGi9W2nZRTSm+er2uTa7JZup2JRVmX2SWt50nri
	 Yl9o4ZsYdH7zskEX9DP4pf5lw2O1Oby7dqIVAwNAcxCWeR0PN2mEdJP0Qx648Iw7Z9
	 RQvV3zxRgOVZ5b7NwmrH5ITGfeZZaAEVP1+AsCf+EqCvMxuL0fw/LfEhD1IfNBhjGN
	 I9N3egOQl2UgA==
From: SeongJae Park <sj@kernel.org>
To: mhocko@suse.com
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Docs/mm/damon: Minor fixes and design doc update
Date: Fri, 26 May 2023 14:14:17 -0700
Message-Id: <20230526211417.1902-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Thu, 25 May 2023 21:43:04 +0000 SeongJae Park <sj@kernel.org> wrote:

> Some of DAMON documents are outdated, or having minor typos or grammar
> erros.  Especially, the design doc has not updated for DAMOS, which is
> an important part of DAMON.  Fix the minor issues and update documents.

By the way, I started writing this patchset before LSFMM, but Michal's feedback
about DAMON documentation has definitely motivated this work, and was helpful.
Thank you, Michal.  I just wanted to say that.  Of course, more documentation
improvement works will be continued.


Thanks,
SJ

> 
> SeongJae Park (10):
>   Docs/mm/damon/faq: remove old questions
>   Docs/mm/damon/maintainer-profile: fix typos and grammar errors
>   Docs/mm/damon/design: add a section for overall architecture
>   Docs/mm/damon/design: update the layout based on the layers
>   Docs/mm/damon/design: rewrite configurable layers
>   Docs/mm/damon/design: add a section for the relation between Core and
>     Modules layer
>   Docs/mm/damon/design: add sections for basic parts of DAMOS
>   Docs/mm/damon/design: add sections for advanced features of DAMOS
>   Docs/mm/damon/design: add a section for DAMON core API
>   Docs/mm/damon/design: add a section for the modules layer
> 
>  Documentation/mm/damon/design.rst             | 309 ++++++++++++++++--
>  Documentation/mm/damon/faq.rst                |  23 --
>  Documentation/mm/damon/maintainer-profile.rst |   4 +-
>  3 files changed, 285 insertions(+), 51 deletions(-)
> 
> -- 
> 2.25.1
> 
