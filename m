Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E83793B6;
	Thu, 25 Jun 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397484; cv=none; b=kNSWxWTII1+Yp7OK8A1fyfDHpPF7rswHwywa31NZv/W8j9IqqkcojAglYDI9wvgSbTkLYIBfv8NtG7H8iFBTjWCZVQeqYQKwjeMZG0cDlr4ZOxAQMG3zS2tMx7DEQ6ydVN3jIQtw2H8fIDGDxjhYqnDOuRhL1q87zCAUYaNNRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397484; c=relaxed/simple;
	bh=MqS+ZHG2zkT+o5XBFF2sr1VtC8YNDSVJ+53UKoyp7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAXTy0/1/Vz+cZISXEtpXFGxcRmMe9z24SGXE5aekdLhqrn3KW0v/OTitNBPZj+Cxy8ltqcdzkBJxvpT/K3Z5lRKEsmxItf+LM1tHs4JE9DNDxcY7yc5L3Q2VOlwWHWaEnfDBODN2FJ1X/X/FL1fxTWOjFaWzgWlK1daZ7ZCmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGryyAf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGryyAf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866A1F00A3D;
	Thu, 25 Jun 2026 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397483;
	bh=61iW0clYSHE8gzHIMRcuF9jxdl/Em5VRtXAIIrwedXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGryyAf2ng06bi5XpZ80YawRPfFqa6RSfs5aCl0p1tTC1aNHHjT8zNwb3nqSOho7a
	 Zy+b+lXEnshpdxuHY5suXORnqkPzhKUKbU/kndz4vK4ZgGfvoguDyewfN2zjJzm3oT
	 rdbEY72bFqGCenBAzhJEd5fNj4SzNIo+2c6kWm2joOgMYAURtIuzsvV2+FZwY4TR3T
	 07T7HZp3sQzNZyygWhcVbx1nQxE1b/W4+vgBuNNplWgUqjLrnBYR6tGK/vij7ANwbU
	 c1OJq9aQK3xuYAnPKE52+/5FP0psSe82lZ0XUI7OBqcHXvb63PFgPhRy5Mwo2FfNlG
	 BCOUpKX2KzMCQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 04/11] selftests/damon/sysfs.sh: test multiple probe dirs creation
Date: Thu, 25 Jun 2026 07:23:49 -0700
Message-ID: <20260625142357.103500-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
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
