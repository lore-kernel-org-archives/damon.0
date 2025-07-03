Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6429551E
	for <damon@lists.linux.dev>; Thu,  3 Jul 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519935; cv=none; b=EcBoKaOYnLmQ/qvrVVeVh398nKyS2wo0/fzUUSaycww1H5NeQHafmUr9Ta5vWu4HnWTtCO9BEXCz0fGxjlNLatYPPfZ3zLK1rqVC3cYx7YSs3J3I/mD7huFVWziYnpBX/DhW9EMdQvHziGuWF9pL+NKK8P5otsTUKWh3b+7v8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519935; c=relaxed/simple;
	bh=JjQCIbZ3BZls3N/LkIl0M9lFTvk+W4LmxpyJSX/Jy1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx7PXlI9nv0We8d5hHZYtloj2UTsall47AyE7585dpuF7txeUzqIzxHCFzsI3sP6t0wXZ2JsyCE/5uHyWkfpq/QNGsH36PA4aHz5+ViCIZUUMU1FAT3qdIEHtrT5ySRTOAFNM5gVzU5+z1wxB215HNZp3Dwmf1wMkyKcF0mmADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-eb-686612af9c20
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 2/2] samples/damon: add `migrate_hot` and `migrate_cold` knobs
Date: Thu,  3 Jul 2025 14:18:34 +0900
Message-ID: <20250703051836.1759-2-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250702000825.57587-1-sj@kernel.org>
References: <20250703051836.1759-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsXC9ZZnke56obQMg7uHrS3mrF/DZvHk/29W
	i8u75rBZ3Fvzn9Xi8Nc3TA6sHptWdbJ5bPo0id3jxIzfLB4vNs9k9Pi8SS6ANYrLJiU1J7Ms
	tUjfLoEr4/rGT0wFv4QqLkz4wNLA+IKvi5GTQ0LARGJt33oWGPvFp39gNpuAhsTBQyeZQWwR
	AUGJ/sczWLsYuTiYBeYyShw5854RJCEsECZx7cdmJhCbRUBV4uuyNWDNvALmEktWnGOEGKop
	0XDpHlgNp4CxxPvlzawgthBQzb3V39gg6gUlTs58AtbLLCAv0bx1NjNE7ww2ibvLwiBsSYmD
	K26wTGDkn4WkZRaSlgWMTKsYhTLzynITM3NM9DIq8zIr9JLzczcxAkNzWe2f6B2Mny4EH2IU
	4GBU4uF1kE/NEGJNLCuuzD3EKMHBrCTCyyebnCHEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hb
	eYqQQHpiSWp2ampBahFMlomDU6qBcVGsle8+3hiBFa2lVe8ypS6Y8UYXPt6z6JDN7ShRjx/m
	58TOM1d+kb6c4rZ5kcCGjyvmX8u0riqOUt5oH9x+RtVUU0ZykV1x5vwER6dny9d9vSuX1Dff
	d+fczxeX8EvVZKR9teB3vPYlxYTRuWu3cN9vzhmqqezSQq8ERTS/TEgWWKF59EuhEktxRqKh
	FnNRcSIA+we2fkkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXCNUNWR3e9UFqGwbIeQ4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4vGsOm8W9Nf9ZLQ5/fcPkwO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfG9Y2fmAp+CVVcmPCBpYHxBV8XIyeHhICJxItP
	/1hAbDYBDYmDh04yg9giAoIS/Y9nsHYxcnEwC8xllDhy5j0jSEJYIEzi2o/NTCA2i4CqxNdl
	a8CaeQXMJZasOMcIMVRTouHSPbAaTgFjiffLm1lBbCGgmnurv7FB1AtKnJz5BKyXWUBeonnr
	bOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERh8y2r/TNzB+OWy+yFG
	AQ5GJR5eB/nUDCHWxLLiytxDjBIczEoivHyyyRlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3C
	UxOEBNITS1KzU1MLUotgskwcnFINjCsmxzF07I44vuXohfB/PGp6vHPtuJ4tZtwlt5BhQYGk
	Y+0czkXiApIhjN7WCcvbav3DOj7U3zK6uMzgVf7uM/Msvzf/6X7OdWymq5d1q9qUPSXuri6m
	M3Pm7XaYpboo9+ztgqOcVs5G12Id2BkdaviVH+dIxc1YpbRBvW65qecx284qn+/7lViKMxIN
	tZiLihMBMInT8ToCAAA=
X-CFilter-Loop: Reflected

Hello SeongJae,

On Tue,  1 Jul 2025 17:08:25 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hello Yunjeong,
> 
> On Tue,  1 Jul 2025 17:54:17 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > This patch introduces two new konbs for promotion/demotion:
> > `migrate_hot` and `migrate_cold`. It receives node ids for migration in
> > a comma-separated format as `<src,dst>`. The usage is as follows:
> > 
> >     # demote pages from nid 0 to nid 1
> >     $ echo 0,1 > /sys/module/mtier/parameters/migrate_cold
> >     # promote pages from nid 1 to nid 0
> >     $ echo 1,0 > /sys/module/mtier/parameters/migrate_hot
> 
> I understand you want to support some setups such as having a fast node of id 1
> and a slow node of id 0.
> 
> Because mtier is a sample code, I think it's primary goal is to help developers
> know how they can use DAMON API functions for writing kernel code that is
> required for a situation similar to the sample.  Hence the sample should be
> clean and simple enough to be understood.

Thanks for explanation. I understand the intention of mtier module.
As you mentioned, mtier is helpful for leraning how to configure and 
run DAMON.

> 
> The assumption of the two nodes (the fast node 0 and the slow node 1) is
> arguably intended for making the code simple, in my opinion.  We could of
> course make this kind of changes if it helps more experiments for understanding
> the code, as sample code is not only for reading but also running.
> 

I also think that fast node 0 and the slow node 1 is intuitive and easy to
understand the code.

> > 
> > Susggested-by: Honggyu Kim <honggyu.kim@sk.com>
> 
> checkpatch.pl found a typo: s/Susggest/Suggest/
> 
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > ---
> >  samples/damon/mtier.c | 68 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> But, I feel like this change is rather making code too longer and complicated.
> Hence I would suggest dropping this patch if you agree.  Please let me know if
> you have different opinions, or I'm missing something.
> 

Ok, I will drop this patch in next version RFC. As you mentiond, mtier
module should be simple and intuitive enough. I will consider this
kind of tiering module to mm/damon. I'll send you RFC v2 soon.

Best Regards,
Yunjeong Mun

> 
> Thanks,
> SJ
> 
> [...]
