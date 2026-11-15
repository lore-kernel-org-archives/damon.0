Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779012;
	b=KCEwXP15293V95lNVsJQydsv1BA+IiNgV6IPREtW9Lli5wIshQ7yADQeylry2IWSqhu4
	 Su6i6gRxC42otN0cCUY3OHA+De6ebwRf5zvO82TkVP3+/GYRLWiq2JBNFEWefp5iHUyAk
	 +SMMvcTabv1OO6t8+vnQ85V7Xd4H2uNNEZbkNeA4y4m4il+zeHrJnQxsExYTrDS9DAIhD
	 lxv0ajTnxBrLk6Q4+LQ+xIJ9SdHAIw/GfCbS6r7dQZp+sUo5s5zUUokjZx4AbJZ+trV2X
	 KeV2NxDW2ITH0qU7RylEjvMuvJZM+viEkAU+T+U0MuVVpsDFBxOXGCNx+ZhpGSbM+qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779012;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=At5BFZ8I2aCU5FwPovXmPCKJBj+XIcaUYG7iZYPdJ7Q=;
	b=SS4JXzs3RZ3osiKSdX+UHTYFrHWMdhKEv0bnZcCnBBCQdPGBvNjAze/ZR44ylhVOuCz3
	 xpxoHHqOitoDPX2QIc24Rh0DDtXSwnfJyNGgZkMv6opmYrzp5MYNv7Pp7cgi26WUtFlik
	 PrN6cFFUXF0UQW2geGnow8KVfbeWNOimtSlh33+/eqPDDtPLgLVSmyRVMxr/74IKmdyGc
	 SvQY9Xt18yJIQVllACS761mds1F6YpXLL9cWyi5U59ydYGJ8jk3bSeyXWyX5iAPPes9a3
	 A1s5VcM+8dDnQU45XwRMeoqgvoM0ijVHM+Xkz8wtbwtXU+wpI82TevFjsRiWY9Eahmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWqv1Tsc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900F606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWqv1Tsc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26B1F000C4;
	Sun, 15 Nov 2026 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794779012;
	bh=At5BFZ8I2aCU5FwPovXmPCKJBj+XIcaUYG7iZYPdJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWqv1TsceirUVxDuqWjxvorqJmkWt/oZ3x2Pn6vRqiGsaLOOg3oBhAgUvBTYUrjgx
	 7Ss86Rm+IEoL6mXUe460FUQlDv2pPK3sB0G109c0IgNM4JgLbjg9zmzr+3BObAHTIP
	 tqExd+jifuy/doLTkdzaHDWvSMEEHTJuv0pGn+aRXiFdOQ6iPnuOBxCU7Tgo6CGdIc
	 NmjM/TsXC05ZZ8c5Y22hBbbh/5vINTZ4zUU/IB2iyQAQlA/nzqItD2hSbr0c3OslOA
	 j01KcyEsBcQyc0/qtxxFYok0dzUwTdgQxm+5ajDqyP4DI8lS02wRSxtOgONDA7WdGX
	 lr4iNSunAciDg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 23/27] mm/damon/sysfs: implement submit command for report producer
Date: Sun, 15 Nov 2026 13:43:23 -0800
Message-ID: <20261115214325.104133-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215852@kernel.org>
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

On Sun, 15 Nov 2026 20:43:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] mm/damon: OOB write in damon_submit_report() and read in
>   damon_report_exist()
> --
> 
> commit 2f4ed587e778c0d51407454ba3a19b21c1bc10c0
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement submit command for report producer
> 
> This commit adds a "submit" command to producer_state_store() so userspace
> can submit manual reports via damon_submit_report().
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 5f9bb1955dfd5..0049aac6ab974 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -3107,13 +3107,26 @@ static ssize_t producer_state_store(struct kobject *kobj,
> >  {
> >  	struct damon_sysfs_producer *producer = container_of(kobj,
> >  			struct damon_sysfs_producer, kobj);
> > +	struct damon_report report;
> > +	int err;
> >  
> > -	if (sysfs_streq(buf, "on"))
> > +	if (sysfs_streq(buf, "on")) {
> >  		producer->enabled = true;
> > -	else if (sysfs_streq(buf, "off"))
> > +	} else if (sysfs_streq(buf, "off")) {
> >  		producer->enabled = false;
> > -	else
> > +	} else if (sysfs_streq(buf, "submit")) {
> > +		if (!producer->enabled)
> > +			return -EINVAL;
> > +		if (producer->report_type != DAMON_REPORT_TYPE_USER_REPORT)
> > +			return -EINVAL;
> > +		report.type = DAMON_REPORT_TYPE_USER_REPORT;
> > +		report.addr_range = producer->addr_range;
> > +		err = damon_submit_report(&report);
> 
> [Severity: High]
> Can repeated "submit" writes overflow damon_report_queue.reports[] in
> damon_submit_report() and read out of bounds in damon_report_exist()?
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
> When queue->tail reaches queue->size (1000), damon_submit_report() wraps
> only the local variable tail to 0 and still increments queue->tail to
> 1001 instead of setting queue->tail = tail + 1.  On the next submission,
> tail is 1001, the equality check against queue->size is false, and
> queue->reports[tail] writes past the end of the 1000-element heap array.
> 
> In addition, damon_report_exist() starts its backward scan at
> idx = queue->tail (the next free slot) and dereferences
> queue->reports[idx] before decrementing idx:
> 
> mm/damon/core.c:damon_report_exist() {
> 	...
> 	idx = queue->tail;
> 	for (nr_read = 0; nr_read < queue->nr_reports; nr_read++) {
> 		report = &queue->reports[idx];
> 		if (idx)
> 			idx--;
> 		else
> 			idx = queue->size - 1;
> 	...
> }
> 
> Before the ring wraps, the first iteration reads uninitialized memory at
> queue->reports[queue->tail] while the loop stops before reaching
> queue->reports[0], missing a single submitted report entirely; once
> 1000 reports have been submitted (queue->tail == queue->size), the first
> iteration reads out of bounds at queue->reports[1000].

Yes, I will fix those in the earlier patches.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=23
> 


Thanks,
SJ
