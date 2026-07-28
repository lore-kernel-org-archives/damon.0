Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08C3B14A3;
	Tue, 28 Jul 2026 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216501; cv=none; b=niO2N9v+4ukj/G7IGEVLYEUAmPr/1XsA7x8M09IOK9ZD/iPglKBQwUZs1QtLcA2A3819lSaPogIuAyGAezXrAZ02xMnODAMqr3lqe0bsAqNgs7uqAWRSJJP4tF7tEEJa0mWDXoQy5E754/kka+27jd3gbLtiodGozl70BW5gc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216501; c=relaxed/simple;
	bh=HbRbHRXJKLR5v8dTl/LSDMwKCFClK2aYCYBJgtV6g70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkVDwm4QjxOs4y/Y4iRAuSAED/nyYZ7ASDyoP69PtyCugsl6WuxB+ARV8BSt0jcx40AZjNRu0Fjk/CjpAOHPLOB8eUnnoYQEI2xwOEFRGSE/Iksuo2D0uUbMA5wH8/U5DQhfDu8DbJiCO2RZI5Yv/bQpXnjJyyzc1uVXaqQu5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEBuIKDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEBuIKDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F01F00A3F;
	Tue, 28 Jul 2026 05:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216499;
	bh=jEqn658128UTd1o8tS5ZjT5LQQ6f3vfRE5EdtC108ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEBuIKDuUaxyDyAOkobLWRBLv0M+5rVmn4p4GBzEbZ880A1uoT/nq+XdHLdzNb6XE
	 rGETPi6MNPer0T2vnxeOoDwHcj2ClPIxicFIuUEFFTIm4aUM8oJouaedags/Kx5qdB
	 mJGElUcNt1KAmIRo7oqCcY3vcnZAc96XWPACg8SImKRe8VYwEgrZeeEp4tFMAzDxGf
	 0/xlrAoATCmwE4r/fkGLLj0nNCg5xWlK3EkRWWcGjeqIYMyEZE0eU3xSla6Vo7Git7
	 BkTmIHaav3ya1TDYZhI6UAqwNxv5Nb99yddOPB0U1AmDerg/D/JpUZ58AQS6clFImL
	 hlRh1BQDQMdTg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Mon, 27 Jul 2026 22:28:07 -0700
Message-ID: <20260728052811.192712-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
