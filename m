Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC04DAF85;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654944; cv=none; b=mmcuuAo7NafVuRHzOXP4pvZ4CdLP/rNlqzyX704agvIo9ESU70cmNLAIxK+83eEHWjZrtbdDk8w1I6LOIIBUYEvl5WmkMV+vQlTxYaD05eMR/uEnDIyWD5e8FuKyCT1A2vLByKp0GvupiUdPvO0h1CPdwFTGyKF62P1FXUQpSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654944; c=relaxed/simple;
	bh=4U9oeiDg63kO0Tuk8WIBTY9rOPBTjZoKjJGIxJ7C1os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6DJ9SGV28oexY8x+6Yi5pxpJ8Rxes3sOAXGBpp0WOuA6TQbJsJpe5oFoBD5vPiYdXUB2g4tujcur/pzQixX1IlAVZcYg/eA02/77HYu2dPL/VG6ZjrHEfJCsEA0tMQimmFi4Bx06cNrAWBYIHPLgXAFFLFiX/TUMVcv3slfPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldfonNik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldfonNik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2040D1F00898;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654941;
	bh=fE3VSG475bLo7Rafe0HxYfu5RyrdwRMonEKmjNKbeoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldfonNikCJco+lq05YdWxGYXoi7MtGns/iW5fY3Tpy9ce2H2k551ftpQMsGuCANb3
	 Zr8ZOE8xM0sB4o9U1b+U0zBuRPVAnqdXz8vhyMUPoKJR02phbs7IWby77bhcjJHEQj
	 SAdtQyApnW3oBY75ZzFNExDRCiqCZ90ozvm/f1XdL25qEw9pBxRlnZfFnCIkS1mKNO
	 ++jqtlqfoapQbpnZUiUjk4BS8hzfy6eVDxYyiFH1KMC8P5JoENiN2UIxUgNUOcdaMu
	 xdKOLqEvVi3xAoToXKtC9CqGopxJZY+ipI+9qoyt5J7UdvlLvV1bQ68qLHhQhx8gsE
	 1hA1qIKgDeq8A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] mm/damon/tests/core-kunit: add probe_hits_wsum damos filter commit test
Date: Thu, 17 Sep 2026 07:22:06 -0700
Message-ID: <20260917142210.90829-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter commit kunit test lacks test cases for probe_hits_wsum
filter type.  Add test cases for probe_hits_wsum type DAMOS filter
commit.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1f19fefdd98c3..5ff0436c58441 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1166,6 +1166,10 @@ static void damos_test_commit_filter_for(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
 		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		KUNIT_EXPECT_EQ(test, dst->range_min, src->range_min);
+		KUNIT_EXPECT_EQ(test, dst->range_max, src->range_max);
+		break;
 	default:
 		break;
 	}
@@ -1239,6 +1243,22 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = true,
 			.target_idx = 6,
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+			.matching = false,
+			.allow = true,
+			.range_min = 12,
+			.range_max = 34,
+			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+			.matching = false,
+			.allow = true,
+			.range_min = 34,
+			.range_max = 12,
+			}, true);
 }
 
 static void damos_test_help_initailize_scheme(struct damos *scheme)
-- 
2.47.3
