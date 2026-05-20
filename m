Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C129377563;
	Wed, 20 May 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258554; cv=none; b=GXnSBAp5Pf3ZPWMZfxZ7+CoSiy3kn+EN4mj7gT5/2o7QQFiyits0DDEzoz0VNUYT0LjVWbB9YVc4YUI5Xeo/Y8vYhy/8r2guLbiAePchYgn/TPeiJRtVNAJuTERehpxsRKZbXytCFk3ZGYzXABjXrzKwPa6+jy+qdqFTP7uK+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258554; c=relaxed/simple;
	bh=oKcvWEBB+phUNHkRtIwUr8T3SKEiRgFEfEgx4EAVppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrvi/dp/RYbWiWG76rVeN01FEF0EPE5jgCZrruHMwgd92hW+BWpL5nRZTTu+nBfL48S1hp/taGh8n2NZi5k6cO1IEXT5/GIUHVgBXDo7VcV9rwcOgEQ7J7EndJsSeLJnTJEoi4E9ZBm5vA8VY4x1cHo4GbZzh1tNdYilapK//Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgZ50JOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgZ50JOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213B11F00899;
	Wed, 20 May 2026 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258552;
	bh=c7A3rUBWM/Djhjjd8QeXCkcV9IZlc4S1Vf3PBEQN5+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgZ50JOeLiEuksmomVn2DwKHg94AZjDsM/IsCr3VtY03zr36FdeD4Q/LXTinb6HwO
	 2/UwulH0bEXThMrdWXxhdIEmGBkmM2BrBHTt0wtzro7wEi9WOLmcpSxwM3s2yEos3P
	 bK+QfuctqcaejPwfxNm1Q1HHisvTvFFPnB+Pu+PiJPcSLp0TTCOPhzm+9P0++/bRAQ
	 MjqesEPk9hsm7j5cP3Mnc+BDyznNJ/KtIdzfhuiFeFlju3zg+ZYw4WxdSlaQ2xgLjE
	 wjgRakEo8MdiRY9Fbb3oU+giBP6faVa6tBkluW8oO2rP+gcog2pP9lVpg9GrY7cR+u
	 oCj2LRGqgMb8g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Tue, 19 May 2026 23:28:45 -0700
Message-ID: <20260520062858.167011-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing the existence of addr_unit sysfs
file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b3418214ed358..1e10881afabb6 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -365,6 +365,7 @@ test_context()
 	ensure_dir "$context_dir" "exist"
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
+	ensure_file "$context_dir/addr_unit" "exit" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
