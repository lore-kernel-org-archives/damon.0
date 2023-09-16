Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E78539D
	for <damon@lists.linux.dev>; Sat, 16 Sep 2023 02:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3E2C433C9;
	Sat, 16 Sep 2023 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694830207;
	bh=I2fvF7L5MWw0Xd6X92VF2iHBCnxT4grJu/1S+mVZwhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKhM4RCiPW/WTsWk5JRgIEMREqf3W6POSXpmuWjX+pNtpbUKhf9uSSUSCfWwTyVmt
	 O0IjP4qBbo7CWUTv7afVCGvVFZEuytTab+a9LlQKW78/utBW81O3uDztR6cOx5ev64
	 pIX82Gd/olQdHoBt8QLIc80rPpTTZd16EGrkeI9BkD0T3iFbc0tiYmCH/AFuqA2fFY
	 j4s2acBog/OIGBGeyBvNG+xzEImkvBvcF83HnXH9ajYft0z5YG6VdlyQ3G190oTika
	 y4PWdtiibt/78XrDsqhUy3bsC2YFWGbyhY1zo9tv79mChFaA9yJPIfOFqFoQTp8xQD
	 H4lwh2LfGuiTQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] selftests/damon/sysfs: test DAMOS apply intervals
Date: Sat, 16 Sep 2023 02:09:43 +0000
Message-Id: <20230916020945.47296-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON selftests to test existence of the file for reading/writing
DAMOS apply interval under each scheme directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 60a9a305aef0..56f0230a8b92 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -175,6 +175,7 @@ test_scheme()
 	ensure_dir "$scheme_dir" "exist"
 	ensure_file "$scheme_dir/action" "exist" "600"
 	test_access_pattern "$scheme_dir/access_pattern"
+	ensure_file "$scheme_dir/apply_interval_us" "exist" "600"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
 	test_filters "$scheme_dir/filters"
-- 
2.25.1

