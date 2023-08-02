Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6E12B9F
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A000C433CC;
	Wed,  2 Aug 2023 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012598;
	bh=cjc8ooSUQ83tCK1u+lTmvslo5pngriB995qOBl2lfEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikb6ovw/+AobHS2orGwswuXn2tlkNHwauXcRV6Typ+Y049vivhXS52JNo31EJITXY
	 emfTMVPVnHa84OqOMbZVTo5kbKeKGHOpjFsOIeWxAksOBD1KxT8ZuTuTDN9rHg/Wtg
	 F6AsCQyf2TOaPUNj4vCWIaI9DFBrBCpREyoQkRdtVM0UMwWQZ0IvN7lTXtGoZETgG1
	 Zy9ankfs8/EVYFpEOb4r0JbOi6tvKYPa9H418hI6X4RnEuTQTALWYSvV2UiFkf7cm9
	 hWtnjYErjiGV3ODf3wRp8IeVQt7UDKHS7oVF7VZO8K+omnCY5RDlEJw9kWy79bTpag
	 AZGMQFafNxOcQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] selftests/damon/sysfs: test address range damos filter
Date: Wed,  2 Aug 2023 21:43:03 +0000
Message-Id: <20230802214312.110532-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
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

