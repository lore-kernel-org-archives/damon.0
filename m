Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D148330D28
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979662; cv=none; b=S5yey6e5kbSeDuewvvVplGiUOMBgvT5dne+E/R36OV759g63Rp7aZedXDJgfReltMc2aT0Qu780lvahy8Tmq0B5ctXXZb39Lb0POVSghz6k/Je5VWtRY5a5QipiZiGHVt1/uUZz/AVSXyl8nU9kEshiM4MuB+VLlqwN1TEoyd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979662; c=relaxed/simple;
	bh=TBvVXVaoCvYgFGMs+MGQEyfutR/RPhh0I6VfNYwQCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2oimTOFrZkNf+WzWZVRWqF0GTAaYJOpsOyl4F8NtoBuI519myqCs8j2OSUSGE9gVe8vrNVjS0E1qOczpBZLjDsIPvbHTjbAJ28TUvtrFtw8iMveYwPBxU9N6vN1FiXXA29sIK9JvIY9i8LiZctnS2RkUt/Q4VqBTiCNAp7m8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyCw8LSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyCw8LSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6411A1F000E9;
	Sat, 20 Jun 2026 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781979660;
	bh=WCH1cmcbKkTYMxWwnMKBJncVglrgW/0EDgmzFz48UNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyCw8LSX8Fa3yjK/Brk2CSqQvzaits1jrPYQBrtRoIDmwmkgAiW6Zx5Nx5NoDYhk3
	 4w80tOawEbKmXPX5x25LnAldbAhYzBnMTfhM9rc3qrCnd2DrOzlvqj4I6Usu/qAU/t
	 kOm5IaaaSVNz8iQXq3eWebXwW+8LIcckrYgRO4ZmgUHzjeBJ/tEqUj6wu2YzBPoBQQ
	 FzpV7FNXVOJ7Xx8rNxmghvBf5/gZSjcGntzS0NOULZa4X7RG8bn9XuhNVHy9j9uF1T
	 G3R8JYFF6LxLhN+hPR8Hr0OL8GQZ5tHq/mgR9cm1r4HJ3+tRz5OU63deKJxuvIqz7/
	 923kLF4BkVZlg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 11/13] mm/damon/core: remove nr_accesses_bp setups and updates
Date: Sat, 20 Jun 2026 11:20:50 -0700
Message-ID: <20260620182050.93721-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620174553.92751-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 10:45:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 20 Jun 2026 17:34:30 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The `attrs` parameter in `damon_update_region_access_rate()` is completely unused after this patch.
> > --
> > 
> > commit ecb338097e9822ecdcbfa5f88676102211ac76ca
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/core: remove nr_accesses_bp setups and updates
> > 
> > This commit removes the setups and updates of the nr_accesses_bp field
> > in the DAMON core. The field is no longer used for any real purpose and
> > has been replaced by a simpler function.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 53568a3c3ad9b..a41b66b26a472 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -3779,18 +3774,6 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
> > >  void damon_update_region_access_rate(struct damon_region *r, bool accessed,
> > >  		struct damon_attrs *attrs)
> > >  {
> > > -	unsigned int len_window = 1;
> > > -
> > > -	/*
> > > -	 * sample_interval can be zero, but cannot be larger than
> > > -	 * aggr_interval, owing to validation of damon_set_attrs().
> > > -	 */
> > > -	if (attrs->sample_interval)
> > > -		len_window = damon_max_nr_accesses(attrs);
> > > -	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
> > > -			r->last_nr_accesses * 10000, len_window,
> > > -			accessed ? 10000 : 0);
> > > -
> > >  	if (accessed)
> > >  		r->nr_accesses++;
> > >  }
> > 
> > [Severity: Low]
> > Does this leave the attrs parameter completely unused in
> > damon_update_region_access_rate()? 
> > 
> > Since the removal of the damon_moving_sum() logic removes the only use of
> > attrs inside this function, could we also drop the struct damon_attrs *attrs
> > parameter from the signature and its callers to fully clean up the API?
> 
> Good finding.  But not necessarily as a part of this series.  I will add this
> as a todo.

I changed my mind.  I will do this as part of this series in the next revision.


Thanks,
SJ

[...]
