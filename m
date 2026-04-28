Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018971CFBA;
	Tue, 28 Apr 2026 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337318; cv=none; b=TQtSpvhoqTy0hj9tm1Ef27D+agk0Hbge9DaYNhJmsVcs2foQxbts7VQFngX/h4D59mGtfqVlq0DwVnS6fpR5lpN1EtjcQzIWLZ9u0kmhPf5f7cVxbyM663RKOb4uAodN5/fgaW5NNqqsmo0Zu/th8Y6b7QBGT0SiJVHgrQsEr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337318; c=relaxed/simple;
	bh=pd3+iRU6SOVvmr/+JRNFN6pYsH/uGBTxvrVYDB0Q7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVe3I/pi2PH0om6E3u0T+68PVSXZU4WQzBRqCcuge9NIPoXIEfVPAimCzH10Iu2j3fcAJrh6KLKIJakZauY0kNiqyQ+W4P8MftWfd6c2ARZEGYygk4MRguaI4Cs/5P9ZRRRHjn7geZDp48UxmMCCUUISnw+GKzxQ9ARqNnChMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFGKJMYF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFGKJMYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647B3C19425;
	Tue, 28 Apr 2026 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337317;
	bh=pd3+iRU6SOVvmr/+JRNFN6pYsH/uGBTxvrVYDB0Q7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFGKJMYFVziQKMOi80meVeeySNKwaUTXjvyviT6UdDxkWOqLrFnMdcukOaOItDaMy
	 ust66S1yRSZDX/tiS4rqrs9wnVH++NFbYgUJp0Ja6YdzUGaDuNQRxVcLk1o/xB4Nsd
	 4rTTgQAmkxJtmvBv3jUdXNLvQYcaF6GrwEO4k7MkLvn2kZpHPIukK4iBqYFpMSGhUu
	 BtjiPcoY++PinhReoYmA6Dnn3As6wBORzSAlL0+lOWeeR4/Iuv644svs/SEqYi6sO/
	 YVmPUzmKTody2Ygj3Htipw2A2a+7JTS/vQdF13y/6P4CKbS6V2+bV/BjzTo3fO6NIT
	 suyhqNfHi8u9w==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 14/19] mm/damon/sysfs: setup probes on DAMON core API parameters
Date: Mon, 27 Apr 2026 17:48:29 -0700
Message-ID: <20260428004830.113597-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d08d7ffd-8d51-474d-bf57-887e09cf1b05@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for review, Asier!

On Mon, 27 Apr 2026 16:25:12 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 4/26/2026 11:52 PM, SeongJae Park wrote:
> > Add user-installed data probes to DAMON core API parameters, so that
> > user inputs for data probes are passed to DAMON core.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 2e0b7eca6bcbf..8007961295d3d 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1855,6 +1855,40 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
> >  	return damon_set_attrs(ctx, &attrs);
> >  }
> >  
> > +static int damon_sysfs_set_probes(struct damon_ctx *ctx,
> > +		struct damon_sysfs_probes *sys_probes)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < sys_probes->nr; i++) {
> > +		struct damon_sysfs_filters *sys_filters =
> > +			sys_probes->probes_arr[i]->filters;
> > +		struct damon_probe *c;
> > +		int j;
> > +
> > +		if (!sys_filters)
> > +			continue;
> > +		c = damon_new_probe();
> > +		if (!c)
> > +			return -ENOMEM;
> > +		damon_add_probe(ctx, c);
> > +
> > +		for (j = 0; j < sys_filters->nr; j++) {
> > +			struct damon_sysfs_filter *sys_filter =
> > +				sys_filters->filters_arr[j];
> > +			struct damon_filter *t;
> Move the declaration of these two variables to the top of the
> function.

I have no strong preference, but because this function is not very short, I
think having declaration here makes reading the code easier.  Also, this style
is used in multiple places of sysfs.c including damon_sysfs_add_targets().

So if I'm not missing something and you don't mind, I'd like to keep the
current style.


Thanks,
SJ

[...]
