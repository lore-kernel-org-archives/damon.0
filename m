Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E779DA;
	Tue,  9 Dec 2025 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765256194; cv=none; b=Mbc2XHgXY65gfIUyVzDjFQZojE8m0Xi/oVnBiILAhfn1WD/J3+FO7KnULGhGoy/JbY0HhoLmzhJ5wzTlp0N8ZzcN2iOjAgFdMzEVCO4VGKl1/l+NErkDbeDNBlvacGetqHjnCkth+nwjxPAoH6j9WJ2+QYgnRPqan/DvQRnkiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765256194; c=relaxed/simple;
	bh=stSlRO98n6+YI+yXsCwpZF58h8JKifRIN8mOv4byAEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iv5o7Uw4wPRC+n1WMCDWVD5OPRmGdwveV5MLXOT/gAnLn8mOIVl9BH2n9W+AuLkqsGblQ9XsJ+LkngZeQNkJolNpOwMVa5Jjo+ha6PneHBYHRda1LASjXYXc8Uu3mPV+/gkzyMCgyXLiUI6ama2l3yyq25nck2/bGtbuRUauqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pALW8jEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pALW8jEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83250C4CEFB;
	Tue,  9 Dec 2025 04:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765256193;
	bh=stSlRO98n6+YI+yXsCwpZF58h8JKifRIN8mOv4byAEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pALW8jEqXCx7Hibl6DnGy/22+00pTEx9UJSYHhWTGmuo2QzE4PcQgZMEMkfX6ld6F
	 NmPyIiuT5vJ5cJ3ZdKFp635FbzGnEk1V1/u6hxf0nsK6M+aDYg+WRea9aYter+ws1H
	 lTTBHOXg7QZGYhKaXSwZILBN8FgVX3+Epyr65A2dRZ8jMK2HxJHRUTzkczd+A4c5s5
	 vq0UMSQVyAe/tWdes9uwafY+tjRmVOJET7UpSpsMvQBwIae8s6G8Le1Qo/Bb8X8Eog
	 w67HX1jGTKigc1bJlOab/at1WHqKwMdYyuBfl3/j9Dmnf7yqSHYDviv6A5jgsqhusI
	 Nn/3+IagHv+lg==
From: SeongJae Park <sj@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 05/37] mm/{mprotect,memory}: (no upstream-aimed hack) implement MM_CP_DAMON
Date: Mon,  8 Dec 2025 20:56:28 -0800
Message-ID: <20251209045629.77914-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3b7ff190-4efe-47d0-82fb-68135a031b0f@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@

On Mon, 8 Dec 2025 12:19:41 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 12/8/25 07:29, SeongJae Park wrote:
> > Note that this is not upstreamable as-is.  This is only for helping
> > discussion of other changes of its series.
> > 
> > DAMON is using Accessed bits of page table entries as the major source
> > of the access information.  It lacks some additional information such as
> > which CPU was making the access.  Page faults could be another source of
> > information for such additional information.
> > 
> > Implement another change_protection() flag for such use cases, namely
> > MM_CP_DAMON.  DAMON will install PAGE_NONE protections using the flag.
> > To avoid interfering with NUMA_BALANCING, which is also using PAGE_NON
> > protection, pass the faults to DAMON only when NUMA_BALANCING is
> > disabled.
> > 
> > Again, this is not upstreamable as-is.  There were comments about this
> > on the previous version, and I was unable to take time on addressing
> > those.  As a result, this version is not addressing any of those
> > previous comments.  I'm sending this, though, to help discussions on
> > patches of its series, except this one.  Please forgive me adding this
> > to your inbox without addressing your comments, and ignore.  I will
> > establish another discussion for this part later.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
[...]
> > @@ -6363,8 +6415,12 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> >   		return 0;
> >   	}
> >   	if (pmd_trans_huge(vmf.orig_pmd)) {
> > -		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
> > +		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
> > +			if (sysctl_numa_balancing_mode ==
> > +					NUMA_BALANCING_DISABLED)
> > +				return do_damon_page(&vmf, true);
> >   			return do_huge_pmd_numa_page(&vmf);
> > +		}
> 
> I recall that we had a similar discussion already. Ah, it was around 
> some arm MTE tag storage reuse [1].
> 
> The idea was to let do_*_numa_page() handle the restoring so we don't 
> end up with such duplicated code.

Thank you for sharing this, David!  As I mentioned on the commit description, I
will revisit this part for making this more upstreamable, after LPC.  And this
previous conversation will be really useful for me at preparing the next
iteration.  Thank you again!

> 
> [1] 
> https://lore.kernel.org/all/20240125164256.4147-1-alexandru.elisei@arm.com/


Thanks,
SJ

[...]
