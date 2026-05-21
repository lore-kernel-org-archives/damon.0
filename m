Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87454384CF2;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335646; cv=none; b=lkYlw09wZzGWLJaQJ70ufgeJUbzlsho/T5rqg2bow88HX+lSDq1cWa0XAKE4ng2AjlZDE8by7REXFvAStqPb7ZjIbBm++X5+u0JU4RC1aAV25r5nVYCgGNGwHaNxsj9USlEQzua2yDW5ba7DCFWDQdgu9F0dE9sF5gvOv6SULQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335646; c=relaxed/simple;
	bh=4Z9nDEpElV7CLHeQzITxn/6P2S9ErV3Ie4yqUQCoJI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9CBzg2Usq2fty8QaKErqFXJ1WLF/lFyST4EG42MQCs0FkpB9T6CxTNEojNETV2gcJSJTwvFZ0wm5OoFVOXcrnMmiD2tH6qD4hYjEAgfGjlqR2fB0MHQurVLIA8KNVAqCdBcpJioW+TZZIS0aNmENJH0nzwNhowxuBCRsFGqrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPAyD8Nx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPAyD8Nx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EFA1F00A3B;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335644;
	bh=9HFBKYb5cdZ3muhhdyyxDCFvE0VgsBfb1xW7NVeIcwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPAyD8NxpIzSJ4uA7JAYIYRePUtprXVTVZDcK+8kwdINVjv/zm3kv7kL+j4hV6pW0
	 EEjXTeFMj6pCLkL0CdJ+W2BsD8L5P692WGuKufJwUErGLYfDFhrFz4CY9pa9/vkOSg
	 6tXmKTpGESqk6H0ac4lnrMkx2jh0PvmNarMTpnxw+Y6PxER8UCfYgKAHwO1k4JACKo
	 GyyfYc3ampwEYLbwNRYNnrCpaxkJOPe6OnlkpZOzpIT4L1iHd299a801S9nw3eyEWL
	 tx+kajdpdVyvIc3f2hzg0dqbDCEmmZjAvu+Kf0jrTiN2hHco0MSBFX65kEp5eGdfcA
	 684I7KLlsKvyQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 12/14] selftests/damon/sysfs.sh: test monitoring intervals goal dir
Date: Wed, 20 May 2026 20:53:46 -0700
Message-ID: <20260521035349.87565-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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
