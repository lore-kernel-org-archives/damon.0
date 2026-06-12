Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8871B3B19;
	Fri, 12 Jun 2026 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223085; cv=none; b=aaRIfyHAm8YB/fT9/6bhEevjCkQsA2yoHGMNS2Fe3Ea9a92MufWHBgJw6MIizewpITH0zwAfMosLAOwXfk00aE8IRGN4LvZVlX/KxJUmA0LBCINeBO9Wab4X/qgg70aSmSbjYnGrP9jBkq+qK4qaYD0utPOaPekYdvnMoNne3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223085; c=relaxed/simple;
	bh=7jE9PKH31IpRmYc+zScP8Dv4gr1YZnKYVnlI4wc3UUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3tNvA2qbM+0P1mGDBTiorPJZrzBCGTjBcPSmkt2DWqGesUr/DuAYuzuFFSUzNtXQPxK0AGk3ZruROErPu/zESrFeZyi30qALofG/XGZZyBxsWaK5Jv2/NpozoGbP7iSxHSmAubOj4Ze6c1efxcqt0OuS16dZUZdKGG5CbGf4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBQATIv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBQATIv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF5E1F000E9;
	Fri, 12 Jun 2026 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223084;
	bh=9FQuoOP0H6GOvfWs9acfWr7SdBLQ4JX5Rqqd4VQi5Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBQATIv3vlXRihKYdfldGfgFMv3KTGZQDg+cVNsHCAPkt8/QhNCK3Kvz8PSt1DZS/
	 pvgyAe0YYxih/Z0qD1iT5pEvMwTYrVSwSS/7+2G1jbktuxBixbp72f0LNCiaIaEVVT
	 hf+NlFKBtKU4p7ETcRjV5APBRdQ3IT8oVGnEwYROsf+bVc1D9AUjLSkSCHE/WqSkYW
	 /UrvwvCN3+/sPFgt9JHri3oNwSMGfrKvyQdhsrK0qRFEy+xW9VOe7ObgKhEgdZ2jPP
	 mthIZENeGtmTWkVjQzG8yf3t/xLQZk7iyHin4XOp5J/TX399Yg29NHKvxefRK8orl0
	 2ouiAUXN5i70g==
From: SeongJae Park <sj@kernel.org>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon: add regression test for damos_walk() vs kdamond exit race
Date: Thu, 11 Jun 2026 17:11:21 -0700
Message-ID: <20260612001122.27512-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAF+TLO2PX71_-9nKBEAJ50+NpjNkgipig6=9OLsvbgZtqF2yew@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jun 2026 02:06:51 +0530 Sailesh Nandanavanam <saileshnandanavanam@gmail.com> wrote:

> Hello SeongJae,
> 
> Noted on inline replies - I'll follow that format from the next response.
> 
> Following up on this thread with progress.
> 
> As discussed, I dropped the userspace selftest approach since it
> cannot reliably trigger the microsecond-wide race window.
> 
> I wrote a KUnit test instead, added to mm/damon/tests/core-kunit.h:
> 
> - Creates a damon_ctx
> - Sets ctx->walk_control_obsolete = true under walk_control_lock,
> simulating the state just before kdamond_fn() exits

I don't think you don't need to hold the lock, since this is just a unit test
and there should be no race for the test.

> - Calls damos_walk() and verifies it returns -ECANCELED immediately
> 
> I built and ran this on a kernel with commit 33c3f6c2b48c
> ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race") present,
> and the test passes along with all other 28 existing damon KUnit
> tests:
> 
>   ok 29 damon_test_walk_control_obsolete
>   # damon: pass:29 fail:0 skip:0 total:29
> 
> Since walk_control_obsolete is a field introduced by this fix, a
> kernel with the fix reverted would not compile this test (the field
> would not exist). So the usual "fails before fix, passes after fix"
> verification does not apply the same way here - the test directly
> validates the new field/behavior introduced by the fix.
> 
> If this approach looks reasonable, I plan to send v3 with this KUnit
> test (replacing the userspace selftest from v1/v2), along with the
> commit message format and other minor fixes from your earlier review.

Other than the trivial comment about locking, your plan soudns reasonable to
me.  Looking forward to your next patch!


Thanks,
SJ

[...]
