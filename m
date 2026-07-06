Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3F3FCB1F;
	Mon,  6 Jul 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339166; cv=none; b=JfJ6BBbCMObZY3ws6KJH6fs9kD0ZjWsMTayus0FbUa+/3gYri46qZbc5epm/9oVSSW2deWJXRuvA4RpM86G6PP3ua9pH4RUojLR/Sn2qL+dt4ZgcEJXBor+fQLciW8bxV+YdpYEM4Cnv3fTqtR725g+H/D1CD+H579wfxoDlm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339166; c=relaxed/simple;
	bh=2xnaphu9ajz4U/4llwq4F2sTbEwgDbVYh5zYtNGeoVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHYWHdn5NCUM649rf52DEV3zHm9DiPBWeoWbtzU2h5HFdFLErn9d+NiIU0KeiYd2lEbcpYpCVVhsCMiHGPcAR5bV6bWh8P1FDDHoQ/FDJ6UCFefEx0tTWQckGneGHlJYNDyp2Ujafy8Y2gKNqs/i4gte5Cv9u7mEMf9RoJDpSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwl66Jd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwl66Jd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40CC1F000E9;
	Mon,  6 Jul 2026 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783339164;
	bh=V3erF/b265knhzDJVb6b4oDNmirucwH2jZV5nkwg6tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwl66Jd2LhYKHJJKFi12bQQ7Cp3/mMIdXHkk4kiHHX5CIPhcXTNTLhcClMHCK9AFV
	 bVeonePrZGiZV94RKuRwqqzyRPBKezrxtZQJQ13YFUNW318600LJpEu3gDmEfWu8+U
	 1ZifY8KRxsHDQYcR1yQHNuixr6Ijlzi8USCISeaNo9tucChlGUV6SoXMTzSYRdfUgQ
	 ejuzbJXpWCagqRcIF3NgwEHm3QPmBaSdetvwpC48ln94Lg0NRoL3aTzGvyO0JMg2QF
	 5YGJ0CXK09laAqRuWCwmYryaNYtdfzmbrfTn1b2kbwml00QeW7Y/Kcv85mBu2dEnwW
	 pj7DnF5nAyGew==
Date: Mon, 6 Jul 2026 12:59:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, daichaobing@sangfor.com.cn, kunwu.chan@gmail.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split
 actions
Message-ID: <akuYh9HQerTfUo1u@lucifer>
References: <20260702165235.86684-1-sj@kernel.org>
 <20260703190421.100480-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703190421.100480-1-sj@kernel.org>

On Fri, Jul 03, 2026 at 12:04:20PM -0700, SJ Park wrote:
> On Thu,  2 Jul 2026 09:52:34 -0700 SJ Park <sj@kernel.org> wrote:
>
> > On Thu, 2 Jul 2026 11:23:55 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > > +cc all those you missed.
> >
> > Thank you for doing this, Lorenzo.
> >
> > >
> > > I really need to write a bot to do this, because I'm getting a little tired of
> > > pointing this out :))
> >
> > Good idea.  I will also consider implementing this kind of checks to to my lzy
> > tool box [1] or hkml [2].
>
> I implemented [1] the check logic on hkml.  Many things to fix and improve in
> future, but seems working at least for this series.  You can use it like below:
>
>     $ hkml patch check --check_recipients only ./0002-mm-khugepaged-add-damon-collapse-folio-range-for-external-callers.patch
>     MISSING RECIPIENTS for [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
>     - Andrew Morton <akpm@linux-foundation.org>
>     - David Hildenbrand <david@kernel.org>
>     - Lorenzo Stoakes <ljs@kernel.org>
>     - Zi Yan <ziy@nvidia.com>
>     - Baolin Wang <baolin.wang@linux.alibaba.com>
>     - "Liam R. Howlett" <liam@infradead.org>
>     - Nico Pache <npache@redhat.com>
>     - Ryan Roberts <ryan.roberts@arm.com>
>     - Dev Jain <dev.jain@arm.com>
>     - Barry Song <baohua@kernel.org>
>     - Lance Yang <lance.yang@linux.dev>
>     - Usama Arif <usama.arif@linux.dev>
>     - linux-kernel@vger.kernel.org
>     $ hkml patch check --check_recipients only ./0003-mm-damon-vaddr-implement-mthp-aware-damos-collapse-handler.patch
>     MISSING RECIPIENTS for [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
>     - Andrew Morton <akpm@linux-foundation.org>
>     - linux-kernel@vger.kernel.org
>
> It is also integrated with the interactive mails list [2], so that you can run
> it without manually downloading the patch files.
>
> FWIW, 'hkml patch format' automatically adds recipients based on
> get_maintainer.pl, so this check is unnecessary for hkml users.  But this will
> help me reviewing patches that not formatted with hkml or other similar
> scripts.
>
> hkml has a feature [3] to monitor new mails.  Extending it to run this new
> check and send mails for check failures could be one of the ways to implement
> the bot.  I'm not planning to do that by myself, though.  I will run the check
> only for patches that look interesting to me, for now.
>
> [1] https://github.com/sjp38/hackermail/commit/9ca6fa1f71edc7a219edeb41d4c7f91
> [2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#interactive-viewer
> [3] https://github.com/sjp38/hackermail/blob/master/USAGE.md#monitoring-mails
>
>
> Thanks,
> SJ
>
> [...]

Nice, thanks SJ! That's cool :)

Cheers, Lorenzo
