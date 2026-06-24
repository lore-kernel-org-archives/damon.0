Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C83C199A;
	Wed, 24 Jun 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310832; cv=none; b=ZK7kp3d+As2E2G1c5z+B2TG5z5RfiA8rOKKcrQMgpiKJ0i2gGCa5ad7EOhDXmp9E4Mv/c/UTbSzaECXWsiVDXPlrX8WHFGQqUZ5N7GBmuam0gEXsJIdSoTCBumdmh4FPNhdtwzUbJ5DGB7jcYPlmdY+0YzGNTxM2TPxoHYtqp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310832; c=relaxed/simple;
	bh=GFpn99P/N9LRLtNwEI7opPl+1a8h+P5eeQRRdZSds1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8AU31UVDkjtmila+hAmNlTBaCqVw6xUjuqsAMcpcXuBtbCD6MvgyH+fvwa05C2KKxnmG9zYXnPhtcqY2h1iQop5+hfyC29AMh/tiRilwl4hf8gGwjpA18UVXJw95t1HDpl/Tg30d5c3UFO1DQ1rqhuP1T3amPAFWJzQIcX/N74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPobP0tH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPobP0tH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A81F00A3E;
	Wed, 24 Jun 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310830;
	bh=PdgawUMr3ivgV/d60/KgM0WVFSSy7a/TodMtkj3Ep3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPobP0tHgNl/zXvL8PurjIsqWlC8cOWAEuMU2RDz4X4QEb5da6svPnZGw0H2bPuwZ
	 zq5CGWsT3T/1VGt3x5hL6cRgoZE2bol4C/hVmoCEqKBxWjocVpiEPIPMaBC02j7Wh1
	 c/I1W1tnhWWv9pC38rOx4fUp3MCgElrAEXCTpoY03SDGMT6Lupqbj7CvYKN0JpCTCP
	 x6EjjRGoigjmzphABjlNaKq7NnxsOE+iqGxGOn7lX9jcf3+eNDvNLJT0y+IReBTad5
	 Pgnc7nMTRSw1sSsKwLXoOntqq6bZvn9mLTG2SFWo/UBwkc06MHKHQ8u/zo0NDddpHG
	 /kJ215HGNx1IA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/11] selftests/damon/sysfs.sh: test dests dir
Date: Wed, 24 Jun 2026 07:20:02 -0700
Message-ID: <20260624142008.87180-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
index 78eea0d13c271..cbfababa0bf31 100755
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
