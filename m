Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FC37C91E;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608425; cv=none; b=W7fy0zmH+NPlAePQmLwWEpm9rHFJ8LeA5KUn3cWWV/KwGGMvm8b+IFEqjzCcgZw9p7xHBNevQ9dKpyW8PR4xWjY3XZZJiD3FI6ym2fn1S/dCh4tN9aDWGYojvtQRIpOTpCaUIggkWuSrVkNglmMnC/Qkie9Yle3KHJp+cpMfTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608425; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b29lRpXzYB4FoyesQcUS1jdhR1eevlxHmWCiLSZcihUf6KKlK7QAo8BOQdANrBuIKmRFrH6eyeIe7ZGIAvTH0NCsPIlH4FRYjCWyyuCDAs8CIiQDwAUEeS9NfZTUIe2T1DYJJVbStXtd56nw5CjYJQcNeIay/E2xKxz/TLliqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv9sn8r3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv9sn8r3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2CEC2BC9E;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608424;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mv9sn8r3K6vky9qU7ER4NsTzi7rEvDXGZEa6QWEd4OKBB1TTtjpYCawkrwKSAuv8/
	 p61zmi1755sjHSRP8epCQfX4zq/4TWiLEdK3ufEZrAyA+Ktr8HCquMI0ia3AIApZd0
	 mqZ/42zV0zSCVAIh9K3NrBn6DsW91ZNzkKhmiVSMYVFXp2KTZvtLgvl/pCrnrPVGRI
	 7o2OuvjsXG1x9s0TJyvlosUrJMn/+6Bx40388X+JQvmP2jkRcvAwLTOyRwU/GDP6w7
	 SyeB8jGkZdtCIUQCNAnuVwoo6/bRIIZo97YZU6UFESzzBfIkWenOe5Qa6Yccz8JUiz
	 rW7O7QFJSZ6TQ==
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
Subject: [RFC PATCH 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Sun, 15 Mar 2026 14:00:05 -0700
Message-ID: <20260315210012.94846-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
