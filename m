Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47096A59;
	Tue, 22 Apr 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346215; cv=none; b=BbwZ5ss0Bhv8RBHsYegmcisidDQWC/95IhWrhMrIN4Ny19/2k1nl77jvFMcxlmxpppUov8lQqeM2cnPwZRO1gxWnfC+HrdK0tqcodKtaMWQys3uat2+IP/rw1dlcQftZgESHnsjRSMZUjMykrk5ajlCnB86V/cinbu0SNDsOfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346215; c=relaxed/simple;
	bh=GGXktewUewz/nCPocxoFhsFF9bvV8KlcmNW4nrQWjcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBKlxxG6RKHzT1e641TNHRDsmzx+dmMuX5lCTZxXOD5KuoRqx4ewQGqTwaytLbwSBsrnzzHSt9lKn4tOHt62ZTZTEdy7rh9m/1SJ7WlFSTZmdrseVjQXcdDMb1pePauKJiYeMI69TrLh/kybXysfzwX5Lm3Bg+sr9VvHt/5IDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVuGwvnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVuGwvnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DADDC4CEE9;
	Tue, 22 Apr 2025 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745346214;
	bh=GGXktewUewz/nCPocxoFhsFF9bvV8KlcmNW4nrQWjcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVuGwvnMr+u4BSDFaJL/SXFU1tLN3/lIs8TFy9Cp/fEd2OvgyB5p7cFFlAuGwT25E
	 RCpYhsm7RHsum7fe1q5P9CLJ/RUn2MgPSqJRHqsE0nmPv0mSCoigwSkkhUO+RVAVGR
	 aQTEio9Jjves6Dw+qpggK2wB5EYeDL/+JRRkhw0HcEQq6gvG6of3aJfLld1Ew1coOI
	 YKVJESESm9ImKsIRyq8zfK7nZh2HWi5nYuqiP0qmmX7MuMXRHENXmclpbP4K7WgtkI
	 53CuTReAorBsHbfTiFf/4vGeATfOqDyDp3AJxxHYXnmy+T+EZ5nG3Hbti3T5XS4VEy
	 oQUWAJEAfYjkA==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	Su Hui <suhui@nfschina.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and size_add()
Date: Tue, 22 Apr 2025 11:23:31 -0700
Message-Id: <20250422182331.59651-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <adbc06d8-1a6c-4279-9596-d743505d64dd@stanley.mountain>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Apr 2025 13:44:39 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
> > On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> > > It's safer to using kmalloc_array() and size_add() because it can
> > > prevent possible overflow problem.
> > > 
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
[...]
> > > --- a/mm/damon/sysfs-schemes.c
> > > +++ b/mm/damon/sysfs-schemes.c
> > > @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
> > >  {
> > >  	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> > >  			struct damon_sysfs_scheme_filter, kobj);
> > > -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> > > +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> > > +				   GFP_KERNEL);
> > 
> > Count is clamped in rw_verify_area().
> > 
> > Smatch does a kind of ugly hack to handle rw_verify_area() which is that
> > it says neither the count nor the pos can be more than 1G.  And obviously
> > files which are larger than 2GB exist but pretending they don't silences
> > all these integer overflow warnings.
> > 
> 
> Actually rw_verify_area() ensures that "pos + count" can't overflow.  But
> here we are multiplying.  Fortunately, we are multiplying by 1 so that's
> safe and also count can't be larger than PAGE_SIZE here which is safe as
> well.

Thank you for adding these details, Dan.  I understand the size_add() change
can make warnings slience, though it is not really fixing a real bug.  So I
believe there is no action item to make a change to this patch.  Maybe making
the commit message more clarified can be helpful, though?

Please let me know if I'm misunderstanding your point and/or you want some
changes.


Thanks,
SJ

> 
> regards,
> dan carpenter
