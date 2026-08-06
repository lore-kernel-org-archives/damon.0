Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC437F310;
	Thu,  6 Aug 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023405; cv=none; b=LB7GNnOnwVtDtNvUtEF01PsTwx3wIZ0bkQGPQfnXoWBDwGJwXefO/dWPg0ARrzXsUivFezt/QbjAIOXHfhXvem/prlkNera21mBcw99OaviDPgtSfrxFaBpsz6tG6LPHqywAQjpQPKeaL2J5Y/3FRBrgkI6JjDb7eOB1x5ksD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023405; c=relaxed/simple;
	bh=BjPWAItJud9urLVXm9L5I2C0NSfBJM2YFfzvZePlX2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrNikNGdUzFXBmsaTGlLnVDX6Y2CtnEGOCCybyYjLb+cDvfG4cSA1l6qvEAUqoHSU0hnwltUzc8X0W7DgVObPpqgXDLH1noaMnetazEN3l/vrNltVwyE9zj0GQPudOuVsAJsKvPy9SOgG5ojaNpE0jrGRyLkdw7NG19WFgm8GnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0K7nAtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0K7nAtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316C81F000E9;
	Thu,  6 Aug 2026 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023396;
	bh=GQumHfwaY/YrSY76B6WqcEr/ChsXY+iPspGhZHQSCTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H0K7nAtpciJ8wdGpR8lTTM2rX9eAPV7qsC2rrbl884CgU6DADjqsdkUjAzawChFHC
	 5kSxQV2of2YrG0KfB9MCpYcjFd5VOVB2LOdA8iQdu7e/6GJgWmEQqfWyjOKjccqFZp
	 bovA9je4hE1quNfTdUX7KMJ13AdCnWqumnsplnCng9D+FcacW5TJRPuMzdF38PBUQv
	 QUPftNKcPC2m/R5zeTNgNHYFPpc34cI49lirDgDsYucwNyLdN7uF793Y0VLIz5M1hQ
	 o1Gy+ljdRbEVN/QW3aCtSWZAAYuY+ZqHWUlDQQXkYhQivec7ujqlDpwzjTTxqWh+pX
	 6SpkRvoNZN3CQ==
Date: Thu, 6 Aug 2026 14:36:16 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	sj@kernel.org, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, 
	vbabka@kernel.org, jannh@google.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com
Subject: Re: [PATCH 4/4] mm/mempolicy: skip zone device folios when queueing
 folios
Message-ID: <anSNk7zgoGj62CWk@lucifer>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-5-gourry@gourry.net>
 <82f6afba-756c-4ffd-bd5d-c3432179af28@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f6afba-756c-4ffd-bd5d-c3432179af28@kernel.org>

On Thu, Aug 06, 2026 at 03:25:50PM +0200, David Hildenbrand (Arm) wrote:
> On 7/28/26 21:47, Gregory Price wrote:
> >  mm/mempolicy.c | 4 ++++
> > @@ -797,6 +799,8 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
> >  	folio = pfn_folio(pte_pfn(ptep));
> >  	if (!queue_folio_required(folio, qp))
> >  		goto unlock;
> > +	if (folio_is_zone_device(folio))
> > +		goto unlock;
>
> Leave the hugetlb part alone. hugetlb folios will never be ZONE_DEVICE.

<Insert leave Britney alone meme here> :P

But dear God we have got to find ways to stop hugetlb being this big stupid
nightmare that every single path of mm has to put an asterix next to itself
about!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
