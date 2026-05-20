Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4614375F83;
	Wed, 20 May 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258554; cv=none; b=hLWztzqgcBxLhwHSrwe+p12DRbhR0DGXqOLD49IGzrXFUpNRpf40xxJBRTwWDuzPwzL4hfNm+YcxjoyQlQibFFlrU4pyZigzHkYO6z7oG6AzDB+AD9UqjArqNgnP0Wbok/susb756sOBPlQYooCgDKrosixNkuF419Vr90eyUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258554; c=relaxed/simple;
	bh=X9OlJ2prAobDVbk0Vv6nVK2KxF0mht3x911wZZmZP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brHtxalTY5DpsNBfkJMBLkss5hTcqzpcDUbt6bSxd3deMrl/ai42SazvDrAyz3gBoJRSRRr3/Q244pfm4unp41qlzIfsDTmkfop2uzJtX5xDPzKWXgOe6FCM6UZzyNOFrP82IjK2uTw6jSsO+6chC2oho+S/gJ26nUgMf9Aoc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHnW23o/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHnW23o/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1261F00894;
	Wed, 20 May 2026 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258552;
	bh=+/Povz79d87HbdJqBmb3Cot0viqAd/5mMxq8n9ZgbLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHnW23o/qxj5i4iQoUcRFLWQa0b+Ptv0FCVoUHWJtZu2O+Gx5TfdLSpApc9T2X05c
	 U7WTn784SJKdNBo7qO6EQAhnT65bROORu5FGAcWtVVDpICGyV5RDJdOfY5u8EO6Qi8
	 aMzO22HYiLZOYXhAd5lFITuUDHWCMW9Loo/IYW5Wwz5UF2dxVSovCg6NA1CRZZcLQL
	 U5UfFMb2KHOFECwGoBOIGEUvQQe6GkjuLMB2pJvnjdchxaSJBzo4+jnJIcwmyQnCW8
	 jh9u+aRd8v2828E7XHVq8mQK+Q5FDY9HR/xFFIxwTuV5FNqsyyMYS9JpXWA9lFXXJ7
	 YXJSQiDoBeFVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 14/14] selftests/damon/sysfs.sh: test pause file existence
Date: Tue, 19 May 2026 23:28:46 -0700
Message-ID: <20260520062858.167011-15-sj@kernel.org>
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

sysfs.sh DAMON selftest is not testing the existence of the 'pause'
sysfs file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 1e10881afabb6..ae002dd3c0797 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -366,6 +366,7 @@ test_context()
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	ensure_file "$context_dir/addr_unit" "exit" 600
+	ensure_file "$context_dir/pause" "exit" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
