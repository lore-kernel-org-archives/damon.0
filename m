Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722E3B7B70
	for <damon@lists.linux.dev>; Wed, 15 Jul 2026 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086357; cv=none; b=OjdV/rR8L44Z29pI7jvaZrRJtA9rinMD/Xn9L5AAMJs3R0DpDRCBJVPVpEpYP80wBIEh+c/WsKoCUPRVpaxfmgvT8EKdibrqbLDkOo9jJffyYRN3CEChRckGAstIthePo1NbAoOy6GXhm/WMmgOMsXQ9ePtbXjbkhvEUYXgVRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086357; c=relaxed/simple;
	bh=XvThbt0qm+Jc+aDkk43NlcQbR79Ru0xMqNqxL0qUS5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8ODlz15ClT9X0yfkC9wAXBfsijB6MKCMw7mwlrvG137DrO8hInD+suK5e2N55L3S6xEaGIlmYio6GfQ15kiSexFD4f05gGVyIodMQdoKgqP/MGuIWaK7Wvuidlq8KIxudVziwf7RbaDE6b3W5UUUY9TkTepYnR59ZXOqXaQTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+gyNwlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+gyNwlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0491F000E9;
	Wed, 15 Jul 2026 03:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784086325;
	bh=tf0+9snvd6vxmMttu6rb0rYJ+TkMQeAijWdR5K21J8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+gyNwlOCa7qRiBhDo4eXtlJNZGyLt310xe9hljqfbFr+37vosfeLxxbGO46IBGPb
	 puMGBZybN+F8lulOgvcWFD37Kl92WwO346TkmKxI72kkZOgmZ6KpZ2Z2uKxQkdRmCj
	 O0z6OWDX6G8lOJnblUkCLxxwRHDRMR3g68L5VIsd0x2gJy27bPk/KGZERLArBgqYPw
	 2PgBHN3d01JdVfIyonBGGxyj0RZsbUU1WeTgv26Y1NckwKKGLEo/9p72uvTBE3j+rh
	 ZXN8Df3qZTJw8sjnBE3ZWcDNIbjaV9YcaygJbAZrBWqc0gX1r+VzpNKCE0rUdoZVz0
	 vBrnBMdUw1/gg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v1.1 2/6] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue, 14 Jul 2026 20:31:56 -0700
Message-ID: <20260715033157.109327-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715031908.683501F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 03:19:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The patch correctly identifies that `KUNIT_EXPECT_EQ()` does not abort test execution on failure, which causes undefined behavior in subsequent code if the test expectation is not met. However, it leaves the exact same anti-pattern unfixed in several other test helper functions within the DAMON test suite. This can lead to out-of-bounds (OOB) array reads, NULL pointer dereferences, and slab corruption when test failures occur.
> --
> 
> --- Patch [2]: [PATCH v1.1 2/6] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of() ---
> commit ce2690fbbc97573d0a06744653f652063e18c91b
> Author: SJ Park <sj@kernel.org>
> Date:   Wed Jul 15 03:09:57 2026 +0000
> 
> mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
> 
> This commit fixes an issue where KUNIT_EXPECT_EQ() failures do not abort
> the test, leading to potential NULL pointer dereferences in subsequent
> code. It addresses this in damon_test_merge_regions_of() by explicitly
> checking the expectation and skipping the rest of the test if it fails.
> 
> Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 485472ddebd19..eba643762132f 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
> >  	damon_merge_regions_of(t, 9, 9999, ctx, true);
> >  	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
> >  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
> > +	if (damon_nr_regions(t) != 6)
> > +		goto out;
> >  	for (i = 0; i < 6; i++) {
> >  		r = __nth_region_of(t, i);
> >  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
> >  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
> >  	}
> > +out:
> >  	damon_free_target(t);
> >  	damon_destroy_ctx(ctx);
> >  }
> 
> [Severity: Medium]
> This is a pre-existing issue, but while you are fixing this anti-pattern
> here, the exact same missing abort condition exists in several other
> functions within the DAMON test suite.
> 
> For example, in mm/damon/tests/core-kunit.h:damos_test_commit_dests_for():
> 
>     KUNIT_EXPECT_EQ(test, dst.nr_dests, src_nr_dests);
>     for (i = 0; i < dst.nr_dests; i++) {
>         KUNIT_EXPECT_EQ(test, dst.node_id_arr[i], src_node_id_arr[i]);
> 
> If the expectation fails, could this loop read out-of-bounds on
> src_node_id_arr since it iterates based on dst.nr_dests?
> 
> Similarly, in mm/damon/tests/core-kunit.h:damon_test_split_at():
> 
>     r_new = damon_next_region(r);
>     KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
> 
> Could damon_next_region() yield an invalid pointer if the split fails,
> causing a crash when r_new->ar.start is accessed unconditionally?
> 
> The same unbounded array access or unsafe pointer dereference pattern
> appears to exist in:
> - mm/damon/tests/core-kunit.h:damos_test_commit_quota_goals_for()
> - mm/damon/tests/core-kunit.h:damon_test_commit_target_regions_for()
> - mm/damon/tests/core-kunit.h:damos_test_filter_out()
> - mm/damon/tests/vaddr-kunit.h:damon_do_test_apply_three_regions()
> 
> Would it make sense to update these remaining occurrences in a follow-up or
> v2 of this patch to prevent slab corruption or NULL pointer dereferences
> during test failures?

I will fix those as a followup.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260715031002.108504-1-sj@kernel.org?part=2


Thanks,
SJ
