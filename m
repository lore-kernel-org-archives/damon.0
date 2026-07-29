Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330794C0402;
	Wed, 29 Jul 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333788; cv=none; b=oiGE16ROhbIEN/lbbHcHR/qw/6WY5mxEw/U+WTjjxXvS2v9AxWJqEVzLX7PIALMTlkeoxWMVbXXSDH5p6a8h54ovtpvavSJjkZzsB7lQ/EQy8RNwCXfZEL9Y8cr3rKuCLfc7WfeAYZSn/mOVhMZt7kJLA/i2gar3rEOJyYOSqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333788; c=relaxed/simple;
	bh=HbRbHRXJKLR5v8dTl/LSDMwKCFClK2aYCYBJgtV6g70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/vt1fncJQbObF8WDpLZJxaqg9LceLdtYaFf40qYt+PGzx8lTwTBkKrjrbB5RjMqmyUNyv1KNG2MEmnr7e3OBua1PwXNsZAtKDzJWgZr8lOSrzcyyWT9286IuQKbWficm19hsxCDfnhj9v0CM5QuDVxbqey1XAiB2AndKAn8KTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw+/E4gr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw+/E4gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22741F00A3D;
	Wed, 29 Jul 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333787;
	bh=jEqn658128UTd1o8tS5ZjT5LQQ6f3vfRE5EdtC108ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yw+/E4grNeCMXyJBO2KQzsD4f+VuF6eaeMYWnb7rmvO8pq4dW6QsusVWRKFPyQZGf
	 Zji+b2huez+ljWXt79eKvWasM8SkDim8lM2ejpcTv+HL1HBBDdgOnwIi7nFN3Lepn7
	 s6Aa8DQ9y8H5mAvxv8iK8zyHqJ//w63y3JuqZhST9cxSIAuAs3qfhgx4htht4r2IJG
	 HP2+uaiUPEz1cloqzLEjRaLrU28qlSTy3U4R/A6Lm8FV6l/J7ZPJcY1gaffJGf4oKo
	 VqM8oW05WJTqe/zc7kHIeV5sMkeq1BirACendrtV+zNebv5vvZH/XwDJSyh7XrMBHl
	 x5zpIZCmD3j3A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 10/12] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Wed, 29 Jul 2026 07:02:50 -0700
Message-ID: <20260729140253.87753-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
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
