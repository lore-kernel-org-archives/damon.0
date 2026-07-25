Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12238625
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015551; cv=none; b=Cr0Lx3aUS6tQFo9XM1afSxgblEE+V7F/ePYPk6vw1LpLfxAjAuYUFBJlR2gZPFk+jOR2u5es6CWyaDu14jgKXIvYLYfvD8cH2bwRyE30jSXXg5nZU/geLMFVKHuQmdwr1NoVlaq+yNv40O/4eBDRxN0mLHXzmjGboA/6lQpgX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015551; c=relaxed/simple;
	bh=RiaLixW9GdvH21Lp+CftJVMwwwPBldhDWSSGZb8JHaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJr0lrWGesUxz2Tychq59LHUJzANCZUObByYiOWoGud3yGoIr8clVecie1ozSKntSTLCOAu7n2UsNq/L/jr4wNXeQawz+I7tFGRT7X4dPJuEBDDdWWsYPijlP+hawaRvQI+bcXrOE+Bb13ssuSlPF4k0QR+I+kXt3Uw+BgZiTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjHGniw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjHGniw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9518B1F000E9;
	Sat, 25 Jul 2026 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015549;
	bh=g/Fmgaejxz/vG4QhD49Vha3RXO8yMqwqh9p32M0vo3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjHGniw/7YKOgnZzu7wvUgPggpA0VZkeEMc6jD3L7nsOex19ri/dr3OXENIVqLh4k
	 U700ElcG9nAIJAJ6eFx4xSB7k+Bg3Cwwp6CnlJZtwU7+KJwXOvr/GD19tc1GVt2WRl
	 4zNe6gB5yY7NRmYOL7RkyT/rL0GRvzs/RcN/D3nEP9Da7vUsZwLB3gpI3h487UK82g
	 EGqy3cyTWddByAC/ln7K+MMlPUe9qLCVj+y7EeTiB6ppqBg67URbanJyCEqIs4U/kj
	 xnYuro459Cn9ynE9hpi2S7TVLTzmFKv+rZbbkQyh53N72MyFKtR2IV9yGZRU5fqV62
	 KWuYt5xjIikkg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Sat, 25 Jul 2026 14:39:05 -0700
Message-ID: <20260725213907.131240-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210525.8D4CD1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:05:25 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Typos and grammatically awkward phrasing in the newly added documentation.
> --
> 
> --- Patch [4]: [RFC PATCH 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type ---
> commit 616f638e60cd5170d7a26046797874f2e31071a4
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document pgidle_unset probe filter type
>     
> This commit updates the DAMON design document to include the newly added
> pgidle_unset probe filter type. It also formats the supported filter types
> into a list for improved readability.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index aed6cb1cf4831..d9f64e9ae2879 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -293,8 +293,14 @@ registration is made by specifying a probe per attribute.  Each of the probe
> >  specifies a rule to determine if a given memory region has the related
> >  attribute.  The rule is constructed with multiple filters.  The filters work
> >  same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
> > -filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
> > -for data attributes monitoring.
> > +filter types.  Currently below fitler types are supported.
> 
> [Severity: Low]
> This isn't a bug, but there is a typo here ("fitler" instead of "filter").

Nice catch, I will fix this in the next revision.

> 
> > +
> > +- ``anon``: Same to that for DAMOS filters.
> > +- ``memcg``: Same to that for DAMOS filters.
> > +- ``pgidle_unset``: Matches if the page for the memory is marked as not
> > +  access-idle.
> > +  Matches if the memory is not backed by pages that DAMON can idnetify
> 
> [Severity: Low]
> This isn't a bug, but there is a typo here ("idnetify" instead of "identify").
> Could this phrasing also be slightly adjusted for better flow? Something like
> "pages for which DAMON can identify idleness" might read more naturally.

The last sentence is wrongly added.  Will remove from the next revision.

> 
> > +  idleness.
> >  
> >  If such probes are registered, DAMON executes the probes for each region's
> >  sampling memory when it does the access :ref:`sampling
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=4


Thanks,
SJ
