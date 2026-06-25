Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CF2D6E44;
	Thu, 25 Jun 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364101; cv=none; b=jS9dg2ApBxZPZ/3a/KDkd2Ecfs9QROt8aH/i/tWhNaHNfZubb1NRF7mb7TglC3janR7ESkEiK42TiIJvDgCPuYrjLm8ZpzupfMpzVNu0CpZ/Xac2iWju/qzlp50AZ+GqQ8mOKhJm8SVZZ/y1OpW8oL7OPCoIZue6uCZxqh9t2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364101; c=relaxed/simple;
	bh=irUOTcJDS40kj5q2PmLr/HEp0tTGrG6+foGChxwm9VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMc40++g1Nz7iyukO7ZhXMLpqm4D44XqfXy9dkLnf7H7AS5+w9osrma77kndxDymm2CJFtc/R2/X37WhJqTKr2gAOYBWnLjZuwvwstIP+ieuEDqfBFfS+1CmjrZn3hvuSQ8QRrmneCeHl1V4MN5O4taORZLJfpLsqg+/UnProLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaJRpyT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaJRpyT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD611F00A3D;
	Thu, 25 Jun 2026 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364099;
	bh=L4nqp2h8NJB/cbBvBAnNHXHs1MQz+3ybtLtYTB71w34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaJRpyT44V81xCKSMTidxJDBudtkzs0adTpZz0z6TI6CjpWXHsz4nupNV2nb01PiX
	 Av2+3po2X7I+mjhqUpmmH4y+mag3GZt0pjo0bPuCxl24jLqnorytIlqbRubMrd/49E
	 NvosAJTM6cIwR/mkvVhwuDIsCLSWf87ADzaePkwHKbb3sXFXgrRc3rFZ3z4sU2OrRY
	 23AodH2CxfINTr9tANFA9zzmg6PAdOBc0ctcLVFCrgTYqHwfPgz70RRacHqz2Z7o4r
	 JXoqvJFqVB0pC7KpbxwQG371NDseDp+ra6eqLNOIdMHGKmkeid0jR6w42PhXgsW6Q9
	 XXLx3I/bne+Kw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Wed, 24 Jun 2026 22:07:49 -0700
Message-ID: <20260625050756.91115-7-sj@kernel.org>
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

DAMON selftest interface essential file operations test (sysfs.sh) is
not testing DAMOS dests/ directory.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 07a33995be852..ffa8413b5ab3d 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -99,6 +99,29 @@ test_stats()
 	done
 }
 
+test_dest()
+{
+	dest_dir=$1
+	ensure_file "$dest_dir/id" "exist"
+	ensure_file "$dest_dir/weight" "exist"
+}
+
+test_dests()
+{
+	dests_dir=$1
+	ensure_file "$dests_dir/nr_dests" "exist" "600"
+	ensure_write_succ "$dests_dir/nr_dests" "1" "valid input"
+	test_dest "$dests_dir/0"
+
+	ensure_write_succ "$dests_dir/nr_dests" "2" "valid input"
+	test_dest "$dests_dir/0"
+	test_dest "$dests_dir/1"
+
+	ensure_write_succ "$dests_dir/nr_dests" "0" "valid input"
+	ensure_dir "$dests_dir/0" "not_exist"
+	ensure_dir "$dests_dir/1" "not_exist"
+}
+
 test_filter()
 {
 	filter_dir=$1
-- 
2.47.3
