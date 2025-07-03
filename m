Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC933DF;
	Thu,  3 Jul 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751501414; cv=none; b=qHM8C7aK19JFOoBaaJ0Oi9/JUf/kTdKIa+NE0sVKabZh3dmT0HKN2VbbcXexLmvKXhkkcY0+JDN/QcgM/AE40Do31KIkT1RL68SoM/3s8JX0OUHVkLAfi8hmyOmEMnQwsBPdYngrxxD+q9jcLT1K/kKKOCV5TrnKFLuOTJYAhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751501414; c=relaxed/simple;
	bh=I35/uxQ11pllQl6G03JRJP5C/144JsmJcXM+Ub0/ny8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyvUHeSCKgSa9vOrXtmoMWIfM0ZtyaodsRtMHnto5Yj6L/Jdydj7kM5q7kvMot5X3frI74ED2tls9T7qs0668e5DIqmxRAs3uS7lbZSJgDTFCzWsQWkzTSG2vEgoDx0laqiWw8vmdvIQWXq0YTVaAir8A6ftqFqUxZffjNQhOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlzWbKId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlzWbKId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79348C4CEE7;
	Thu,  3 Jul 2025 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751501413;
	bh=I35/uxQ11pllQl6G03JRJP5C/144JsmJcXM+Ub0/ny8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlzWbKIddYZ5+PEPq+LD3JSF+6RpfyjYMm7MENVVI/iMbTCh3hvcyDj1+xWduKC+U
	 mHgHlzDBAOLUP5bgwLI1WMDkIA82qtpZhbY74eLSL2gdmd7xy+YAtfVDzUl3Cna8Tq
	 bWtJbh6tiBkRVCjkKXRA1IL1XAD/49SpaI0oalUo4BOGbFwGFOiN0jBeRSoIB4tmrF
	 /9oRcgSEJPmvh/MzAq3dDzikm8b2u2IHAYUCSOv75w1jQxY/55kNloR3eylIVMVtQC
	 yHGOPAII7rRTgwhcgDqBXMZwSZFUU1tpu2eMddJ+5wBT6f3rQEKoDPJb7MGESmboIp
	 FI2fntK9tdJ+Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: Re: [RFC PATCH v3 09/13] mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
Date: Wed,  2 Jul 2025 17:10:11 -0700
Message-Id: <20250703001011.57220-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702235138.56720-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 16:51:38 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Wed,  2 Jul 2025 15:13:32 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> 
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> > 
> > migrate_{hot,cold} are paddr schemes that are used to migrate hot/cold
> > data to a specified node. However, these schemes are only available when
> > doing physical address monitoring. This patch adds an implementation for
> > them virtual address monitoring as well.
> > 
> > Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> > Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> > ---
> >  mm/damon/vaddr.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 46554e49a478..5cdfdc47c5ff 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/pagewalk.h>
> >  #include <linux/sched/mm.h>
> >  
> > +#include "../internal.h"
> >  #include "ops-common.h"
> >  
> >  #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
> > @@ -610,6 +611,65 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
> >  	return max_nr_accesses;
> >  }
> >  
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> > +		unsigned long next, struct mm_walk *walk)
> 
> I'd suggest to put CONFIG_TRANSPARENT_HUGEPAGE check into the body of this
> function and handle both pmd and pte here, consistent to
> damon_young_pmd_entry().

Ah, unlike damon_young_pmd_entry() which is for a single address, this is for
walking the range of a given DAMON region, and hence should have a separate pte
entry function.  Please ignore the above comment.

[...]
> > +static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
> > +		unsigned long enxt, struct mm_walk *walk)
> 
> Nit.  s/enxt/next/ ?
> 
> > +{
> > +	struct list_head *migration_list = walk->private;
> > +	struct folio *folio;
> > +	pte_t ptent;
> > +
> > +	ptent = ptep_get(pte);
> > +	if (pte_none(*pte) || !pte_present(*pte))
> > +		return 0;
> 
> Shouldn't we use cached pte value (ptent) instad of *pte?  I'd suggest merging
> this into damos_va_migrate_pmd_entry() consistent to damon_young_pmd_entry().

Again, I overlooked the fact that this is for walking not only single address
point but a range.  Please ignore the latter suggestion.


Thanks,
SJ

[...]
