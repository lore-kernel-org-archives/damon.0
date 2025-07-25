Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20923183B;
	Fri, 25 Jul 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472394; cv=none; b=IHFbYwFrmdoziZk/4x3XcG+PVKHlZWXrVy+q64q5AZjHm3DbmH/je0DiQr0TBK2AaFhlnGwUgHI0AJj5V6nT1bZooWz/xTL+o6JFFo2hTJQwSwUhc/5ZQ35l1lpCpG3D48Z1xhivUnQInsRWOyPdc0Ffv53BfClqiH4yo34gAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472394; c=relaxed/simple;
	bh=uj/N/bSRAAtErIC/6xB/eoKkqvtlQGzcmsA0lQ53fm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8RIf+qog1cS7WiwSnd48X3ds9eNGhmbsTTLJMuSiXUqEPJnRpaWMuRSM9usESiw/p0Sawhx8KibfHqixybl6JXdHSa+jnCpq2A4Rm/CcUdTTE9feXWkZtq6+YyHbbU7AwJ+UHe+lnDaGApVbTXfjRKtgm0oHICty/jYDuQAEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Nop6OW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Nop6OW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2A4C4CEE7;
	Fri, 25 Jul 2025 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472394;
	bh=uj/N/bSRAAtErIC/6xB/eoKkqvtlQGzcmsA0lQ53fm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3Nop6OWuWhO694lwWd7a6lOzCzOaXZBZWF6ohngBLzTTTTkL7HzywkhlVG5290+P
	 W82DK9Whc4fPHjcoG5v1Di2DkwS3SQWoIwgnhjwcRc8tvtzvDU1ecUbfXcNN67pgOk
	 EmsQvz4ZzHFor/lk3yHY8sdmt9sQt22AScs5B/i7aPXjNfcJ1eUFD3EjeRsneuZAZJ
	 uSUvApM1ESn6ccy767IQyN3h7RRmMpAeP+mrfmaTuMSnMkdDr8+T8p5MtuMK2TDWsb
	 hlrxdAUiEKz18a9rgl+1srekdNNm/WKjnTRHFib7MEnrRTVhmy7+YnSqZFQg6wY7xv
	 IMvK74uGofcfg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: Skip isolating folios already in destination nid
Date: Fri, 25 Jul 2025 12:39:52 -0700
Message-Id: <20250725193952.49563-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725193637.49389-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Fri, 25 Jul 2025 12:36:37 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 25 Jul 2025 11:33:00 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> 
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> > 
> > damos_va_migrate_dests_add() determines the node a folio should be in
> > based on the struct damos_migrate_dests associated with the migration
> > scheme and adds the folio to the linked list corresponding to that node
> > so it can be migrated later. Currently, folios are isolated and added to
> > the list even if they are already in the node they should be in.
> > 
> > In using damon weighted interleave more, I've found that the overhead of
> > needlessly adding these folios to the migration lists can be quite
> > high. The overhead comes from isolating folios and placing them in the
> > migration lists inside of damos_va_migrate_dests_add(), as well as the
> > cost of handling those folios in damon_migrate_pages(). This patch
> > eliminates that overhead by simply avoiding the addition of folios that
> > are already in their intended location to the migration list.
> [...]
> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> > Sorry I missed this in the original patchset!
> 
> No worry!
> 
> Andrew, could we squash this into commit 19c1dc15c859 ("mm/damon/vaddr: use
> damos->migrate_dests in migrate_{hot,cold}") on mm-stable?  I think this is
> just a simple fixup.
> 
> > 
> >  mm/damon/vaddr.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 7f5dc9c221a0..4404c2ab0583 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -711,6 +711,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
> >  		target -= dests->weight_arr[i];
> >  	}
> >  
> > +	/* If the folio is already in the right node, don't do anything */
> > +	if (folio_nid(folio) == dests->node_id_arr[i])
> > +		return;
> > +
> >  isolate:
> >  	if (!folio_isolate_lru(folio))
> >  		return;
> > -- 
> > 2.43.5
> 
> 
> Thanks,
> SJ
> 
