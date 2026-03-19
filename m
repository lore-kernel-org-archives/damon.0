Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AA39A7FA;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897729; cv=none; b=XuxTJUGTCvtqDQow76G03C+yKaMBXVpi+BEM6W3nxeBfIjm0b5xsXy4Vn0IubyhKRDB2jszhBiWZkAqiudYTkbwJdiIjOv5125jTytvCJEcgRt9h2UWgibmuxRGjCP39dOvjZwUfJsh83snHsZjruJN1wtUxUfwOp9QaaOzB2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897729; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZj5BeBcsKH1PQHvX+Ohu44ShIM2TV0G+Q6xfXtdFRlrf+AN3YQzlz5kuYSWdtCY11lEVUkOD97tiFVPrp7jAFu42Rw0Qcczjuboavsvy3q2xgOK0KiMIn/DSIkYH/UCzun56jd52ihTzFapQd7EjABqdcs+hqJQuY+HOUzoFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgLxCuk9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgLxCuk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB54BC2BC9E;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897728;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgLxCuk91/AfmruwTg8iwYOcOr7M5FuG8Vnd6YLTo08UqUEKMb5tuFkxeWxOwILJB
	 hAy9NibPiGesX0iPpBBAmVubQFPJ1Y0s1tNO8NpzP5tLDTm5XI3Ed9k6vZ9jq/DB9B
	 Ug5vf7clHmxTNk8qDI+Ov7UY/T83TmVRp8OJWBxCs+vqNzCfZ6zN+GRHMBszydy0/1
	 lSz+/SEpD1mhK3iSM10/7ukQseSehDtJ53dlZXVxTJHn63pie68h4c6jYaIA5Wi/ZB
	 yDntw1hMgeeDjnQ0rtJ7YIsblivjAotOanGSAT7Cc2vkw2e0/MZ6plm1D1llz2sOvC
	 PYxotwruumhgA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Wed, 18 Mar 2026 22:21:49 -0700
Message-ID: <20260319052157.99433-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
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
