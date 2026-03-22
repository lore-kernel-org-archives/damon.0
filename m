Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361E347C6;
	Sun, 22 Mar 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195059; cv=none; b=NGSZmkxPXVedH8gWZcTwH0kUpDkF3Z3prnhfVCiaFuAsU2iZUt7dUGYLn2cJFjFUE7nxRLWfWy5K02TSw0gj7SLuwK5mx650SseMVF8v3x+QSm1MNBDDcqs2/LwejBfA6GhV737YmgJCuvHcUOxWPcmop7/887MVIIfRKPLbQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195059; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/wWXXgvh1XP1xmPkJk0Ivgqa3F2kSz3CByaCJP+4QDBeImOXP+OUVHS4iJHKEfI+A/Z35iJu5qOMOrw9L/9aE8w2dRvfn2S85U4D3zx4JRI15IBnGPvP0MYE5WWwyeVwMWcVbktwbFeGDsuYQHqWbwNJ2orbCKgPJuP3fUPC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlVO6kot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlVO6kot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7B3C2BCC6;
	Sun, 22 Mar 2026 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195059;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlVO6kotRB2q3CldQyLv7KHE+7VPRz/p+DA8T7h7XuvebgwkB/YfZ4rc9uFFn+5oS
	 PKLtSA2r/hREk96rf+oI/aa1mAk+AX1KWX/omEpu9IUgVgcnCETMEy4GmC8fMD6veX
	 9JBirr7VSHWsinjEQOayzsxfzh5VpjhLhKVI2KDFWufdbPjr9RDjBaNqBZXwWdVDzh
	 AMRW7j26eB0SlesuJJ2L645Tx5uTtie1QrDCFOTSiM/xsab05ey902c5XtWT/PrMqf
	 Y5UqV94+HSqU7Pqz+NErvWwNHlNShJeJpdBcGKQGHjf/KILapzuWKlNvBuA3LOi9Cp
	 WquMcsL5okGXQ==
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
Subject: [RFC PATCH v4 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Sun, 22 Mar 2026 08:57:20 -0700
Message-ID: <20260322155728.81434-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
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
