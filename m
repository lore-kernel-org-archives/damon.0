Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD1154BA
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68D0C433C8;
	Fri, 28 Jul 2023 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576491;
	bh=cjc8ooSUQ83tCK1u+lTmvslo5pngriB995qOBl2lfEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZVzJF7D3covRVxGV8qlNVSYryTJADsCE2nkG3JlMM6KW9d11TNHzemNIWTQimTJK
	 ffO0M4jAfUNnDSYV4c9DRRIB0VliGAVfq2/WXiijhELaaucip42BKwqrIHBcjqIaJD
	 bVnh67z2b8iM5uSNPfJCZ1KxJ5yeEkYjeM8YTtQ4idTBJQzHSnwyViTad4T/Ago0h4
	 h1HmW4PEjGdHDzBE+c0WSscxqojOd5yWq1PEFp9djhuFqImKaV0iUCkHaYqWM+1D5U
	 LEC5LNT0heATO0ErxPQA1r1Qhcp8va2vn+6A5rWmwm3Muli5fwkwIJopgiP201Ruvx
	 5GI/wU1T9CLGg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/13] selftests/damon/sysfs: test address range damos filter
Date: Fri, 28 Jul 2023 20:34:35 +0000
Message-Id: <20230728203444.70703-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for checking existence of addr_{start,end} files under
DAMOS filter directory, and 'addr' damos filter type input of DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 967e27267549..5677cfd342fc 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -103,9 +103,12 @@ test_filter()
 	ensure_file "$filter_dir/type" "exist" "600"
 	ensure_write_succ "$filter_dir/type" "anon" "valid input"
 	ensure_write_succ "$filter_dir/type" "memcg" "valid input"
+	ensure_write_succ "$filter_dir/type" "addr" "valid input"
 	ensure_write_fail "$filter_dir/type" "foo" "invalid input"
 	ensure_file "$filter_dir/matching" "exist" "600"
 	ensure_file "$filter_dir/memcg_path" "exist" "600"
+	ensure_file "$filter_dir/addr_start" "exist" "600"
+	ensure_file "$filter_dir/addr_end" "exist" "600"
 }
 
 test_filters()
-- 
2.25.1

