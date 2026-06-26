Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F02949E0;
	Fri, 26 Jun 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433026; cv=none; b=iyTta7uB4m5atNHeufVR5TI2+lsJkENLerjUPiMpLUe9A8MCUKyCz9XqsqTr1XZX+GO7+OncZx6r2TFN9C8dQQEMZyPJUwT/2U6zKUxGu2OVmY92BB9jQx/b2Q/B07BSkRhuCJhndeqPDJ9KHpk8uOvQdvGCSxDoWqwUvwspC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433026; c=relaxed/simple;
	bh=MqS+ZHG2zkT+o5XBFF2sr1VtC8YNDSVJ+53UKoyp7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG7l9FwfZRe3oPlo3qTAgByToUo6npPNVTshc4SKn1NsO8muC9A8bJvPzqLrVuyLmMoDPpyu5wL5BDBPr9jyCMuE7Ob9A7h8pZBXHKu50tEAqncVhc4h9UQHbx4PDondtZRLct7gqayVimK8lSfHMeOOcyO06a+9UL3mtZCeHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ+BQUVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ+BQUVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B001F00A3A;
	Fri, 26 Jun 2026 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433025;
	bh=61iW0clYSHE8gzHIMRcuF9jxdl/Em5VRtXAIIrwedXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZ+BQUVamR1Vt07epvnrnuCcZuBm2nX2Gxts7PodxZ61o9F3V4cP7IVBGLuv8W1op
	 0SJLOFRESTADPdWubbgrymXNz7UfGCNQTTAfo/Vo1xDKIFvQCsGqMz4ryg/rGxkEFE
	 BMwqNBPu3ysg5rCCOPT/v1nns0z4C51mSJWZy3bZ7qO+bjMIWqyTr5lCXz2ghd4Rzm
	 lEaeYsa6ZpdK/gclljobd1LIkO7OENaVEnavKIi6H/+uu3BBnxaXwPmWr/SG9y9+by
	 iHrEbRxlB3NtCIkCsiddKrAxqb1DoAjSTuEJfVUPFJhjADPVJbd/vV5EUOzqIVNN4M
	 xUEiascwFyCcg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 04/11] selftests/damon/sysfs.sh: test multiple probe dirs creation
Date: Thu, 25 Jun 2026 17:16:35 -0700
Message-ID: <20260626001644.85825-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs essential file operations test (sysfs.sh) was extended to
test DAMON probes sysfs directory, by commit 14885da09b0f
("selftests/damon/sysfs.sh: test probes dir").  Unlike other DAMON sysfs
files, it is testing only a single directory case.  Extend it for
multiple directories.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 78f4badb5bebb..0f2ef462a6b6a 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -346,8 +346,13 @@ test_probes()
 	ensure_write_succ "$probes_dir/nr_probes" "1" "valid input"
 	test_probe "$probes_dir/0"
 
+	ensure_write_succ "$probes_dir/nr_probes" "2" "valid input"
+	test_probe "$probes_dir/0"
+	test_probe "$probes_dir/1"
+
 	ensure_write_succ "$probes_dir/nr_probes" "0" "valid input"
 	ensure_dir "$probes_dir/0" "not_exist"
+	ensure_dir "$probes_dir/1" "not_exist"
 }
 
 test_monitoring_attrs()
-- 
2.47.3
