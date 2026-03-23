Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473D386458;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307744; cv=none; b=CgFJOx8lex+XnpMuN+1OjrmtHLMw59yD0royTRUPkkvFzUMmyNuDOVuzVuUxw8pi0HPlql5r2iy1zSPGYL0G8BMIc4RrqHkALnRE2Ts+9JJiYvnOFN0OhLqZG+md94+SqyqaC65mRJErNgPvffMfj/0U9SWbwqa/N7YQAze8yR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307744; c=relaxed/simple;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiU3jKRhBOMAS07Y18B1BeeHxTTovp0zuvyWOdYJHVvqw2fpILwurqmE0fxxqDL2Fwep3GqZoFKGQaJ0IRVxrHQRVYjfzDVNso3tkHTsNfDuKRUv8mS4PhhCPnXIZU++VevY4X6YaidVY4pFYYA5lD00x4u8h5f4opoOk0oIQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng1A37Hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng1A37Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABB4C2BCC6;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307744;
	bh=K+t0IBDIG7HXVVaXmRTS++wFYmoNTkKzAJmGYrkNPTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ng1A37Hw6bMYCKJXyLwyQeLILYH5OKdhZtWcrCtlsYIRiJ7U2bKjT9GeIwk66n4XQ
	 of51gtUsdXBfQxFf6V2zKTjgXeht8N/2fnGithcDYPZspea1z3sXPnMnXpm8Q1HP9U
	 VfrZES1lXNQ2uaJtJPkAQ5THrItnE55+2xHp5RSBiUfIoHMIQcqwUY2hEzRztbjgof
	 9d+/tP9qMPZObt65NZeT02xfRCnX6MDqkT3Fq3eUrYp83aGNFktHY13g1CouT/7g2K
	 0F7F2bWfnnIz9KCg8sMuQwarbq+XVeU6hzTwFwT36Vh7Gf0YBtCcDrWhOHqzwaZTdQ
	 QA35PR9uRBEbg==
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
Subject: [RFC PATCH v5 06/10] mm/damon/tests/core-kunit: test pause commitment
Date: Mon, 23 Mar 2026 16:15:31 -0700
Message-ID: <20260323231538.84452-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
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
