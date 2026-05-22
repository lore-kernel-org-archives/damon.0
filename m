Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4D481666;
	Fri, 22 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464441; cv=none; b=SUoKg3jfYOdOyw9t63dUMhWs2kX9t2IfcuOJCbeQosdsQZbJQM4p9hib2vYwgxTbiDfCaEXo+FcUWaDgbKnVccrnUFlnlun7v4rvXh/neFPwvLESCSGjOnRWOqfRhFL7tQmI+BKL3G/v+e48vrlXL1itBCjWAT0tmSjLiM8slBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464441; c=relaxed/simple;
	bh=vlSxJq/mZG/PC7FG4BVhxJBrns4C2X+9/1QoBF2tbHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0nO/4OHjMeAQghvsri/LF65fQivBWShRyaT+poS9173ZZq0r52rW8aXa1LOrCld4WvaNS0G1zHoqZaiPHX7v4GclAOorI+4DqjQyNiGCdz4T8K419ti1Lmfq2h6vm3WX3dq3EY18KD7uU2hFn3y963HBVxIrrE4C9wmodWuuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChsT2Yfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChsT2Yfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E08C1F00ADE;
	Fri, 22 May 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464439;
	bh=9Q+fxjZuCnosHblIbwlECkpSubPFTTaxfUpkwZ9ZxQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ChsT2Yfn+ODS1uaG7sqj7mrAPStXFayQ79napPt+xO0tW+zLvsgSOBUwpIi9dSC4l
	 KdkNjot3hGrhxAtESWs35/ke5dM/Zw3b9SHzBaIiG7b94KPU1UXLs+v9iEUORIEKO9
	 7dJIZLQcxpcv7Dq2FM2gPN7uddIh+DwTOjBWD0Evly4/Jzixw7aZo31yVa9Pz1xlee
	 MP2c1H5qXU6f8SaoGA8JLF2QUVqIY5KUdSrvVxUnyQEoMw9qBd4ugJ2wT0PREtXHqj
	 hWb2IjDFgy+4JkXrUctEAN/nYP53mrdjK1aek9SaAAq7IPlaDdUKQcNZhT3OA7K1vj
	 Bu7oZNHwAKSvg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/14] selftests/damon/sysfs.sh: test pause file existence
Date: Fri, 22 May 2026 08:40:25 -0700
Message-ID: <20260522154026.80546-15-sj@kernel.org>
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

sysfs.sh DAMON selftest is not testing the existence of the 'pause'
sysfs file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 92b44c86818af..78f4badb5bebb 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -366,6 +366,7 @@ test_context()
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	ensure_file "$context_dir/addr_unit" "exist" 600
+	ensure_file "$context_dir/pause" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
