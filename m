Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA04442FB3;
	Thu, 13 Aug 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609724; cv=none; b=NsS755BTQcLJzGEfNxQzUDydW4JCz0hjdhBgoPTlfgUCTBucmv5vSH1jiYzkqZSNX1jIjlM1xLot+8t91vCKwxPs32HqcfVDwgzGyjoYmjRnnE+FpzeashEFEq0NRam275DHqg7zWqV+ZVIaVmaoedXm+AZ/KjAfifdWbMcxB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609724; c=relaxed/simple;
	bh=ksjfrsjrqio69wjpS7hlRyuiSuUBYHv0ukkeBype3Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0vDazsfPGW/KVFOf18Or6+e80fnI5tCfmzY3XSgbr2UQ4qvqka+4NQXwOHcIBhW9hns1KwgN30lpifiNcv+upLi9NbaHq9UEPE9SXtRJwJjG+tBp0CePEXAAB6yVhp9BWNxMt/n9/Em2klgn5J9fNioLcR2uuo8paLMAkgxRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMs9RZNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMs9RZNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34981F000E9;
	Thu, 13 Aug 2026 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609722;
	bh=uIuTH63rkuXcFm6et2f7wSWkhuN5eE2vt+vtDQrJL4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bMs9RZNCuFCGpxMnuN/GlcJjkXynXrV0LclIUQD6JvPK5QrSyTBQJTqUF7+TVW6FO
	 1K6z3hMAOA099qVd5GR6tSZjx8FS/X+8lBZ0/AKAYK7ucrziX4+PuEoE80THntxuv/
	 TWHocyxmoUw4hOODVAZGbvUGeKk/JYZgzhdD45h8/FyxUgYRW7m/BKkgL54bPfKj6u
	 EfPE8kCQlMS8f7unbRmZMB3/eGv1hSRzv8p2/iyQRpRNe+A6xO/ZBBBYt2GyLBO/dI
	 GaO558pnhFY4zgrgplFktxr/jxQNTn7H5CDgLwqFJuRiUyz6PEVLR6PTunViHie0Jm
	 KQGFkf8cvD1DA==
Date: Thu, 13 Aug 2026 09:28:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SJ Park <sj@kernel.org>, linux-mm@kvack.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <an2AEAE8gXAHPY19@lucifer>
References: <anS-vK1MaC8sWoMK@fedora>
 <20260807000938.79851-1-sj@kernel.org>
 <an0rQM7ZwWnB0nVD@fedora>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an0rQM7ZwWnB0nVD@fedora>

On Wed, Aug 12, 2026 at 10:26:08PM -0400, Gregory Price wrote:
> On Thu, Aug 06, 2026 at 05:09:37PM -0700, SJ Park wrote:
> > On Thu, 6 Aug 2026 12:05:00 -0500 Gregory Price <gourry@gourry.net> wrote:
> >
> > > On Thu, Aug 06, 2026 at 02:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > On Tue, Jul 28, 2026 at 03:47:11PM -0400, Gregory Price wrote:
> > > > > All DAMON physical- and virtual-address operations obtain their folios
> > > > > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > > > > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > > > > this is inconsistent with other callers in mm/ which test explicitly.
> > > > >
> > > > > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > > > > so the guarantee lives in one place and covers every caller uniformly,
> > > > > consistent with other mm walkers that reject zone device folios.
> > > > >
> > > > > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > > >
> > > > Thanks, nice to make it explicit!
> > > >
> > > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > >
> > >
> > > SJ Asked me to drop it,
> >
> > I didn't asked you to drop this.  I asked your thought about revisioning this
> > for my concern.  And you replied [1] you can drop this.
> >
>
> Sorry I didn't mean to imply you pushed for one side or another, just
> that the feedback you gave about not wanting dead code is reason enough
> to drop it.
>
> I will probably just go ahead and drop it unless Lorenzo thinks the
> patch is worth keeping.  In my next private node iteration, it ends up
> back in anyway - so we get a two for one without the intermediate patch.

Yeah it's damon code so if SJ isn't happy let's drop it for now and we can
revisit later!

>
> ~Gregory

--
Cheers, Lorenzo
