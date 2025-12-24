Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FD1D5CC6;
	Wed, 24 Dec 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766590291; cv=none; b=Iifc1a8FFK/kJ9k8Mea0McfspJ4u08EHZUPFx0IDD6aySaMZs85BtuDlt4VAUkKxXimZYqsD+UGtbTR3oA8MZZmaz7zXl1DqbkKSNSl9JYWnVKrcvIUg/7e0eXxEU16vXvV7Y04EArMMfg7F8IOIZ7ZKH2d+h8g9zVIU81JL7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766590291; c=relaxed/simple;
	bh=pYAUqa6oFZYO/VGx8zrWIvrkonzQsyd2twadgZmVNJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGwnpwRQcDV3X3ju2pwZv1MDcFSErXCUFaawL0OQz8sTWvmwBpVQQe+a64W9+Wr8fORYWS+CWK2JrFeJbCPlDmlw30b7mehe1gy6mVyUT8dB4qH14Nm0WeLwFasIIh+FPrB1tHHNBMLhuQ4fzq6+hNlo21eWSs3hE1928rEVDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikH47xnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikH47xnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F1C4CEF7;
	Wed, 24 Dec 2025 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766590288;
	bh=pYAUqa6oFZYO/VGx8zrWIvrkonzQsyd2twadgZmVNJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikH47xnwgcwk6YycFzvdnpoP/MCZ3++SorzRiscRX78pyuh8PaCvkA6a76/zuyARJ
	 MzQWd7Ozqdz5hEDC0Q7E04ZN8IML582sse5UatqofBWHqabCAFdqSG8Hru48qF27Xx
	 c0Yv1Xj704bqoYijArC5yH02+3QTj2GsbdB8BQwgIkK0POQYQB0KpsNM4fOvj3W5CU
	 wIaO9Mp3lqwm/FSrcNoHzmsUwa6s81AzklS7UAqaPgZyAeqBETu62pz/EljNd09l6V
	 JKFAcZx0ZWvapytQ3UjGNSTAp+CBoVk6yIzxO6QKyZMhPKTFHVypA+Uao4YNwTB5Q/
	 mTOb3CtYf2WKw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shu Anzai <shu17az@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm/damon/tests/core-kunit: add test cases for multiple regions in damon_test_split_regions_of()
Date: Wed, 24 Dec 2025 07:31:23 -0800
Message-ID: <20251224153125.69194-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224053407.81911-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Dec 2025 21:34:06 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 24 Dec 2025 04:21:59 +0000 Shu Anzai <shu17az@gmail.com> wrote:
> 
> > Extend damon_test_split_regions_of() to verify that it correctly handles 
> > multiple regions with various 'min_sz_region'.
> > 
> > Signed-off-by: Shu Anzai <shu17az@gmail.com>
> > ---
> >  mm/damon/tests/core-kunit.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 2eb6f41635a8..36622a2c11f1 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -275,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
> >  {
> >  	struct damon_target *t;
> >  	struct damon_region *r;
> > +	unsigned long sa[] = {0, 300, 500};
> > +	unsigned long ea[] = {220, 400, 700};
> > +	int i;
> >  
> >  	t = damon_new_target();
> >  	if (!t)
> > @@ -301,6 +304,24 @@ static void damon_test_split_regions_of(struct kunit *test)
> >  	damon_split_regions_of(t, 4, 1);
> >  	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
> >  	damon_free_target(t);
> > +
> > +	t = damon_new_target();
> > +	if (!t)
> > +		kunit_skip(test, "third target alloc fail");
> > +	for (i = 0; i < ARRAY_SIZE(sa); i++) {
> > +		r = damon_new_region(sa[i], ea[i]);
> > +		if (!r) {
> > +			damon_free_target(t);
> > +			kunit_skip(test, "region alloc fail");
> > +		}
> > +		damon_add_region(r, t);
> > +	}
> > +	damon_split_regions_of(t, 4, 5);
> > +	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
> > +	damon_for_each_region(r, t) {
> > +		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
> > +	}
> 
> Nit.  The above braces for single statement is unnecessary.

Andrew, could you please pick this series with below attaching fixup for this
one?

> 
> > +	damon_free_target(t);
> >  }
> >  
> >  static void damon_test_ops_registration(struct kunit *test)
> > -- 
> > 2.43.0
> 
> Other than the above trivial nit for the unnecessary braces,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ


Thanks,
SJ

==== >8 ====
From dde3e0e84056f85cd5cbface38c1f617bfbd0bd4 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 24 Dec 2025 07:27:04 -0800
Subject: [PATCH] mm/damon/tests/core-kunit: remove braces for a single
 statement

damon_test_split_regions_of() has braces for a single statement, which
is unnecessary.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 36622a2c11f1..252ce3e001c8 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -318,9 +318,8 @@ static void damon_test_split_regions_of(struct kunit *test)
 	}
 	damon_split_regions_of(t, 4, 5);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
-	damon_for_each_region(r, t) {
+	damon_for_each_region(r, t)
 		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
-	}
 	damon_free_target(t);
 }
 
-- 
2.47.3

