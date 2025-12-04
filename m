Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C62749D9;
	Thu,  4 Dec 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842647; cv=none; b=gdqzRfJquioIFURhlyR7rcQTs3FLxtlp/2jiaw6+u0f1KTaFKL/rqb8qWf8chugyMiAJgFF0rgR4x4/4E1vZhPDyb0h6xwvQAGPeRErac4y+ixBFek33R5N8niXf3/z/nIiKP/EE2mjtjYohIKliiQ1wLq1oJSZUMyuqf6pMl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842647; c=relaxed/simple;
	bh=ArE/hdVTiVvxgqAXC1TACYkyTmhmvDBhTBXlLDgls4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DMWOJLQ4TY+dzmAmffF9APrITiJMc1+HeZBsnK5hHcvuhTaewHaTteTrAaKN2eJQwHJ+1giaqoH2EwYJK9FpO5nttCOEovl5toiQEXbbv1bgqPCEn0YoX0VDFUcAPv5abxrEqWR5cSQ7JtgKTQBUI6E/nDupsNhVDIAMcQqyNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl65G0nu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl65G0nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD75EC4CEFB;
	Thu,  4 Dec 2025 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842647;
	bh=ArE/hdVTiVvxgqAXC1TACYkyTmhmvDBhTBXlLDgls4M=;
	h=From:To:Cc:Subject:Date:From;
	b=Wl65G0nuaALQFV4IweK54wl0c2W2lLgcJK4D9+9fDo6TlZgDmnfvpG3IeN1koRwlR
	 nKDnneiUJR5EYB8zVWL03kjdD8sSthJWa2npK75m9XGo1ks1HWHWXq+ld78VrQK1n3
	 oKMM16POl2li41iO3P8PRLSGYFsIHXvalDu1voHPpOrylrVQ2P5alIfMKJiC8fvNYt
	 oTQSEggm6gjc6BXh8KnUnPoA0Vha9Eone25cEPc64lmY/xfFcU1gD0S+0IElxt67LI
	 /u7oGpfifeIhQNvfwSops+BCovGgMwH1Sa3f7JX6NBfCMNnyIJvUFVpwvREXzDmUM3
	 AoUPhUEWbxkGQ==
From: Arnd Bergmann <arnd@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/tests/core-kunit: avoid damos_test_commit stack warning
Date: Thu,  4 Dec 2025 11:03:54 +0100
Message-Id: <20251204100403.1034980-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added damos_test_commit() constructs multiple large structures
on the stack, which exceeds the warning limit in some cases:

In file included from mm/damon/core.c:2941:
mm/damon/tests/core-kunit.h: In function 'damos_test_commit':
mm/damon/tests/core-kunit.h:965:1: error: the frame size of 1520 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Split this function up into two separate ones that are called sequentially,
so they can occupy the same stack slots.

Fixes: 299a88f6ec13 ("mm/damon/tests/core-kunit: add damos_commit() test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/tests/core-kunit.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a1eff023e928..8cb369b63e08 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -924,7 +924,7 @@ static void damos_test_commit_for(struct kunit *test, struct damos *dst,
 	}
 }
 
-static void damos_test_commit(struct kunit *test)
+static void damos_test_commit_pageout(struct kunit *test)
 {
 	damos_test_commit_for(test,
 			&(struct damos){
@@ -945,6 +945,10 @@ static void damos_test_commit(struct kunit *test)
 					DAMOS_WMARK_FREE_MEM_RATE,
 					800, 50, 30},
 			});
+}
+
+static void damos_test_commit_migrate_hot(struct kunit *test)
+{
 	damos_test_commit_for(test,
 			&(struct damos){
 				.pattern = (struct damos_access_pattern){
@@ -1230,7 +1234,8 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_dests),
 	KUNIT_CASE(damos_test_commit_filter),
-	KUNIT_CASE(damos_test_commit),
+	KUNIT_CASE(damos_test_commit_pageout),
+	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.39.5

