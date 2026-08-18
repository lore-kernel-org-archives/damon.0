Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FF3D0C07
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028407; cv=none; b=l/xBmLR93Pfz0DhiQQmSlhH+4dn3SWzYYN6Y6QRYyvXhQAll9D/LjHQU5LcX+Bxl1GWokBkWP+KdRnVuUWMD9HFAf1UINOBEnByOjz4OWHtekzvTXXFoa+yw5pM2yRQCJp/Y5h07kCdBzWjoH5t9ZLW68zx3HuFsOjgn5aEd2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028407; c=relaxed/simple;
	bh=hPrafa4pk9GQ1eCaoGrKuKIwPG/ckYOkaKN3f5ru1kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OciiSZfi/v+nNiudJ56P4zP2zu2TVu+OQmcfmUufNkLJL8f34yLZS+c++Um31unH9VLqlluse3Q+u4y3BRqSeKCe/+bfpFMyXhDglMEMzQRW9xpV6fAjI3QLJkXZqFw/A8lAaIa1Ecp4fsWrIpZalKvhrcYEZjDkvvcF95AXusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYmIWSK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYmIWSK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A11F000E9;
	Tue, 18 Aug 2026 04:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787028405;
	bh=svhgWbW3oRYGlFmiUlsYK4d2XAgplj4VGWiCMiCjDJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYmIWSK085P1ipoAdPlrNJkZfLFxd+epHStDO/xi3/zC3byBHUtm6z61ZI8P+Q7rx
	 uNvcJnq+HDpsGqw8KHdJxZT1xC25u09aWB1n8jWb3vzhFpF1cFFLr8jSDnoVvafVrW
	 t8MSlEhNPtyefIf3QNDWBrnB+jwviPH1QmK9TIwjfUChYo7zx4gS5q1OyQcK44BwFL
	 skOboUiUOz06QkIBDAH2mzUpeuGm73f4Xc+LWnnc2Q4So5p+ryTFjkyZfRY0WLrRD4
	 WReOV0PV00LnGYUT09VlBae8RmPchfeRlEFCm/XHRf2oNQnjKf1imrejVnv9hgYtTS
	 n658+YpYyF9pg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Jason Angelov" <jasonangelov@ucla.edu>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at region split and merge
Date: Mon, 17 Aug 2026 21:46:36 -0700
Message-ID: <20260818044637.96914-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818035742.F0E5A1F00A3E@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 03:57:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but there is an integer overflow in damon_merge_two_regions() when calculating size-weighted averages on 32-bit architectures.
> --
> 
> --- Patch [1]: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at region split and merge ---
> commit f275f8ec2d833d0e2eacc7a18ba7c56b04b7e599
> Author: Jason Angelov <jasonangelov@ucla.edu>
> 
> mm/damon/core-kunit: test probe_hits handling at region split and merge
> 
> Extend damon_test_split_at() and damon_test_merge_two() tests to cover
> handling of probe_hits and last_probe_hits arrays.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 4a536d41cdb2d..2db94d49c9bae 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -204,6 +210,7 @@ static void damon_test_merge_two(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
> >  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
> >  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> > +	KUNIT_EXPECT_EQ(test, r->probe_hits[0], 11);
> 
> [Severity: High]
> This is a pre-existing issue, but does the size-weighted average logic
> tested here overflow on 32-bit architectures?
> 
> Looking at mm/damon/core.c:damon_merge_two_regions(), the calculations
> multiply values like nr_accesses and probe_hits by the region size in bytes:
> 
> mm/damon/core.c:damon_merge_two_regions() {
> 	...
> 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
> 			(sz_l + sz_r);
> 	...
> 	for (i = 0; i < DAMON_MAX_PROBES; i++)
> 		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
> 				* sz_r) / (sz_l + sz_r);
> 	...
> }
> 
> On a 32-bit architecture, unsigned long is 32 bits (max ~4.29GB). If a
> region is just 17MB and probe_hits is 255, the multiplication 
> 255 * 17,000,000 evaluates to ~4.33GB, which would silently truncate.
> 
> Could this wrap-around cause merged regions to inherit drastically incorrect
> statistics, potentially misidentifying hot memory as cold and triggering
> aggressive paging out of actively used pages?

Known low priority issue.  Users could use addr_unit to workaround this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260818034552.11975-1-jasonangelov@ucla.edu?part=1


Thanks,
SJ
