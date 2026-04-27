Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF103358BF;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302763; cv=none; b=mAT4U1YeWmXxh/fZpsY9WlzrKj4I/GY3I6LOqCcJ1Wyft7vXMSJSnriqaW0Bd5QGk4BkZDdTh2dL8KiSUoUPKzTvtr2Rt3awU6oAVhC3Vu/BFwLepphQ6UNlt2e8VKGp0MY1fwzNJFr4tXv0tVVti0wKdFn26Fxxv/X6oT1x3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302763; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k76qg4Qlrm88ienDnyShsI7+np99KGinMFcOhq6o9dH4Os3h3LW/vBRLEeqxZACVPUqWrLpnXrn16F3DJkluqMptjsaj1MnTyIOJ6ZeiBhPlChFvIFsDRj1YLpat3IUHnYC8snIUlsQxTVu/h9WhUzMAB1Eym2inn1/5ZHUM6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCWPs2TM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCWPs2TM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ABBC2BCB5;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302763;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCWPs2TM/QVNIYTw3lP/RHTzg9Yz1/1Cw+itnweALv+X3+zIaJmnxAIV3CfP0ylGr
	 svSJBCH8uK0Rfec9YrmuFCfVNHPzMol7N8ZXJP6Op3aMBy4vOp6vtb1o90yy7m0niQ
	 Altnn9BQKqlSSArXo3TKY7TuTdTNzXo4chdh5jXCGQGIWTq/lIoum56JO33rbOn/2k
	 GsNUvZUoBmwpPoM/+8QFz1G6GA7HgIK93xeLTNFGFSjA4cXUznXdALQrFnfuwN7T0Q
	 cm4eQ9yaDgxEq43NC05eahxFbXliBobfzw1mcZby+epevwhB1Ax+ZsGLMXruVsSnQy
	 008KXxX35ngMA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Mon, 27 Apr 2026 08:12:25 -0700
Message-ID: <20260427151231.113429-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
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
