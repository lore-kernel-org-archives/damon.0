Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9815CAF
	for <damon@lists.linux.dev>; Mon,  5 Dec 2022 23:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A3AC433D6;
	Mon,  5 Dec 2022 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670281721;
	bh=qgpIYxCoLxiSbmookPCEJSX95mijzZoDksXEWue5IhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k78k7YExuF6/YEEvcLQCrdPFVM8+qZ66Sw1wGSQt1vOP6nrkfOevcW9LvmA+peVW5
	 aDGsFBfIOyR+pD6XRfeyIyNJq6d6quIA1qUV451ks6L5wwqGhGcaPKXvj6Pg0kIFn8
	 BATF7tCEg6mGkduLufzPqMOvR3R8PoZDrrnIHcIW9nNoWcaXgzH/V7/0z03ujbr1AS
	 Azx5pHsw1fGteX+pc6NdS8LbE1lyO4RXhdINeyGAhRwyiQMBg+5EleKrTIgEnfU5Nk
	 zfHofzo5dszklOcY3XDH/svZ9cz0X2+TqTsRq03hk8zd9m38KcvvTi3p0Bke4T1KDM
	 bGdKopAY9JjLQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 09/11] selftests/damon/sysfs: test filters directory
Date: Mon,  5 Dec 2022 23:08:28 +0000
Message-Id: <20221205230830.144349-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple test cases for scheme filters of DAMON sysfs interface.  The
test cases check if the files are populated as expected, receives some
valid inputs, and refuses some invalid inputs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index db4942383a50..a00336ffdcad 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -96,6 +96,34 @@ test_stats()
 	done
 }
 
+test_filter()
+{
+	filter_dir=$1
+	ensure_file "$filter_dir/type" "exist" "600"
+	ensure_write_succ "$filter_dir/type" "anon" "valid input"
+	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
+	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
+	ensure_file "$filter_dir/matching" "exist" "600"
+	ensure_file "$filter_dir/memcg_path" "exist" "600"
+}
+
+test_filters()
+{
+	filters_dir=$1
+	ensure_dir "$filters_dir" "exist"
+	ensure_file "$filters_dir/nr_filters" "exist" "600"
+	ensure_write_succ  "$filters_dir/nr_filters" "1" "valid input"
+	test_filter "$filters_dir/0"
+
+	ensure_write_succ  "$filters_dir/nr_filters" "2" "valid input"
+	test_filter "$filters_dir/0"
+	test_filter "$filters_dir/1"
+
+	ensure_write_succ "$filters_dir/nr_filters" "0" "valid input"
+	ensure_dir "$filters_dir/0" "not_exist"
+	ensure_dir "$filters_dir/1" "not_exist"
+}
+
 test_watermarks()
 {
 	watermarks_dir=$1
@@ -143,6 +171,7 @@ test_scheme()
 	test_access_pattern "$scheme_dir/access_pattern"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
+	test_filters "$scheme_dir/filters"
 	test_stats "$scheme_dir/stats"
 	test_tried_regions "$scheme_dir/tried_regions"
 }
-- 
2.25.1

