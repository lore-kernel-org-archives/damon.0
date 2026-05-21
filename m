Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE83F1AA3;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374083; cv=none; b=IKx9JJjbVwLLEPvNuuuopKQq6qlxtTkgutDdm3Ae3aer2I1s2X/vnVMw+8BaJw2YstX9M6CQ5sDvfQb6uELKDur5RTi992Dl+duv3fvb4LFg3em4d4nYAG8dNRLaLWQSoO8oQXLlEvCOAIneSD2CTugS6Vb5YNs9SV6u5bcKwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374083; c=relaxed/simple;
	bh=4Z9nDEpElV7CLHeQzITxn/6P2S9ErV3Ie4yqUQCoJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynsit1k30dE5DBxfQ25TfaERmLD34/0LwochR577OjopWAnUqGFSIsZLRkzZMl17hv70Rv9uf2fFOtpomi4n12Y4B/O6Hr1PADY5rbYB9HwbVBVaW7hwNt32USwOovrrCGxjTZQMrwheoo9t2M4+EP7+LrznzCo5fIy33iDNuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTMrLp2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTMrLp2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858B31F00A3B;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374081;
	bh=9HFBKYb5cdZ3muhhdyyxDCFvE0VgsBfb1xW7NVeIcwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTMrLp2tMCX5YrgBj1ZWopah5kwGLQ9bIUqP6GQ7R86Qf+Ls98eZL6M+oMHMdugFK
	 ZiDFQ7zdYA78rZPuMiG2O1C+WKmIzSs3iUvsIl6Jjo1ZFN4AWbATyksDCzIjaMCkJJ
	 S+/BT6SI1KcNWwkVAJPCxlTbRVtv206SKPNT8s31dmpgRJYdwpayB/d4uddaHdh61W
	 tyQhXwxCZpdmEOutdJ64kHxLVWb6s/Yav9n87oo3roOEjz8vifutgJ3iR0O3iHonqA
	 ciYnzBgiOxbcrzBaFL1s84bDKgQrKskVReHR9vhif2YNhp9qM7nSJFcMku9Ivg2ZHP
	 ourNbu2RZ+OnA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 12/14] selftests/damon/sysfs.sh: test monitoring intervals goal dir
Date: Thu, 21 May 2026 07:34:22 -0700
Message-ID: <20260521143428.83157-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing monitoring intervals goal
directory.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 1ac3e2ce8e448..b3418214ed358 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -282,6 +282,17 @@ test_targets()
 	ensure_dir "$targets_dir/1" "not_exist"
 }
 
+
+test_intervals_goal()
+{
+	goal_dir=$1
+	ensure_dir "$goal_dir" "exist"
+	ensure_file "$goal_dir/access_bp" "exist" "600"
+	ensure_file "$goal_dir/aggrs" "exist" "600"
+	ensure_file "$goal_dir/min_sample_us" "exist" "600"
+	ensure_file "$goal_dir/max_sample_us" "exist" "600"
+}
+
 test_intervals()
 {
 	intervals_dir=$1
@@ -289,6 +300,7 @@ test_intervals()
 	ensure_file "$intervals_dir/aggr_us" "exist" "600"
 	ensure_file "$intervals_dir/sample_us" "exist" "600"
 	ensure_file "$intervals_dir/update_us" "exist" "600"
+	test_intervals_goal "$intervals_dir/intervals_goal"
 }
 
 test_damon_filter()
-- 
2.47.3
