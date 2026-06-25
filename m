Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39937BE6F;
	Thu, 25 Jun 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397488; cv=none; b=njxLWNHOLG5PoTnmKhcY1vFQ+pM2OoIgHz6hqNl4YIyX4YQBx5nRmdDcreVPCMEaFGOqsr67c6QPLko0Ey3SPmoK8RXYaS/2EjhWhhMuBviFFdOq9tUd3bRHAV7uGu3gmPy0zoeffoLNyT68lnUG39tdyUZsu3meQyVdncU6piA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397488; c=relaxed/simple;
	bh=N7WvedTBMklmHo1vp6OOAC/i/G3ERHhKPwYJJ5rfwgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf5I++HPg6XFcaK5n8aOY7WTlVZHEPE8TMoDl6QstXXlGG1DyX7qZbMa3SBXLHAm1kIMBUYqG0VJN8VJbSHIGgyCDvXzofryKG6n+yBAhxZAHClMfgytZyG2V4MIcKFADIlQrkRFbTXUTut/i3DXJo9dGJp7IDuBDsXFjyXxZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9ctPnAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9ctPnAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433FD1F00A3E;
	Thu, 25 Jun 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397487;
	bh=/qRUF8cwtcmB/nbdsXtxrh3TaDK04SACL0YdAxUm/I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9ctPnAgNruQsg1P3OCp65K1hjfuYOg8XROs6iQaZxmqH6lbJueikIkaIvaRMW9xc
	 KO7w4pF4xxofoOVrRfCArPziWcDBjTwA7zPK47qOt1HzMxzeIxsSURB4DXdPzlf67g
	 N0SVKp7M/7gSE+r21yHNJDLmw4YVOMCHbJBM+NfDYiGe7+rHaLgIbYpj3TjiAQ7vwe
	 Rei3qEfOhQ50CIFonOPziG+Jdmmm2uyZOJe7LiAls+6g2Snt3FVQ8RazIy3gch775I
	 6z6prJYjCc/6g+TGAiXQJLx1fNK2a1h6zJOdJ0HcipJC60HGpnNbj2Q0ytGAlaiXEy
	 iWdFxUevtADLw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Thu, 25 Jun 2026 07:23:51 -0700
Message-ID: <20260625142357.103500-7-sj@kernel.org>
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

DAMON selftest interface essential file operations test (sysfs.sh) is
not testing DAMOS dests/ directory.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 07a33995be852..b88bf7b98d7f7 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -99,6 +99,29 @@ test_stats()
 	done
 }
 
+test_dest()
+{
+	dest_dir=$1
+	ensure_file "$dest_dir/id" "exist" "600"
+	ensure_file "$dest_dir/weight" "exist" "600"
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
@@ -225,6 +248,7 @@ test_scheme()
 	ensure_file "$scheme_dir/apply_interval_us" "exist" "600"
 	test_quotas "$scheme_dir/quotas"
 	test_watermarks "$scheme_dir/watermarks"
+	test_dests "$scheme_dir/dests"
 	test_filters "$scheme_dir/filters"
 	test_filters "$scheme_dir/core_filters"
 	test_filters "$scheme_dir/ops_filters"
-- 
2.47.3
