Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7747885D;
	Fri, 22 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464440; cv=none; b=lHNUfhaJs3zHIPY/gGVq80FPqNmVcXvDMKaigsyIDJ9lUW83asqdAMMAN5hj9aSBNcSmvh45GLZ0/LYjdkguXxhHwBclf8Xrs3Y/emVpWApNFTLDJnHJdgLpX1hpLgSFtw9oUV+/aM66vMFi2m3L+ZdSKWbHPNdlCQXIgmN1jVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464440; c=relaxed/simple;
	bh=ws0D8iuldfRLR1MHNkuGGInMFKktNMpgiEm6ektZ6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgnZLCueiPndBgZolqoA2mNEo1XEwUgmZXY56IbAnMzWEFycYXpmEhIZ45MNyK7KqgRcKbg/VyT+OXOi4pm7FpgP6zxc4QmDZoXCYOIJLRLUn6o4V+n5Cfz96yNivk6H+VYs+QnXL85i/6LTjk391UVLCR6TwIN9MU+clduWYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THj1T9o2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THj1T9o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AED1F00A3F;
	Fri, 22 May 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464439;
	bh=jOZYn/0HiUYme65VRURmz3VNOCuqOPU+0+8yZhbpho8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THj1T9o2CnuL0MdHENnw+FQNkvI1dj8JDEI0VfoLZQLXUeRo9fxmsexSReBgbSrcK
	 DyfaivafSeIuI6rDpSC9hpkZcrYU26TMXreW5GsZuH6TejAXSxtesdqoEZqlVPcMZp
	 iEQ8YrTt1MA2wKQXSyfHnBOC/r3gtKL142Ueapg66R02Ump+wEvO2F1splBkLti0LS
	 9XRJ4G5lu0qRPbG0iP9zV+0CZrmwLAV2Yts/LQTE8GVDygna0mY4UGMUZDyUiTF39w
	 EP8oN3k+G95w9XCLRgHQSYaT/iBeLmF3FwFWrQzhAxN2dc7hR18IjnZxNYhqu4ZhpV
	 c7f+6MXb0tnPA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Fri, 22 May 2026 08:40:24 -0700
Message-ID: <20260522154026.80546-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing the existence of addr_unit sysfs
file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b3418214ed358..92b44c86818af 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -365,6 +365,7 @@ test_context()
 	ensure_dir "$context_dir" "exist"
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
+	ensure_file "$context_dir/addr_unit" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
