Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9F376BEA;
	Thu, 25 Jun 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397489; cv=none; b=jtsmdy+5aL7lc3DviYNNzzzsKJMFMRIqVlZJIjpilOD86ZJ6J01IzzJ4FmrqHEK5NG9FXMsw42utTlVcjXNgA7jym4rrbKqMLGqPF2Jz6WsoF+XQL7ZqCnLd5KeyY/ek+Ap9kVZHL2i5yzUTd9ecqNCLMJDK/VX0JgD32qX7z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397489; c=relaxed/simple;
	bh=fHb9VbaQ8TDYUK1XGNrts10DBD8AJgVCDxPyLW+tB30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD/1aISRZiMEAsXFz/nR2QFzCq3FWPhlJxCCb9zlIw3rNECNH5eUVaOS++gl6dS3QHTEiW86rt8jvnjNw/T7aqN84VVA9TlPBNBuDe3gvfSyeJl6MTwDZLCMjPL4jx2kagxuW5mtYCu9tQto8qXuTFa4HoWduxijWhhMsuL/3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3+fSQTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3+fSQTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5861F00A3A;
	Thu, 25 Jun 2026 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397488;
	bh=J66HJiTvNrVHrkrUjTA08Y7jf1bcSRDPMBd43t60n5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3+fSQTgf2dsmDo2ZngoTY4swijX3RY43LlVRbyAl0dyCOxRmV/xYh+6SSkgQwnAT
	 ocS6+acumB/yrCEbkl+59QfvUBKDEQ5a4k6sNhJ9c9+Z6cRnNEk6aehYJsTuCB6Mhj
	 KYqO7rW4qg8bdmAs/a5pRQsK1/8TqIGSQcFAPKybmBgTR9olvhjdHNWHNzSLaELcuO
	 40yM05lmWPCnPG09SPK8HyqSFq6A0f1We3nNwM12KeYjJxkOX88w/i8SG77IGCEEoL
	 JJoVdq5vA/Pwyy6wF4afH//uW5+34mGbegbTfd/NU8TQlKlP+DtXcyMx/OPX5mKLfo
	 2Hbd9E8mYi5WA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/11] selftests/damon/sysfs.sh: test all files in quota goal dir
Date: Thu, 25 Jun 2026 07:23:52 -0700
Message-ID: <20260625142357.103500-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
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
