Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96041282F2C;
	Fri, 26 Jun 2026 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433032; cv=none; b=kU0TcNJ1iWZuTmvoYr857cA8xpVaVLmXLr9kq4f3/9lT3+98SYLyuVy6zhowbPzn30dDy/KUnVokr1vR4upGV8RWyZEQtuRaw4Wy354bub7YHXGl1XiqXZJWmFXUft6UnLxTSVaGrZUZhvmSm3G8zb0/1JODFTUIkpLeoi+zYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433032; c=relaxed/simple;
	bh=fHb9VbaQ8TDYUK1XGNrts10DBD8AJgVCDxPyLW+tB30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6tBB/wK8EPV63s7C8gCVGSaZSqd4U/UGnBB/TLKD7xyU5lDb92EERMZSIYR+XNcmvxE104U3MeQxsM5POCPv0pIkR8ZEy67UPuO1w2o6RjEwKwH2IDaIw9IbKRLDRBnp/0us5dv9WrAoULfjbvhKcnTm5FDJ9e0EWPbDjkMXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJo+Od0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJo+Od0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3191F00A3A;
	Fri, 26 Jun 2026 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433031;
	bh=J66HJiTvNrVHrkrUjTA08Y7jf1bcSRDPMBd43t60n5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJo+Od0zWitDtwwpCn4mP2LcyUeaYrd3K8v+melNtZ6/8f2m0oVagJv1OEwVWESNf
	 AogvKgCLmmkbCs95QYANYPGLKvJVWDa4DU3k8+s3gCS6nSxqBomuFU2TXlT269610l
	 liUidd3QzVwr+bPs9MY93hcTfiqRk0oqSS7KUGGVHdVzgxkF1sgNLc1Zivj07mVZ/N
	 Pg5WDUHyN4vwb2B4dUP209Of30wgoDgZmchwcuvSqlPLQ3DYlR+gdt8ua1n46JnhJV
	 AgTWiIwIa+9Re9cO/sxuafJm4yh4n8Kcd2a+2F7+HCnKGknr6IRFGqeoXj1G65z4kb
	 E76l7/Ccffu5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 07/11] selftests/damon/sysfs.sh: test all files in quota goal dir
Date: Thu, 25 Jun 2026 17:16:38 -0700
Message-ID: <20260626001644.85825-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface for DAMOS quota has quite extended since its
initial introduction.  The test case for that in DAMON sysfs interface
essential file operations test (sysfs.sh) has not accordingly extended,
though.  Extend the test case to test all existing files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b88bf7b98d7f7..811173cb89449 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -199,6 +199,20 @@ test_goal()
 	ensure_dir "$goal_dir" "exist"
 	ensure_file "$goal_dir/target_value" "exist" "600"
 	ensure_file "$goal_dir/current_value" "exist" "600"
+	ensure_file "$goal_dir/target_metric" "exist" "600"
+	local fpath="$goal_dir/target_metric"
+	ensure_write_succ "$fpath" "user_input" "valid input"
+	ensure_write_succ "$fpath" "some_mem_psi_us" "valid input"
+	ensure_write_succ "$fpath" "node_mem_used_bp" "valid input"
+	ensure_write_succ "$fpath" "node_mem_free_bp" "valid input"
+	ensure_write_succ "$fpath" "node_memcg_used_bp" "valid input"
+	ensure_write_succ "$fpath" "node_memcg_free_bp" "valid input"
+	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
+	ensure_write_fail "$fpath" "foo" "invalid input"
+	ensure_file "$goal_dir/nid" "exist" "600"
+	ensure_file "$goal_dir/path" "exist" "600"
 }
 
 test_goals()
-- 
2.47.3
