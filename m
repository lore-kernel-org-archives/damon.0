Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89032372
	for <damon@lists.linux.dev>; Sun, 21 Aug 2022 05:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D44C433D6;
	Sun, 21 Aug 2022 05:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1661060780;
	bh=wx25nGmnocMRdHKc23V1POqa4xFoHN4F4EfKi0wxXss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONSCKv91EAhsxA8cQYxDVQVB/GKl7Jzigww1nH8hntTFk6F8Y1dFKwRxMn3jGnP6g
	 QfvZI5aT/ru3Q3V4Uhn8MBWkWaw4S2zu/I0TwF3NXv9beritDmgfmUbaB3NjPYrRQm
	 Uev+0OCJ+8PLP3DXm4elvD1Fqg+0X4WVDSuiZ0tA=
Date: Sat, 20 Aug 2022 22:46:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sj@kernel.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present
 before accessing
Message-Id: <20220820224619.002b9ec30ca7167d7d37f473@linux-foundation.org>
In-Reply-To: <162b6039-bfb9-7dac-e72e-be946ea0621f@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
	<20220820141702.e731f2aade5da8cbe0c78cba@linux-foundation.org>
	<162b6039-bfb9-7dac-e72e-be946ea0621f@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Aug 2022 13:22:42 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 8/21/2022 5:17 AM, Andrew Morton wrote:
> > On Thu, 18 Aug 2022 15:37:43 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> >> page, also including the case of non-present (migration or hwpoisoned)
> >> pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
> >> not get the correct pfn number for the non-present pmd entry, which
> >> will cause damon_get_page() to get an incorrect page struct (also
> >> may be NULL by pfn_to_online_page()) to make the access statistics
> >> incorrect.
> >>
> >> Moreover it does not make sense that we still waste time to get the
> >> page of the non-present entry, just treat it as not-accessed and skip it,
> >> that keeps consistent with non-present pte level entry.
> >>
> >> Thus adding a pmd entry present validation to fix above issues.
> >>
> > 
> > Do we have a Fixes: for this?
> 
> OK, should be:
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual 
> memory address spaces")
> 
> > What are the user-visible runtime effects of the bug?  "make the access
> > statistics incorrect" is rather vague.
> 
> "access statistics incorrect" means that the DAMON may make incorrect 
> decision according to the incorrect statistics, for example, DAMON may 
> can not reclaim cold page in time due to this cold page was regarded as 
> accessed mistakenly if DAMOS_PAGEOUT operation is specified.
> 
> > Do we feel that a cc:stable is warranted?
> 
> Though this is not a regular case, I think this patch is suitable to be 
> backported to cover this unusual case. So please help to add a stable 
> tag when you apply this patch, or please let me know if you want a new 
> version with adding Fixes and stable tags. Thanks.

Thanks, I took care of all that.
