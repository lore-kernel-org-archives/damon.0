Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3404426D11;
	Tue, 30 Jun 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829065; cv=none; b=rGF8+5eEV0g8DPRIGqzsy8iUaO5GwIKddCUrMQbGHLLe/wjkqTzxDczmf24NXd8qRf23enGeCvBu+oDJyv9MiE42PbD/U1kjxNRksNCPtxsz0WFLjCa5ekT5kUgV8i/4iEAlHD0yEXEzhTzK110QcShWT7xT3RfwaWlXoBsv4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829065; c=relaxed/simple;
	bh=RFY6iRyzOVJ3fXqN/6SHlCoC/vww/Y5VJuyhAWiw/Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaq7hL3UwAcUtJE9gGdmCKLgphIzoG0F2eP5EJtDcnIGHmyhnsWoKKF1/UdB1DGRyuEhePb50+HBrX428lCpCgXJ3x/avxQwZcFBI90FkE2OKLdR+gzHIyV3WSypc6aKcXDgts6yTeVWP2uQfTtyf26STiUdHvAlAuWxIiW3d24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATUnj+kT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATUnj+kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5661F00A3E;
	Tue, 30 Jun 2026 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829064;
	bh=WEUf8F4RbIBWLyJQ2G3eW0zg3VzyVrhvSny1dfTtixY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATUnj+kTdpVkQ41lxS5ZrlHQGxJMnNnG+8ghrWnxxRmbKnJ6R9n5SFAGEEclO2/Bi
	 Uhw7Q8f0ad3pFRRZL0qCN3X6v0NwDTdEpsbbVI2mP3R5USOpjt+2vzDUexqLgC+7U0
	 rrd1X5jndbIXs3cywSOrn98mRQsuZq/p+nGyW3bPwol6kk9KItXz5YiibNXT8bhLtm
	 70Uq1cAZRao9kA/n4hDfaP26XX0Fd5J0tfFcqaKJcMOUSC8HPOnSua9GnWfFpX0d2S
	 AII4ktWw9oybqVav30+mDS1sq/Ikt1Ob/ZWgR6CY0rHgNHPBCFihaOGN2tbG+AnRNp
	 f4UI/8qM8RdzQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Tue, 30 Jun 2026 07:17:20 -0700
Message-ID: <20260630141726.92246-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON selftest interface essential file operations test (sysfs.sh) is
not testing DAMOS dests/ directory.  Add the test.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 78eea0d13c271..f8d2092be004d 100755
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
