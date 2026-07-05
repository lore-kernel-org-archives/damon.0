Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B525253958
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288024; cv=none; b=mEe8znAnVJa+MvPGoneQr1+cMEf5rt5IVqGgt6wNsTJJhAnQPNqBpO83CXMqjqGuBPoJBsPL0A2qLgjDjhXEkhTF7kMIu8tlaQH2IGDdf4Firb18eyIN/I89uHuN8yB3VkejBcGLFRDFy2xyulzgkPUxyjnK9oBGuefSsYqAf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288024; c=relaxed/simple;
	bh=Zmxl+NP2sIe5KCskY/bcWHVY9MTf+lzMwBxxwsxV1kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ5r+/rHyX9X+yW36BWAATC4o7tHCRf94qSFsALFVnRdb26LGNtrl39eiX+EcQi4W+KASTeUHQF8GroQNmLwDaLLIm/kdB90igUlUCLCjnVmXM/yoQdd7PJzV6T/BiyL9N/O7fndqb2wPBP54hsm9zSlvbskK1qhlHBPaIlOpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWH0KaGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWH0KaGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0BB1F000E9;
	Sun,  5 Jul 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783288023;
	bh=7BMzk3qkb5xKj+tRNocL1B59FhWU7FkPOSPg3rn1+IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWH0KaGgZFItsgaQIC5ReJQrNwpn0rFjcEriqC7pjDZw1kL2wZagWFcmlhGKII8RK
	 rfSmOOCsQ4uasY5CxCGMHesyJ+xqJmPzK8AigevmZUT4E5pnlqtxEGZDvIlxezLd5L
	 c6eNJhaIY7JnuFpT1WwdDXmbNv9R3lKXGStSO0Zglvu4ueWuEwr33SutPDHHIttNex
	 Gsk70RE1cP9svsVbdzlObFEaliXEN4eeahUNz2Sd3hKuOIiqsGWb27hB5YOmDvFMjk
	 pGJ/ifJt2N8UqSqqpI7ezJ+D/Ts5uGa1E579lgO435zWcUlmHUFH8JIh+thQKcDs0Q
	 y0WLcAQkZHLVA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 14/16] Docs/mm/damon/design: document attrs-only monitoring
Date: Sun,  5 Jul 2026 14:46:53 -0700
Message-ID: <20260705214655.101264-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705210519.D99B51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:05:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Spelling mistakes in the newly added documentation: 'deeecided' and 'mechaanism'.
> --
> 
> commit 802f6df741c5d3bfcb1ed21eadbf33ebee4db496
> Author: SJ Park <sj@kernel.org>
> 
> Docs/mm/damon/design: document attrs-only monitoring
> 
> This commit updates the DAMON design document to include a section
> describing the data attributes-only monitoring mode.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index 457d6e8bc7878..67398e2133036 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> 
> [ ... ]
> 
> > @@ -316,6 +316,26 @@ Another way to do this for higher accuracy is using :ref:`DAMOS filter
> >  information in page level.  But, because it is operated in page level, the
> >  overhead is proportional to the size of the memory.
> >  
> > +Data Attributes-only Monitoring
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Data access is the primary monitoring information for DAMON.  Hence it
> > +:ref:`adjusts <damon_design_data_attrs_monitoring>` regions using the access
> > +:ref:`counter <damon_design_region_based_sampling>` (``nr_accesses``).  In some
> > +use cases, however, users may want some of :ref:`attributes
> > +<damon_design_data_attrs_monitoring>` to be the primary information.
> > +
> > +Data attributes-only monitoring mode supports this use case.  For the mode,
> > +each attribute probe has their priority weight value.  Users can describe by
> > +what combination of the attributes the primary information is deeecided, by
> 
> [Severity: Low]
> This isn't a bug, but there is a typo here: "deeecided" should be "decided".

Good finding.  I will fix this in the next revision.

> 
> > +setting the priority weight value.  If the total sum of the weights is not
> > +zero, the mode is enabled.  The regions adjustment mechaanism uses the weighted
> 
> [Severity: Low]
> This isn't a bug, but there is another typo here: "mechaanism" should be
> "mechanism".

Ditto.

> 
> > +sum of the :ref:`probe hit counts <damon_design_data_attrs_monitoring>` instead
> > +of ``nr_accesses`` in the case.  When the mode is enabled, access monitoring is
> > +automatically turned off.  The access counter (``nr_accesses``) will always be
> > +zero and not updated.  Hence the mode is called Data Attributes "only"
> > +monitoring.
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=14


Thanks,
SJ
