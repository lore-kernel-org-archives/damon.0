Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAA2E6116;
	Wed, 29 Jul 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296284; cv=none; b=lYVLKo+QAztr4/xcRESbidnNmlv4vN6OeTfuszYInaahJJ0/g28A2e1dvM0Iz/SH/sRIFDNh3fP1bNa1CdGd3CxEuAZf9KMNpBV+jBxI5YXowzzjPPAqUzjZtlGs5oD6MFzLvYVBYfEmf29E2eOhCF9+ul3AZdRGitfb4L22kYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296284; c=relaxed/simple;
	bh=Ph4tfwVfbDdj+VSVpAPJTNe1BWDH3/wXUYB+lenMBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEG18UxS0+eQXm1x+kJh473KxqPGLqpBHkppFukSVe389x9ahBJRcWct70IatKj+ARRPhWaVAVS75hvtT6n+xgdOJ+XQ/AIteXy6xa6pu8CaiXzg8Bakr8c12lGfORHQd/HVzh2HKkR8T56skl304nm4yS+QGmv0HPiYjtwIVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZVIomhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZVIomhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDCE1F00A3D;
	Wed, 29 Jul 2026 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296282;
	bh=69vkU0D1ZC9y76VW8fWIr/5QR0D00VAs0a00zXjnW44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZVIomhIx28YByczLCcoBJuIx77Q1yWQW28Mr6/2Srm20YVkegBgwBDYvl/o+6GIl
	 dbVbsP3hJwWvtAIyWY1uX6LHDVbittDBU8T6rAWrsc0e8a7tI+H4beeY7dP/CvZ0r0
	 80PsuAC/6xdG0+PM2IS8SK/dNO2/bD9FSIKZJdtihjY8dnk58hPTG+tdWO/dXw2A+W
	 wRGCgHNv+IeBzxldJgX7ifzCUfMNBJmH15otApafk0UfQAXTSCUBx44MuQrszARrjj
	 1BF5eB+vYxbPw1GjrWm8T8tI1hBVHCDNV5KpfKvkqIvIFyOJZgZg1X2Cg1i8fsKr8R
	 8TcLiPZOnVSjg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/10] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Tue, 28 Jul 2026 20:37:46 -0700
Message-ID: <20260729033751.131213-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
for damon_set_regions()") disallowed passing overlapping input ranges to
damon_set_regions().  Add a kunit test case for the overlapping input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ac15393a7935b..3041b8288ec26 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -606,6 +606,17 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 42, .end = 21},
 			}, 1, 1,
 			(struct damon_addr_range[]){}, 0, -EINVAL);
+	/*
+	 * Regions resulting in same region after alingment should return
+	 * -EINVAL.
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 10, .end = 20},
+			{.start = 20, .end = 30},
+			}, 2, 4096,
+			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
