Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4D2E2DCF;
	Mon, 15 Sep 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960815; cv=none; b=CluiYfv485kERMzLDleAFEl54HHuW5T8zIxRnO92RYfGY8aGCvO8iREPJzSHTerBF0CazKhCHbAbQ7NDlx5PzNGF8dvmz1Bl7LzTvMRkXa3M33OHRFRXEeMt9dA41GR4m6+6V73wiAnBScJhxb5FoJXj9vC1S+feLxjk/vWcb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960815; c=relaxed/simple;
	bh=ZlwLFFbUZ7SUw1fTcU2d+newTqMg71wB985Uf0+wEDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM0kNuCkAVhWKa83buNaPmssCHKFwXGa0vUSmEK5IXZ86wmuzuOiV0KwWG9B2zdVMlIiD67XvFVFpeylBtDfV2LAzWVSoQVllQHttZ2e1vyTFenkdhMv7EosaGqxzTisDrrnSwzHyb0q+gXXwynbOHPzmW1NGOkioyCzbcI5Zug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0R/xPtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0R/xPtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BE0C4CEFA;
	Mon, 15 Sep 2025 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757960815;
	bh=ZlwLFFbUZ7SUw1fTcU2d+newTqMg71wB985Uf0+wEDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0R/xPtqF4vOpA4RsS+6m6W4efIbgihjPzTJWDO46T7vsYoTolCa/wg0cQQZWjwLn
	 V2JX80luxNk04KPKMTnH+CAwOfnQxhwHnFZx1PKfnVymKNDkYFdpYVDpBY6dteG5MB
	 wjzEDW/UGZ3Yhp4cYIN6O7GSF5Q2lRCcB5JFUFr3+bK0j1M39jIq77VGseOnszyrY1
	 a4mAfVrEPGTli/BV6+K+v5bLMAba/0PZyRvrswH49qnpGiBpR2lMe3G/RZOfWQBk24
	 286/JS2abr8+pOLycaIxHjnPvD1mt1rKG5s7sYjze3aWO5+tKOs9Rgo6WQo/rRZKEP
	 Zdk05PZeVrtSg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Mon, 15 Sep 2025 11:26:51 -0700
Message-Id: <20250915182652.110173-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915145158.1425390-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 07:51:57 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sun, 14 Sep 2025 18:58:02 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON resets the age of a region if its nr_accesses value has
> > significantly changed. Specifically, the threshold is calculated as 20%
> > of largest nr_accesses of the current snapshot.  This means that regions
> > changing the nr_accesses from zero to small non-zero value or from a
> > small non-zero value to zero will keep the age.  Since many users treat
> > zero nr_accesses regions special, this can be confusing.  Kernel code
> > including DAMOS' regions priority calculation and DAMON_STAT's idle time
> > calculation also treat zero nr_accesses regions special.  Make it
> > unconfusing by resetting the age when the nr_accesses changes between
> > zero and a non-zero value.
> 
> Hi SJ,
> 
> Thank you for the patch, I think the goal of the patch makes sesne to me.
> I have a small nit / idea which I think makes the code a bit clearer, at least
> for me. It seems that we basically want to XOR the two values's zero-ness, so
> maybe something like 
> 
> (!!r->nr_accesses) ^ (!!r->last_nr_access) or
> (r->nr_accesses == 0) ^ (r->last_nr_access == 0)
> 
> Can achieve the goal?

Thank you for the idea, this makes sense!

> I know bitwise operations are sometimes harder to
> understand, so I am just throwing the idea out there : -) 

To be honest I'm one of people who are not familiar with XOR.  I had to spend a
minute to understand the above.  Maybe we can replace '^' with '!=', and it is
easier to read for me.  If you don't mind, I will use below in the next
version:

   else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))

Please let me know if I'm missing something or you have other opinions.

> 
> 
> Anyways, the rest of it looks good to me, please feel free to add my review!
> 
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you!

> 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index be5942435d78..996647caca02 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2261,6 +2261,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> >  	damon_for_each_region_safe(r, next, t) {
> >  		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> >  			r->age = 0;
> > +		else if ((!r->nr_accesses && r->last_nr_accesses) ||
> > +				(r->nr_accesses && !r->last_nr_accesses))
> > +			r->age = 0;
> >  		else
> >  			r->age++;
> >  
> > -- 
> > 2.39.5
> 
> Sent using hkml (https://github.com/sjp38/hackermail)


Thanks,
SJ

[...]
