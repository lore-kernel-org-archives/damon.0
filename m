Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D449483D;
	Mon, 28 Sep 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588043; cv=none; b=f160hGm0oUuWA9t8XmN9doqVc4xguiDZunYFC3i3VUxTSo/UgtP0wYxG7kilD9BZv9FUEo7bFkB1WcrPo9M8s5lweIVuCMBSoIAPPJ6zBAnz6kXy3Dc2EsBovlJ5l+sHUqYl7vUjEGJHh6iIizTDnLcX8LsO5jyjdE8OiUyzcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588043; c=relaxed/simple;
	bh=yAHSTLK6E7yxtonsXZxAHG50GPGhG9jkUhqfr21mLKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHAcPn5JrKWNhBcGAM5MZ73/2AtGr0H6kOyMCi2YMNeZYpskN+cnGF0nFEqUcq0pVT8dCTZrprGP7FpPnTv+vDb4vz0u7i15x7iT1sMBTpIAjjT4+PLw98oaR2M6HQhUwfH2PEA/0IOeBh868P6L2vM1T1nhn07AjcSIi1GOCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9E6n9xV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9E6n9xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01941F000FF;
	Mon, 28 Sep 2026 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588041;
	bh=p5MTFE9QQQXmql1Ff0uVbm3O82yXZG24baiyBpjdw2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O9E6n9xVHmI4qghgOJVq+/aVaJ3uVPG9P8GSDc9kmo9JcGqxlY1Qe7rFkowHkSL5D
	 jzFIwR0AdtIvjcA/8qaEyXmibfWE5wV0EKbEiv3CNFXa4W7nXpaO0Kh7Oor3ZFXU1c
	 elEye2koBx7wgPTiv65iQVyvam9fL187swWSNO9E3G3fY6l01uckAB8gTy8Dp7TY/X
	 wzGFDybTjwSC8Y5K++v5AXq5078d6oGGsbiRQFE3oM0XM8wZEWXk12JUQ9bW2LKN94
	 Uhmc7spOd/9CQ5WwC3M+XjuBGGX97+FYuoHn1XGgBUJ5Zp/TL2iGjHuQgsp7H9FTmH
	 MLZjSlb5byjhg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 5/8] selftests/damon/sysfs.sh: test quota goal complement flag file
Date: Mon, 28 Sep 2026 02:33:37 -0700
Message-ID: <20260928093342.16584-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the existence and the valid input acceptance of the newly added
quota goal complement flag sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b66593c9ac47..1cc7ab2d7e22 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -212,6 +212,9 @@ test_goal()
 	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
 	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
 	ensure_write_fail "$fpath" "foo" "invalid input"
+	ensure_file "$goal_dir/complement" "exist" "600"
+	ensure_write_succ "$goal_dir/complement" "Y" "valid input"
+	ensure_write_succ "$goal_dir/complement" "N" "valid input"
 	ensure_file "$goal_dir/nid" "exist" "600"
 	ensure_file "$goal_dir/path" "exist" "600"
 }
-- 
2.47.3
