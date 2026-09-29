Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEE3B42EF;
	Tue, 29 Sep 2026 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668893; cv=none; b=iJ3JGWdlCaywNEXiCF2b3NPMWDwt4XE1nIZd+KZH4zyxR/vP9sBQ8Z5gOpvaRoQJAnb1itzukTrkGOTM6CnJsBNJ/0kaalGOFic2a4ImJ0KxeDfr3XInca5Kd2Phy+gCXqa+MbycPuZnFS+YF0AKsBmmZ00e4XRZY7bXJHDM4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668893; c=relaxed/simple;
	bh=yAHSTLK6E7yxtonsXZxAHG50GPGhG9jkUhqfr21mLKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4dLCu5pbAd39xpmGX7z4rXfwxPEiypSFKSkpvs+Lx1UyVCIcZsDbOn/Kwnf7+DWKn6bgtNuqKd/Rug2wjcMn3K4PrT/o3p4VqoWnuMEgRCNyN9x7Aa5ePqU8kCw8LVUmaQCWlGKK+pzx+eVb1XKvzgrwWolN/rq9AwI4I5PyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSnpH1JM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSnpH1JM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F191F00893;
	Tue, 29 Sep 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668890;
	bh=p5MTFE9QQQXmql1Ff0uVbm3O82yXZG24baiyBpjdw2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSnpH1JM2kjxFrFhZEEdGQLnXTe5L3po33HSo50kOWWKDntUB5CC1VCBLe3pK1fj1
	 OesJjjjzMVlpx6QF9Yh3yoYIfLPReHsonNofbWRi8i7SareKzMfMaCehKAspL2A4Hw
	 TWDOi2ISRsc5Sx6V4n3zh+EjA1H+9a+q/5KS5VVX1aJKMeGLgtgI3TWRAsYIdyEoVa
	 r0khulDsgHlbykBniD2OQUV2UlnIc0BHtlpXkaNINrNnpRO0+SgnoA0IE+3GQxdNVP
	 w7pPOiGEAYjM6rpMqrJN9sJA7uliClKHo0iU/nltPAA1tm97208lD+LqhG0q37m1Xi
	 9X+HZG8g3DwzA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] selftests/damon/sysfs.sh: test quota goal complement flag file
Date: Tue, 29 Sep 2026 01:01:08 -0700
Message-ID: <20260929080113.41708-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
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
