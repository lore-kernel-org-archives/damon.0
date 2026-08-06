Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485C26ED41;
	Thu,  6 Aug 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025785; cv=none; b=j4GcLQj4m8c8n9VvS0J9nO8dM0+mvIt6VDGy5+QDy/ZbNNVWzodVc2WvmRVQDa2uCGpGE4LUBILE+6J+8/dIBN78xAl+px7eZbECPJbbIjUCMKIsWATTISvbYo3sci4NAzn7RJwUoiI+ToAMqlCux2LyOC9h2B4PwcP6c2+vuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025785; c=relaxed/simple;
	bh=pERmVE5df40kGOCwJY+cRLhYLnVcquposSSYaiDbBac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5wUEic9RucsMVa6tNf4ULE9JwA8kLsTvQXQ6IoIw84t2amNrzMWJAzVeINWRwFOG7TfLuv7MdyQDlfNgbA49GdfWb7ljiQOWsGqO8uVOlhWt3QwEmzsZrvf1729AQZGgDtaSQBXDCrqYGzh+HhZaNFC7Zhn1uFI1YJdHUInIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpttzweg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpttzweg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BCF1F000E9;
	Thu,  6 Aug 2026 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025784;
	bh=tyYaST7r1jnOM3k+MKVb9LOG4FPzienjqXCxOdXjJgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cpttzweg9qtPVh9Q8WfM00+sORYeV0+HAn1rFgQ/rETFLSunF1cXZ0ddYTmffUYCT
	 SEnOdYqGd0Fek2jQUQnVckLtjJZKtjFcvlErbKQ5nQY+Lp35mbPBD+B5XEt9IiVdM0
	 ti4WGmr9crql64KUn38hbacKyRMVffQ/NpO5pMeIG3EsKxFQ8p27TNAFTAUi6yT8/k
	 O3C6XATu9oPDRY9WUTledhv7+Vlp8fpHkCXKn6LpB8wYf94gS5QLbSLiyzl5Gr+huS
	 BW76nGCLM3xybUHnVEu1rmlD6w+3OCU07aVhAWWlolfjVkJdmW/jxJ0uaRDc0+6jEI
	 lVhHjtKJC7ecg==
Date: Thu, 6 Aug 2026 15:16:03 +0100
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
Message-ID: <anSXFHZZPUf1iFSm@lucifer>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-5-gourry@gourry.net>
 <82f6afba-756c-4ffd-bd5d-c3432179af28@kernel.org>
 <anSNk7zgoGj62CWk@lucifer>
 <0c90b9ae-48ac-407f-9d73-4c501c82cf40@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c90b9ae-48ac-407f-9d73-4c501c82cf40@kernel.org>

On Thu, Aug 06, 2026 at 04:11:21PM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 15:36, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Aug 06, 2026 at 03:25:50PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/28/26 21:47, Gregory Price wrote:
> >>>  mm/mempolicy.c | 4 ++++
> >>> @@ -797,6 +799,8 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
> >>>  	folio = pfn_folio(pte_pfn(ptep));
> >>>  	if (!queue_folio_required(folio, qp))
> >>>  		goto unlock;
> >>> +	if (folio_is_zone_device(folio))
> >>> +		goto unlock;
> >>
> >> Leave the hugetlb part alone. hugetlb folios will never be ZONE_DEVICE.
> >
> > <Insert leave Britney alone meme here> :P
> >
> > But dear God we have got to find ways to stop hugetlb being this big stupid
> > nightmare that every single path of mm has to put an asterix next to itself
> > about!
>
> Yeah, possibly unifying the code (possibly, because it's a mess) but not
> replicating checks that don't make any sense for hugetlb.

Yup agreed.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
