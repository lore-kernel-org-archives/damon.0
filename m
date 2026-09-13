Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413494BEE4A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321212; cv=none; b=T8E0/Qax4bp/hRwOP+engnpx95p3Fm569CQEC3Q75o39gXAivUvGi27VMbvf19z89FBq+MhstVeQJWYATKyfCut4R+ziU/v1zMxwjm7XP3CzzJv+MGB2QNqcs1l4Nw/BB9N9bDhBR+RtKB2CWAfK8jQ4mC8KlIHhmffcOrPc4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321212; c=relaxed/simple;
	bh=l/QE9FOD7dDZAOZUQh2vyALft9qEHLJwLyJhNuKeYyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZanxBX9Extb4V8sxYu6PkKummbPz2N0V+zRrC96mC1oa5RCyXizMl2uHt2fhfw8KUlZqGQCddyNvUFK95WC9g5IhzSzPHXEH0gXitYn4WnK0RCvEapNJo0vHDNlxghXv0OAlev/REnrNkSZb/Tjq9oZbnCBY7HZaEyt/dp07OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMZXFCGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMZXFCGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB81F000FF;
	Sun, 13 Sep 2026 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321210;
	bh=9W6E78fS/5+ZKpbTnZIuSdlCOEdO07/6QDW1nnZESyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMZXFCGKzHniBWB4AN3aqiq/qf4Ng4ROOFVW6sj/l64Svhdhnr4Zys4oYsq0E01Mx
	 U/Kcq3+JDWTh29/QyWl0Wp85RtzVM5zoLN1nfSBQMF5as2WgV0YWBB/Hlt1v9d10M1
	 7sSdMF3uu+8AUsQTRFdMEINcwmg36F3UHlF43KbugU+0OCx3NbGp8RzxFckMd/iSd3
	 gcwJ2cKKQpx5DVikXUaxAiNZoqae/9zyvrGVNqnRYO3n5awwLQq1oXm+ebP5kyT0lj
	 M/4gvfxd3e1/lGq7m5bnuj1ruByJ6YC7iTtZ/67uwhha1sjZB/JtM0AXnQMopM4tyP
	 WL3fcwP96iFpA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/8] mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Date: Sun, 13 Sep 2026 10:40:02 -0700
Message-ID: <20260913174003.104698-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913173143.104105-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 10:31:42 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 13 Sep 2026 17:22:04 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Uninitialized memory usage for new `DAMON_FILTER_TYPE_HUGEPAGE_SIZE` filters.
> > --
> > 
> > commit 1e4870705ac75e710966e11c09d2b8438d7b1bb1
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
> > 
> > Introduce a new data attribute probe filter type, hugepage_size. It will
> > work for memory that is backed by a hugepage of a given size range. Add a
> > new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to identify the
> > type.
> > 
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index 4be7d1df8e71f..bbb190b474015 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > 
> > [ ... ]
> > 
> > > @@ -798,6 +800,8 @@ enum damon_filter_type {
> > >   * @matching:	Whether this filter is for the type-matching ones.
> > >   * @allow:	Whether the @type-@matching ones should pass this filter.
> > >   * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
> > > + * @range_min:	Minimum value of range arguments.
> > > + * @range_max:	Maximum value of range arguments.
> > >   */
> > >  struct damon_filter {
> > >  	enum damon_filter_type type;
> > > @@ -805,6 +809,10 @@ struct damon_filter {
> > >  	bool allow;
> > >  	union {
> > >  		u64 memcg_id;
> > > +		struct {
> > > +			unsigned long range_min;
> > > +			unsigned long range_max;
> > > +		};
> > 
> > [Severity: High]
> > Will the range_min and range_max fields remain uninitialized when a filter
> > of type DAMON_FILTER_TYPE_HUGEPAGE_SIZE is committed?
> > 
> > Looking at damon_commit_filters() in mm/damon/core.c, new filters are allocated
> > but the switch statement doesn't have a case to copy the new size fields:
> > 
> > mm/damon/core.c:damon_commit_filters() {
> > 	...
> > 	new_filter = damon_new_filter(src_filter->type,
> > 			src_filter->matching, src_filter->allow);
> > 	if (!new_filter)
> > 		return -ENOMEM;
> > 	switch (src_filter->type) {
> > 	case DAMON_FILTER_TYPE_MEMCG:
> > 		new_filter->memcg_id = src_filter->memcg_id;
> > 		break;
> > 	default:
> > 		break;
> > 	}
> > 	...
> > }
> > 
> > Since the switch falls through to default, range_min and range_max are not
> > copied from the source filter, leaving them as random heap garbage. Later,
> > when damon_ops_filter_match() evaluates the filter, it checks the page size
> > against these uninitialized bounds.
> > 
> > Also, the unit test for committing filters seems to omit checking this new
> > type as well, which is why it didn't catch the missing copy:
> > 
> > mm/damon/tests/core-kunit.h:damon_test_commit_filter_for() {
> > 	...
> > 	switch (src->type) {
> > 	case DAMON_FILTER_TYPE_MEMCG:
> > 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> > 		break;
> > 	default:
> > 		break;
> > 	}
> > 	...
> > }
> > 
> > Should these switch statements be updated to explicitly handle
> > DAMON_FILTER_TYPE_HUGEPAGE_SIZE?
> 
> Yes, and that is what the next patch of this series is doing.

I was wrong.  I will fix this in the next spin.

> 
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=1
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
