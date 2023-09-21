Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B817991
	for <damon@lists.linux.dev>; Thu, 21 Sep 2023 19:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0242C433C8;
	Thu, 21 Sep 2023 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695324987;
	bh=yWgtFNgkqgWjEXgwCB6SqgQ53emC6ZvfBAx69yUw5yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dmdu9ccaG6RwZLCVtqnwk4lho3W9T0um4xSuX6SBZFvkcezG0GoeVUuDvwdVYyX1L
	 jpPrS/Ng5UuimZZ4Q8Fjrl91XBGaUaJJSTES1g6xikPjOEmKa7VALkPLGOtMj156Nh
	 LJunk2N4sHsrbeUQADAKcpe2iL1QypPJ39BTJCHTAnCp5wbJpuVCf8tivsEiNK5Ysv
	 A3edupwAMRy33tMf0/y7DE74FIFZCLg2QX3qkO02/R/URkT57uLE4wd1S3G7macte3
	 rwtDRwTYyqk12u3zUrXSmd/fcdFcOjWm3x8gFufQxlhUIheFMzUzFidLx+zHJ7Gj6I
	 0q2BFIEB+PTFg==
From: SeongJae Park <sj@kernel.org>
To: Huan Yang <link@vivo.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list),
	damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
	linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/2] Damos filter cleanup code and implement workingset
Date: Thu, 21 Sep 2023 19:36:25 +0000
Message-Id: <20230921193625.99617-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919095237.26613-1-link@vivo.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Huan,


First of all, thank you for this patch.  I have some high level comments and
questions as below.

On Tue, 19 Sep 2023 17:52:33 +0800 Huan Yang <link@vivo.com> wrote:

> Now damos support filter contains two type.
> The first is scheme filter which will invoke each scheme apply,
> second is scheme action filter, which will filter out unwanted action.

IMHO, that's not clear definition of the types.  Conceptually, all the filters
are same.  Nonetheless, they are having different behaviors because they are
handled in different layer depending on which layer is more efficient to handle
those[1].

I agree this is complicated and a bit verbose explanation, but I don't feel
your scheme vs action definition is making it easier to understand.

> 
> But this implement is scattered in different implementations

Indeed the implementation is scattered in core layer and the ops layer
depending on the filter types.  But I think this is needed for efficient
handling of those.

> and hard to reuse or extend.

From your first patch, which extending the filter, the essential change for the
extension is adding another enum to 'enum damos_filter_type' (1 line) and
addition of switch case in '__damos_pa_filter_out()' (3 lines).  I don't think
it looks too complicated.  If you're saying it was hard to understand which
part really need to be modifed, I think that makes sense.  But in the case,
we might need more comments rather than structural change.

> 
> This patchset clean up those filter code, move into filter.c and add header
> to expose filter func.(patch 2)

Again, I agree more code cleanup is needed.  But I'm not sure if this is the
right way.  Especially, I'm unsure if it really need to have a dedicated file.
To my humble eyes, it doesn't look like making code clearly easier to read
compared to the current version.  This is probably because I don't feel your
scheme vs action definition is clear to understand.  Neither it is
deduplicating code.  The patch adds lines more that deleted ones, according to
its diffstat.  For the reason, I don't see clear benefit of this change.  I
might be biased, having NIH (Not Invented Here) sindrome, or missing something.
Please let me know if so.

> And add a new filter "workingset" to protect workingset page.

Can you explain expected use cases of this new filter type in more detail?
Specifically, for what scheme action and under what situation this new filter
type will be needed?  If you have some test data for the use case and could
share it, it would be very helpful for me to understand why it is needed.

> 
> Do we need this and cleanup it?

I think I cannot answer for now, and your further clarification and patient
explanation could be helpful.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/Documentation/mm/damon/design.rst?h=mm-everything-2023-09-20-19-38#n400


Thanks,
SJ

> 
> Huan Yang (2):
>   mm/damos/filter: Add workingset page filter
>   mm/damos/filter: Damos filter cleanup
> 
>  include/linux/damon.h    |  62 +-----------------
>  mm/damon/Makefile        |   2 +-
>  mm/damon/core-test.h     |   7 ++
>  mm/damon/core.c          |  93 ++++-----------------------
>  mm/damon/filter.c        | 135 +++++++++++++++++++++++++++++++++++++++
>  mm/damon/filter.h        | 119 ++++++++++++++++++++++++++++++++++
>  mm/damon/paddr.c         |  29 +++------
>  mm/damon/reclaim.c       |  48 +++++++++++---
>  mm/damon/sysfs-schemes.c |   1 +
>  9 files changed, 325 insertions(+), 171 deletions(-)
>  create mode 100644 mm/damon/filter.c
>  create mode 100644 mm/damon/filter.h
> 
> -- 
> 2.34.1
> 
> 
