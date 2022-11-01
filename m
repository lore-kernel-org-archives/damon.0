Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E067B
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192BC433B5;
	Tue,  1 Nov 2022 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667340216;
	bh=vHgDcIM2X6HC9Xa44Y3Kmnj3zbAk0A48a3qye0uZNww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BB9iuPFmaCYxUJ2icGWtplwAv9fDjQQP8tssoMnF+QYSch4jkG2Gs9jcRHdDg0eLl
	 UN8aSiWrnsriBYDwmlGxbAstIhanC5uEyC9Jlpqz+62z/zkh9J/rPvtRkVkQri7HTz
	 vkQAMOPJG2EgQrODDLra5lazx51qMuIpWcddNcp2JSkKyg7YxGFaX6ZC+fU5aX61rP
	 h6OeWNswACf+ieCA59Ivg5Jl6tF9P/qMwigIaQUxIlmwgrN5LNFsHwmCU8PibAHpaI
	 lDTn7q6EgOXaDMN+LyyE4By4/ykc4vfJZ1mMCKzxY5Pf/etnSIXTU2t3JeollfAF/d
	 JkLl+MMlB1/Mg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/8] tools/selftets/damon/sysfs: test tried_regions directory existence
Date: Tue,  1 Nov 2022 22:03:26 +0000
Message-Id: <20221101220328.95765-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test case for ensuring tried_regions directory existence.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 89592c64462f..db4942383a50 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -80,6 +80,12 @@ test_range()
 	ensure_file "$range_dir/max" "exist" 600
 }
 
+test_tried_regions()
+{
+	tried_regions_dir=$1
+	ensure_dir "$tried_regions_dir" "exist"
+}
+
 test_stats()
 {
 	stats_dir=$1
@@ -138,6 +144,7 @@ test_scheme()
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
 	test_stats "$scheme_dir/stats"
+	test_tried_regions "$scheme_dir/tried_regions"
 }
 
 test_schemes()
-- 
2.25.1

