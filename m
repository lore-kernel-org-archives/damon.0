Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778543;
	b=BDXGaP0bERrqhkCd7UOOVLkh2yMpFNPM1ngQFJamQjzOhy4jF/lv9QCBvmiXIhqsHzC6
	 CmYCBFawMmX/3TbLH685ErmM9My1p+08KeK7lLp6wgjEBVloVTFTMw3UNSpdux1xc2l2G
	 poffg9p0ZTMG7+FuxYtI56lbgSmpd43XycnSC+iXPFSiNWH/IKQzcCUmHDhgRdbm+CCdT
	 ef/kTvA0bSNzyre/Lc3bNHzP+EQFBIdUTYvIT/PS85G4IDQ5sqkYBKT9adOKCQXEvKbHN
	 7v4kItpXohCiQSsGjYQvw/ZJPCdQEK/PmgRtz9/pqoN70CupADWrb6Nxp2SYnXvaJeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=seYfiqW9sYksqDlchrDoMfIpdIMNoieEec+Ihfz/jxA=;
	b=1WhxIxdo4YKh3vIxKXm1cUwCVf+MfVOZtIKaUwrAE7hgkutND0C2lz8AtvfDHaXuctH1
	 dX810ztXO5rgWT8xIe1m7WkqINrlOhwRHz+PHcfPYHr64aYcGP5mB6/e4vsYSoV8+rU8r
	 tx7s4K67vCrfv7X+bniosTmImmo73JJ3oGydmQ9cVAGCEfaHR5r5bBF0XVbNXtG9KweZz
	 7/DYYDtMdVeFJ/GYWb0kvgNsgL7bFcM06wZYOEpAQyU59UzbkimeJDJCbInNe4qtTYBT1
	 DCZa2e3Oh6WdJ6Dgam5J+6RNzb5fiS/SYSEzWqPz2dB16oVFUiCTV8ghXnkCfvBHMMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8oIL1rm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2407606A32C
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8oIL1rm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D67A1F000C4;
	Sun, 15 Nov 2026 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778542;
	bh=seYfiqW9sYksqDlchrDoMfIpdIMNoieEec+Ihfz/jxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8oIL1rmrVsbQZXgaZ3kryZObNNSR/loTyje4n4lAp9ZlUh0sxtCJ0QkD3qyooSdh
	 AQ4gZ8LxCcIvfjyMGc9qLx7+sZY4h5GVGh3UynMulSDz4Rxtl8xYNtfDkjwKK0/sqy
	 AASjeL7BGIsDjk54Da/RRpuPN0RrOwPf3gPNwYtLUHadO6vZDcmJMfrZa4Nfr6nUQq
	 r+qkphEqejKexT8z69xQxcWYLTSC24EiuhZJw2p8/NjM1M11QbhlqaClzOuwRRxG5e
	 vXHaJdJs2f28VhC1bXgUHviXZYPdrIC8eiNmsEIuDTp14w3U2R7DuiQ7eLJWLnn4aE
	 9R+MPpHj9lTvQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Date: Sun, 15 Nov 2026 13:35:34 -0800
Message-ID: <20261115213535.103582-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215847@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 15 Nov 2026 20:37:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/damon/core: out-of-bounds and uninitialized read in
>   damon_report_exist()
> --
> 
> commit be7b07b7677627ddaaa72484649217b5172610a1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_report_exist()
> 
> This commit adds damon_report_exist() to search damon_report_queue for a
> report matching a given type, address range, and minimum age in jiffies.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c02c7fbc1d864..c60a6504d0a15 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2386,6 +2386,52 @@ int damon_submit_report(struct damon_report *report)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * damon_report_exist() - Find if a report of a given condition exists.
> > + *
> > + * @report_type:	Type of the report.
> > + * @addr_range:		Address range of the report.
> > + * @jiffies_old:	Oldest jiffies to find the report for.
> > + *
> > + * Returns true if the report is found, false otherwise.
> > + */
> > +bool damon_report_exist(enum damon_report_type report_type,
> > +		struct damon_addr_range *addr_range, unsigned long jiffies_old)
> > +{
> > +	struct damon_report_queue *queue;
> > +	int lock_old_val;
> > +	unsigned int idx, nr_read;
> > +	struct damon_report *report;
> > +	bool found = false;
> > +
> > +	queue = &damon_report_queue;
> > +	lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
> > +
> > +	if (lock_old_val)
> > +		return false;
> > +	idx = queue->tail;
> > +	for (nr_read = 0; nr_read < queue->nr_reports; nr_read++) {
> > +		report = &queue->reports[idx];
> > +		if (idx)
> > +			idx--;
> > +		else
> > +			idx = queue->size - 1;
> 
> [Severity: High]
> Can indexing queue->reports[idx] before decrementing and wrapping idx read
> uninitialized or out-of-bounds memory?
> 
> In damon_submit_report(), queue->tail is post-incremented after writing
> queue->reports[tail]:
> 
> mm/damon/core.c:damon_submit_report() {
> 	...
> 	tail = queue->tail;
> 	if (tail == queue->size)
> 		tail = 0;
> 	queue->reports[tail] = *report;
> 	queue->tail++;
> 	...
> }
> 
> Because queue->tail points one slot past the newest report, the first
> iteration of damon_report_exist() reads the unwritten slot at
> queue->reports[queue->tail] (which is allocated with kmalloc_objs() in
> damon_init() without zeroing) and never visits queue->reports[0].  Once
> queue->size (1000) reports have been submitted, queue->tail reaches 1000
> and the first iteration reads queue->reports[1000], one element past the
> end of the array.  Also, when damon_submit_report() wraps local tail to 0,
> queue->tail itself is not wrapped and increments past queue->size on
> subsequent submissions.
> 
> Should idx be decremented (wrapping from 0 to queue->size - 1) before
> indexing queue->reports[idx], with damon_submit_report() updating
> queue->tail = tail + 1?

Good catch.  I will move queue->reports[idx] after the idx decrement.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=13
> 


Thanks,
SJ
