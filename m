Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FB34B1A8;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116834; cv=none; b=bKpz2z+Rt5EJY4z3hpS+mB81HNP9FGgrO798fGzYlQytF+/zvOIwqPeE/ebIoGlaj/IIBDXF9dVyteDt9iy1GNSsMtoc3PNzQuGMLz2fjBDIlXae9PMsapAY8WgA4cTw1DluLUPuRrKkLraLQUK/5EPm/cHFwI84gCPEUVsc7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116834; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grk4TWhaPW4S1l40q/OTOFARZyWGPQ9Gmny8Au/bcR1nFqIxxxgFep56LD7hgUs1db6DME2EaOaUkfmDtgOl5KHlN2ro02czs9zXE8f/io5dVnDNQr0SBwCW8GqO+WnFQoabUr8UZUVO2CgpyTn1kqmj82aGuOY6lQqyfGF3tpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5Y2AxTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5Y2AxTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E5C2BCB0;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116834;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5Y2AxTrErzC/xpyGbWB5GoD42Vw8CeZGe/2gyPns7E1U1BC+iY64/vTLl8YUlQKr
	 cR+xyVGy88+3waxenL8ziLiUq59Lg9Lvsu6j86YESfKJ+X9ubaqUBED+ZqiluXtOpQ
	 4VcKu5VO6xVElzO/rbz1iOlis13eHlq84r/E61kWKgqXQ2wm4tp6aDI8x6rrG3xZdv
	 msAL796o1mr5c6oVQfXkR8MZxvVeFefB0xl0fBce722EW3j7KPldwWvJpAdlrEYHtY
	 TGD9A9S/h/t850vTykm+24eILpHXnebB8Mk3bsWxHosET3IDSWr+WRIg49crE8NEGe
	 uLwFeUf18BsMA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Sat, 21 Mar 2026 11:13:36 -0700
Message-ID: <20260321181343.93971-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kunit test for commitment of damon_ctx->pause parameter that can
be done using damon_commit_ctx().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 9e5904c2beeb2..0030f682b23b7 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1077,6 +1077,10 @@ static void damon_test_commit_ctx(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), 0);
 	src->min_region_sz = 4095;
 	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), -EINVAL);
+	src->min_region_sz = 4096;
+	src->pause = true;
+	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), 0);
+	KUNIT_EXPECT_TRUE(test, dst->pause);
 	damon_destroy_ctx(src);
 	damon_destroy_ctx(dst);
 }
-- 
2.47.3
