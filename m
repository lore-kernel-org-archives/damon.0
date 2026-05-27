Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC133557D;
	Wed, 27 May 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892429; cv=none; b=NM59aqJo++P0Tf1xOuD6mLMNIwbcLrlALZAhIQNH+6Rd+yBkQk96J0KmIFkTec9yHPwHoRJJBLNLMlVy4/3X10Wi0f32pJ3UOPVOZmxyNRGK0YTLfsKjK71bncPP9KQSzQxfEnHi6BQsLyc6xxfL+aD5oLbU0WDvqxeP/dQ7NfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892429; c=relaxed/simple;
	bh=C8CvBHWQDzBJDTrmMd/gPWBhN89D1x49lyWyrsxqYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ6+XqL/mE5iqy6egT034DRI7nQQGOlTnJbHmk4ctERb0tlWn0t/HPPPRb1At56akRDPe2NVGwI8wrD0w99r+aj8FNSPWDjHgEz8tLXO+YB7dpXD0lTfkRnUjKvKlNnaIy0vtiiWodEbmiTyMwhgK5Oq7iFDdZ+kP1zW1u8JTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN2tAxV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN2tAxV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07E01F00A3D;
	Wed, 27 May 2026 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892428;
	bh=C8CvBHWQDzBJDTrmMd/gPWBhN89D1x49lyWyrsxqYFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WN2tAxV0o94rrrv4Q1mxW19tNTWQQ5CWz3ite40yZWPQ26hegLuQMbZHIYXdVf63u
	 DzLAdrjEEbhIwyxrdddU0mu8kKSQqhAQ98zB7/1IckQo4uNiyf2oHOE1kDZ6nDkCnN
	 vd1TU46xOto3ARQVIrNRMxeKq3fSWlcs/X2egEt+sKhWJIZ2bFF+TaPlRO8dKdfFkr
	 nepRtpJFQxml9hoT6uXbJXfh5yWq6VogDgOQjP5azfaz/zqWrpUd3/mlouJ/AjQo6P
	 1JcB1BIMrMd0QdCsYiZG8eMm7IaV6thorAeXgmX2laEB8ZgrDzh/VbTVlnu+shlOAk
	 qH+jKqWkfquIQ==
Date: Wed, 27 May 2026 15:33:31 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: tao <tao.wangtao@honor.com>
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	riel@surriel.com, harry@kernel.org, jannh@google.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 
	21cnbao@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahcANgFDFwfC0v1q@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>

OK I've had a look through more thoroughly now and:

NAK and NAK any approach like this.


Not only is this structurally all wrong, it does some insane stuff (pinning
VMAs - no), the RCU usage is highly dubious and I suspect you've completely
broken the anon rmap for things like migration, or have at least added very
dubious edge cases.

You've added insane complexity, and also have failed to add even
perfunctory tests, which is also totally unacceptable.

The implementation is wrong, and the approach is wrong - we do not want to
extend or build on anon_vma. So this is unmergeable, or any approach like
it.

I also, unfortunately, strongly suspect AI here. The turn of phrase, and
poor commit messages, you doing this out of nowhere with absolutely no rmap
experience before, your total lack of communication before.

Claude puts the probability of heavy AI usage at 85-90%, and I'm pretty
convinced. Either way it's utterly unmergeable but that you (likely) used
AI to generate this much work for us makes me actually pretty annoyed.

As a result, I would strongly suggest you no longer submit patches for the
reverse mapping part of mm, as there is now a real lack of trust.

If you wish to rebuild that, I suggest you _discuss_ concepts and ideas,
e.g. send stuff on-list with a [DISCUSSION] tag, and engage with the
community, and go from there.

It's also important to synchronise - I'm working on an anon rmap
replacement that I'm more than happy to discuss with you or anybody else
which should achieve the same numbers in an architecturally sound way.

You going off and, in a vacuum, generating a bunch of code with an
unacceptable approach is not a civil way of engaging nor is it a good use
of your time, or maintainer time looking at it.

Thanks, Lorenzo
