Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FA2EC57C;
	Thu, 25 Jun 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364102; cv=none; b=iXCUU0JUO+oTjIvXlljDGwiV6CfLc4iXoy58F8kZDXpStdtEWlATGhOuwpm+7rc313Jbr64tvBH6qkjB6+wgOCjvcty+a4bt1U0ADi01F08nc4jVyVPl7aNuoc9r4AmHfntuVVBVW9CByDzEdcC1B5qc9y3vKf4JwcTitlIrYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364102; c=relaxed/simple;
	bh=mM19ffUFzj/+BJnJCXB8ayH89UMMGNj0eC581UymSQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqKfl53ovii7Wo3JdS010ukyyMg4V8froRLi79OmltIdHCHbLyrC4KFVXNCBLcaLZ9NZ/zO5y4P2AiMo+ElcobDpjAbGQIPsCHiOs7la7X7885DztRbDNb0pDC0Oi82wy9ZoGanWaKne4+yGQCipTsD+qFUB13JAmGe3hct5df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXmjOlvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXmjOlvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EEA1F00A3F;
	Thu, 25 Jun 2026 05:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364101;
	bh=cdSH2MRv6NGKB8iMyxrijXWFPfgdd88XHA0wpbHvk+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXmjOlvoBSA+R/FxQs4eki71+5iBL+SrEZNBykwv30cCMD2KdzmCY6D13T358GAXk
	 wFftkkPcL+zHZ2eE3Pc0kB/+XdzIa/bwxB4RPy58lXSKsbVeqUK4sSX91a357wzw1S
	 QA9eqi5ZqGWwKslc1rpm2jJTtnqCCR2YGFTw9VF4xptS9S9J8468OrBH9rLXaR4PP9
	 NSSrY+rK2GnT/hYOXqY1IBromG6qcMxS+9ZU7ZoG7C4by7T1MR0CXvhbO5jm11CnFg
	 Bm44d8jZBJtH38FneAhYjVXu4f6zowXO326b7wP9Qyz0vAUjiFv/isVLApFYgcbnJ9
	 BUkc0NsbcE0zA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/11] selftests/damon/sysfs.sh: test all files in quota goal dir
Date: Wed, 24 Jun 2026 22:07:50 -0700
Message-ID: <20260625050756.91115-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
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
index ffa8413b5ab3d..15fb9df928818 100755
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
