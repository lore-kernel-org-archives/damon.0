Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4E38E5FE;
	Wed, 29 Jul 2026 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296284; cv=none; b=tXkucShxco5DPjeA5ZR69412L+AgonUlbu4rmSGTyDwrnZTdsBUhb+rK0cTPbru3suItwKSYvcieI4cOjKhZR2RMfbw3atxQHDuku9LCUeU2RfNiW1wtjY52jrmML9jIuNgOjEHOMnQE2D1Ts0htEH435Srk1P6CaMdPkAn02E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296284; c=relaxed/simple;
	bh=HbRbHRXJKLR5v8dTl/LSDMwKCFClK2aYCYBJgtV6g70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxTcxUFjPUrBV0lgmk8H8e6um3uNRZMLnFXWg1AamRa5/HRXJt4WhIXkBMG07NSoocLj+dN3/4AHZhKCljHMdflcJZxd9DjdCYq9UBZg0ZLEyFL0YbjxmuTvL90MVD5bStEfvZRIfvUrlEx7JT8q4o1xdxilD00odjpQrf0IOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig9CTfU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig9CTfU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFDD1F00A3F;
	Wed, 29 Jul 2026 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296283;
	bh=jEqn658128UTd1o8tS5ZjT5LQQ6f3vfRE5EdtC108ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ig9CTfU97OBq4zVNbM6XqpVgx0xnThrpvyyRFnjKW4og7xcTPWcxaJZk7pRXE+SEQ
	 hPWqXnTHKx3W7Dd71f/xpBxcslhA/gycb7BzebBkvxdgYTsMZF9FB/MswcBP6Mtoss
	 Ka1X13QsmgPJe1W0pfqnMWG99gJ4xz6bRgzqFCgUE5G8Wh6rR/+a/QdHD8qdR2NICP
	 wbNrBrfRN5quTX4i0eKQOgtkjGYOdtSq7ZFfweP6eJk9bakyiO2m4bzvY6pB57oM4q
	 3kNb21M9InOa7XR54r+alNwe8Hp6QFM+9UuIIwg/wn9vz0znPLPnmt676qXIjHJ6bT
	 BsskY7+4ZCygg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Tue, 28 Jul 2026 20:37:48 -0700
Message-ID: <20260729033751.131213-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
input.  Test it is accepted in fundamental DAMON sysfs file operation
selftest.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index ddebde6edabe4..b66593c9ac471 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -210,6 +210,7 @@ test_goal()
 	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
 	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
 	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
+	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
 	ensure_write_fail "$fpath" "foo" "invalid input"
 	ensure_file "$goal_dir/nid" "exist" "600"
 	ensure_file "$goal_dir/path" "exist" "600"
-- 
2.47.3
