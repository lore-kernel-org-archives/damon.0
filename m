Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1142980A;
	Tue, 30 Jun 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829068; cv=none; b=RwdyctfzB3LLqwzTY+i1Bvu9sSLAnKWYtwf88AlI9dynZ64PCUk+q7PYYFFZfg8vEguswcMy7QAXF1/xl/Rh1AZhwrbaEnTZZt4eWZUrdZzYiAKttcgFmICo7GK1otm+wxEYkyHooAd3soulJh1BceXF+T/zV1wUtvNnIODafm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829068; c=relaxed/simple;
	bh=XIWpcFIHixSvYXZQ+SKpLh2H3jFB0SEZDqNLf57i9nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7NpgvKJu9ZMp7q+bN3C0dAuxXSA/1c8EiumnDVjF3r0v09RpfhqUvB/TVsNqWmUueiOZCC/ZgM21QkyQKduDzNfIYrYy4VYAE2xKyWjWBb+4eFfXeQc3Uhj/xi0C2YYtcqzrx35KebFBCIotr1FPJHlVv4UbZXE4Zz0GhT7ms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGDSF9eW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGDSF9eW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887781F000E9;
	Tue, 30 Jun 2026 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829066;
	bh=TdcCZC5+16+6AUY31I6DEOKh1l2S9+UDKyW2frHuiC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGDSF9eWezY7AOmV3hce+Aatjtmmvb4UhJ4cNMn+ahNooClledOIQVYD5XakxAxU0
	 jrGkvaDMtG++MkZw21q1GjavHnrDLzgzRmdWbcjF2nnL1mD6UQMiWUYvplegTiBNIC
	 TOvSzhjzn216+x3N+Jn1TjsAKlAFzqGqvu9O7t4AKK95IyDHblhteFOEi0KZ4DG9UX
	 uI7MRNuj/nwASfjt4c6jmnAX94f/8cubbslUAq9RTppXcNYMXhhnJZzIppT2e/ahZi
	 ymIplfq0Zexz9H5UhbzjplxYKWOQShp6dBtdQ0ONner488g7z0NvmwUxGgRaFSG+Oq
	 C/Vb2R2Kbu/KQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] selftests/damon/sysfs.sh: test all files in quota goal dir
Date: Tue, 30 Jun 2026 07:17:21 -0700
Message-ID: <20260630141726.92246-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index f8d2092be004d..b43deee60fe95 100755
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
