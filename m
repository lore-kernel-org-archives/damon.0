Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780512E68;
	Fri, 31 May 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183992; cv=none; b=d9eOJRYOCUTUmlSoPsfbMcMDFKbtzaasGzScJN09NxJNPqFRTmew2qGYnLLItgVNdAUbO97YjWn92g/b56snZe3/4vQvuCxyXLoGuXXrndy5WWfbGxPy3EZE5AsccpzVwzWbVYYa0JxNS9TI0qA3B1OhVxVTOPJL4/we9ImxH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183992; c=relaxed/simple;
	bh=UCC6c01j73UTS8arQTdjtkYbzlZYjs10+rymqoQJDvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+Pd97qG2rS4LYbQ8gpxecd44E3f80zEid5PU20+srzWbJRaSa09KOXljzzyaWybeOLvEQkFPla2bzumgoYbAzDvdxzsdx3erUr8KIjF2dHbvxSCpZ5wq0e1cxZ69yTxBmhOOVrbRdpnQ2vsvV0pymzKkh7ASmcrZERJ+say/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQA+EhYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQA+EhYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE11C116B1;
	Fri, 31 May 2024 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183992;
	bh=UCC6c01j73UTS8arQTdjtkYbzlZYjs10+rymqoQJDvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQA+EhYPDH5Zls+cQIBWkuHQa4L4H+Q1cu6aGNmZZ7sgEgVCjyQB5xhZM/Nprhs/9
	 iRiOwPA9/m/xc/DwcAo355//hvQSIg395EqBU9J9QFFt3+/BwH/LZ0arKF9XyP5bAF
	 Z86qgFh2P05+2OVddu4Vl3Ii17QbybqAmf7fOThAayULn2yG6w8eP2JGT2sZN/nKXa
	 0GmBgFRXesMTkPhLXbLpNnlleK2DyuhdqvGRNxROcCTEuApL81R+krWJQFTm+JHiXc
	 EnOxGiEOn8zx46jMJpcjtPmA1J7lGsvUrtrYtt/0f7uGhtzBFlRVFgCB8M0jBl8LNW
	 CCY72pHKf00IQ==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] DAMON multiple contexts support
Date: Fri, 31 May 2024 12:33:07 -0700
Message-Id: <20240531193307.71424-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531122320.909060-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Alex,

On Fri, 31 May 2024 15:23:18 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Currently kdamond uses only one context per kthread
> and most of its time it sleeps, so utilizing several
> contexts can scale kdamond and allow it to use
> another set of operations.
> 
> This patch-set implements support for multiple contexts
> per kdamond.
>
[...]
> 
> ---
> Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
> - Compatibility for DebugFS interface is kept
> - Kunit tests build/execution issues are fixed
> - Patches from v1 are sqaushed, so that consistency between patches is
> kept

My request was to avoid unnecessary temporal changes that will be removed in
next patches.  Some of those are well removed in this version, but I still show
some.  E.g., nr_contexts field.  Also, this resulted in two big patches.

I'd also appreciate if you can separate changes into smaller ones of logical
single change.  For example, changes for lru_sort.c, reclaim.c, and sysfs.c on
first patch could be much smaller in my opinion.  Traceevent change can also be
separated from patch 2.  Some of multi-context support seems mixed in patch 1.

I'd suggest below patches flow.

Patch 1: Introduce new struct and control functions for the struct.  Don't
really use the struct and the functions.

Patch 2: Modify core.c to use the struct and implement multiple contexts
support.  Minimize changes to core.c users.  Just keep those work as before.
Don't implement multi contexts support on sysfs.c or trace events at this
point.

Patch 3: Update sysfs.c to support the multiple contexts.

Patch 4: Update trace events to better support it.

> - Added/Fixed comments about data structures/functions

Also, you don't need to put version history under '---' marker if it is a cover
letter.  You can put it on the body.

> 
> Alex Rusuf (2):
>   mm/damon/core: add 'struct kdamond' abstraction layer
>   mm/damon/core: implement multi-context support

I will try to put more detailed comments on each patch.

> 
>  include/linux/damon.h        |  80 ++++--
>  include/trace/events/damon.h |  14 +-
>  mm/damon/core-test.h         |   2 +-
>  mm/damon/core.c              | 509 ++++++++++++++++++++++-------------
>  mm/damon/dbgfs-test.h        |   4 +-
>  mm/damon/dbgfs.c             | 342 ++++++++++++++---------
>  mm/damon/lru_sort.c          |  31 ++-
>  mm/damon/modules-common.c    |  35 ++-
>  mm/damon/modules-common.h    |   3 +-
>  mm/damon/reclaim.c           |  30 ++-
>  mm/damon/sysfs.c             | 303 +++++++++++++--------
>  11 files changed, 872 insertions(+), 481 deletions(-)
> 
> -- 
> 2.42.0


Thanks,
SJ
